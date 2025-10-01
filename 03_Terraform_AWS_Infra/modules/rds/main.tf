resource "aws_db_subnet_group" "subnet_groupe" {
  name_prefix = "wordpress-db-subnet-group-"
  subnet_ids  = var.subnet_ids
  tags = {
    Name = "wordpress-db-subnet-group"
  }
}

resource "aws_db_instance" "wordpress_db_az1" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_type
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.subnet_groupe.name
  multi_az               = false 
  availability_zone      = var.availability_zone_a
  skip_final_snapshot    = true
  identifier_prefix      = "wordpress-db-primary-"
  tags = {
    Name = "wordpress-db-primary"
  }
}

resource "aws_db_instance" "wordpress_db_az2" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_type
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.subnet_groupe.name
  multi_az               = false
  availability_zone      = var.availability_zone_b
  skip_final_snapshot    = true
  identifier_prefix      = "wordpress-db-secondary-"
  depends_on             = [aws_db_instance.wordpress_db_az1]
  tags = {
    Name = "wordpress-db-secondary"
  }
}

resource "aws_security_group" "db_sg" {
  name_prefix = "wordpress-db-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.sg_ec2] # Autoriser uniquement le trafic depuis le serveur web
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-db-sg"
  }
}
