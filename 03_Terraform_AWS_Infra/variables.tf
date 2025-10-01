variable "region" {
  type        = string
  default     = "eu-west-3"
  description = "AWS region"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = " web server EC2 instance type"
}

variable "db_instance_type" {
  type        = string
  default     = "db.t3.micro"
  description = "DATA BASE instance type"
}

variable "key_name" {
  type        = string
  description = "Name of the SSH key pair to access the EC2 instance"
  default     = "exam_mahdi"
}

variable "ebs_volume_size" {
  type        = number
  default     = 10
  description = " EBS volume size"
}

variable "cidr_all" {
  default = "0.0.0.0/0"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "availability_zone_1" {
  default = "eu-west-3a"
}

variable "availability_zone_2" {
  default = "eu-west-3b"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Allocated storage for the db"
}
variable "engine" {
  type        = string
  default     = "mysql"
  description = "Database engine"
}
variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "db engine version"
}

variable "db_name" {
  type        = string
  description = "Name of the database"
  default     = "exam_db"
}

variable "username" {
  type        = string
  description = "Username for the database"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Password for the database"
  sensitive   = true
}