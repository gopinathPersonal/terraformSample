# VPC Creation
resource "aws_vpc" "Gopi_VPC" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "Gopi_VPC"
  }
}

# Subnet01 Creation
resource "aws_subnet" "Gopi_Public_subnet01" {
  vpc_id     = aws_vpc.Gopi_VPC.id
  cidr_block = var.subnet01_cidr
  availability_zone_id = "use1-az1"

  tags = {
    Name = "Gopi_Public_subnet01"
  }
}

#subnet02 Creation
resource "aws_subnet" "Gopi_Private_subnet02" {
  vpc_id     = aws_vpc.Gopi_VPC.id
  cidr_block = var.subnet02_cidr
  availability_zone_id = "use1-az2"

  tags = {
    Name = "Gopi_Private_subnet02"
  }
}

#internet Gateway Creation
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Gopi_VPC.id

  tags = {
    Name = "Gopi_IGW"
  }
}

# Route Table 1 creation
resource "aws_route_table" "Gopi_RT01" {
  vpc_id = aws_vpc.Gopi_VPC.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "IGW_Route"
  }
}

# Route Table Association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Gopi_Public_subnet01.id
  route_table_id = aws_route_table.Gopi_RT01.id
}

# EIP
resource "aws_eip" "nat" {
  vpc = true
}

# Nat Gateway creation
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Gopi_Private_subnet02.id

  tags = {
    Name = "gw NAT"
  }
}

# Route Table 2 creation for NAT
resource "aws_route_table" "Gopi_RT02" {
  vpc_id = aws_vpc.Gopi_VPC.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "IGW_Route"
  }
}

# Route Table Association

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.Gopi_Private_subnet02.id
  route_table_id = aws_route_table.Gopi_RT02.id
}

# Security Group Creation

resource "aws_security_group" "Gopi_sec_grp" {
  name        = "Gopi_sec_grp"
  description = "Gopi_sec_grp"
  vpc_id      = aws_vpc.Gopi_VPC.id

  ingress {
    description = "TLS from VPC"
    from_port   = var.ingress_22
    to_port     = var.ingress_22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = var.ingress_80
    to_port     = var.ingress_80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = var.ingress_3389
    to_port     = var.ingress_3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Gopi_sec_grp"
  }
}





#output
output "vpc_id" {
  value = aws_vpc.Gopi_VPC.id
}

output "subnet01_id" {
  value = aws_subnet.Gopi_Public_subnet01.id
}

output "subnet02_id" {
  value = aws_subnet.Gopi_Private_subnet02.id
}

output "IGW" {
  value = aws_internet_gateway.gw.id
}

output "NGW" {
  value = aws_nat_gateway.ngw.id
}

output "RT1" {
  value = aws_route_table.Gopi_RT01.id
}

output "RT2" {
  value = aws_route_table.Gopi_RT02.id
}

output "Sec_grp" {
  value = aws_security_group.Gopi_sec_grp.id
}
