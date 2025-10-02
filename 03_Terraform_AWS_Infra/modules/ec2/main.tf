data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name
  availability_zone      = var.availability_zone


  user_data = templatefile("${path.module}/install_wordpress.tpl", {
  db_name     = var.db_name,
  db_user     = var.username,
  db_password = var.password,
  db_host     = var.db_host,
  wordpress_dir = "/var/www/html"  
})

  tags = {
    Name = "wordpress-web-server"
  }
}

resource "aws_security_group" "web_sg" {
  name_prefix = "wordpress-web-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Limitez l'accès SSH pour la production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-web-sg"
  }
}

