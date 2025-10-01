#create vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name  = "${var.network_name}-VPC"
  }
}

#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${var.network_name}-igw"
  }
}

#create subnet

# public subnet for AZ1
resource "aws_subnet" "pub_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.az1_pub_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.public_az1
  tags = {
    Name  = "public_subnet_az1"
  }
}

# public subnet for AZ2
resource "aws_subnet" "pub_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.az2_pub_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.public_az2
  tags = {
    Name  = "public_subnet_az2"
}
}

#route table Creation

# public route table 
resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name  = "public_routetable"
  }
}

# create the route tables association with the subnets

# public subnet in AZ1 associated with public route table
resource "aws_route_table_association" "public_route_table_az1" {
  subnet_id      = aws_subnet.pub_subnet_az1.id
  route_table_id = aws_route_table.pub_route_table.id
}

# public subnet in AZ2 associated with public route table
resource "aws_route_table_association" "public_route_table_az2" {
  subnet_id      = aws_subnet.pub_subnet_az2.id
  route_table_id = aws_route_table.pub_route_table.id
}


#EIP Creation for AZ1
resource "aws_eip" "eip_az1" {
  tags = {
    Name  = "my_eip_az1"
  }
}

#EIP Creation for AZ2
resource "aws_eip" "eip_az2" {
  tags = {
    Name  = "my_eip_az2"
  }
}
