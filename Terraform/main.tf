# Set the region
provider "aws"{
    region = "us-west-1"
}

# Data source to get the default VPC information
data "aws_vpc" "default" {
  default = true
}

# Create a public subnet within the default VPC
resource "aws_subnet" "public_subnet" {
  vpc_id  = data.aws_vpc.default.id
  cidr_block  = "172.31.32.0/24"  
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true 
}

# Create a private subnet within the default VPC
resource "aws_subnet" "private_subnet" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.48.0/24"  
  availability_zone = "us-west-1a"
}

# Security group configuration to allow inbound and outbound traffic
resource "aws_security_group" "my_sg" {
  vpc_id = data.aws_vpc.default.id

  # Allow inbound HTTP traffic on port 80 from any IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH traffic on port 22 from any IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance in the public subnet
resource "aws_instance" "my_instance" {
  ami           = "ami-0cf4e1fcfd8494d5b"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "my_server"
  }
}

# Output the public IP of the created instance
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

# Output the ID of the public subnet
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# Output the ID of the private subnet
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

# Output the ID of the security group
output "security_group_id" {
  value = aws_security_group.my_sg.id
}
