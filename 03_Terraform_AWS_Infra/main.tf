terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}



# Module Network
module "network" {
  source               = "./modules/network"
  network_name         = "exam-network"
  vpc_cidr             = var.vpc_cidr
  az1_pub_subnet_cidr  = "10.0.1.0/24" 
  az2_pub_subnet_cidr  = "10.0.2.0/24"  
  cidr_all             = var.cidr_all
  public_az1           = var.availability_zone_1
  public_az2           = var.availability_zone_2
}

# Module EC2
module "ec2" {
  source               = "./modules/ec2"
  instance_type        = var.instance_type
  subnet_id            = module.network.public_subnet_az1
  key_name             = var.key_name
  availability_zone    = var.availability_zone_1
  vpc_id               = module.network.vpc_id
  db_name               = var.db_name
  username              = var.username
  password              = var.password
  db_host              = module.rds.primary_db_address
}


# Module EBS
module "ebs" {
  source         = "./modules/ebs"
  availability_zone = var.availability_zone_1
  size             = var.ebs_volume_size
}

# Module RDS
module "rds" {
  source                = "./modules/rds"
  instance_type         = var.db_instance_type
  allocated_storage     = var.allocated_storage
  engine                = var.engine
  engine_version        = var.engine_version
  db_name               = var.db_name
  username              = var.username
  password              = var.password
  availability_zone_a   = var.availability_zone_1
  availability_zone_b   = var.availability_zone_2
  subnet_ids            = module.network.public_subnet_ids
  sg_ec2                = module.ec2.web_sg_id
  vpc_id                = module.network.vpc_id
}


# Attacher le volume EBS à l'instance EC2
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdf" 
  volume_id   = module.ebs.ebs_id
  instance_id = module.ec2.instance_id
}


# Outputs Globaux
output "web_server_public_ip" {
  value       = module.ec2.public_ip
  description = "Public IP address of the WordPress web server"
}

output "primary_db_endpoint" {
  value       = module.rds.primary_db_address
  description = "Endpoint of the primary RDS database"
}

output "secondary_db_endpoint" {
  value       = module.rds.secondary_db_address
  description = "Endpoint of the secondary RDS database"
}

