resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"
# # default (الافتراضي): تشغيل السيرفرات على أجهزة مشتركة مع عملاء آخرين (Shared Hardware) مع عزل شبكتك تماماً.
# # dedicated (مخصص): إجبار كافة السيرفرات على العمل على أجهزة فيزيائية مخصصة لك فقط (Dedicated Hardware)، مقابل رسوم إضافية من AWS (~2$ في الساعة لكل Region + تكلفة السيرفرات).
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "subnet-private1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_private1_cidr_block

  tags = {
    Name = "subnet-private1"
  }
}
resource "aws_subnet" "subnet-private2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_private2_cidr_block

  tags = {
    Name = "subnet-private2"
  }
}
resource "aws_subnet" "subnet-public1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_public1_cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = "${var.region}a"

  tags = {
    Name = "subnet-public1"
  }
}
resource "aws_subnet" "subnet-public2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_public2_cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = "${var.region}b"

  tags = {
    Name = "subnet-public2"
  }
}
resource "aws_subnet" "subnet-public3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public3_cidr_block
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "subnet-public3"
  }
}

# # #************************* aws_route_table ****************************************#
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "rt-private"
  }
}
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "rt-public"
  }
}

# # #************************* aws_route_table_association ****************************************#
resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.subnet-private1.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.subnet-private2.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt3" {
  subnet_id      = aws_subnet.subnet-public1.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "rt4" {
  subnet_id      = aws_subnet.subnet-public2.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "rt5" {
  subnet_id      = aws_subnet.subnet-public3.id
  route_table_id = aws_route_table.rt_public.id
}

# # #************************* aws_internet_gateway ****************************************#
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# # #************************* aws_security_group ****************************************#

resource "aws_security_group" "security_group1" {
  name        = "security-group(80,443,8080,22)"
  description = "Allow inbound traffic on ports 22, 80, 443, 8080"
  vpc_id      = aws_vpc.vpc.id

  # Inbound rules
  ingress {
    from_port   = var.port_allow[0]
    to_port     =  var.port_allow[0]
    protocol    = "tcp"
    cidr_blocks = [var.ip_allow_ssh]  # Allow SSH from a specific IP address
  }

  ingress {
    from_port   = var.port_allow[1]
    to_port     = var.port_allow[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.port_allow[2]
    to_port     = var.port_allow[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.port_allow[3]
    to_port     = var.port_allow[3]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound (allow everything)
  egress {
    from_port   = var.port_allow_egress[0]
    to_port     = var.port_allow_egress[0]
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security-group1"
  }
}

