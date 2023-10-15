# In your VPC configuration, make sure you have an internet gateway attached.
resource "aws_vpc" "main" {
  cidr_block          = var.vpc_cidr
  enable_dns_support  = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Define public and private subnets.
resource "aws_subnet" "public_subnets" {
  count            = 2
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.aws_region_names, count.index)
  map_public_ip_on_launch = true # This allows instances in the public subnets to receive a public IP
}

resource "aws_subnet" "private_subnets" {
  count            = 2
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.aws_region_names, count.index)
}

# Security Group
resource "aws_security_group" "rail_web_app_sg" {
  name_prefix = "web-app-sg"
  vpc_id      = aws_vpc.main.id

  # Define your security group rules here
  # Example rule for allowing incoming traffic on port 80:
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
