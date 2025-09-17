# ----------------------------
# Data: Latest Amazon Linux 2023 AMI (Free Tier Eligible)
# ----------------------------
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# ----------------------------
# Bastion Host (ap-northeast-2a public subnet)
# ----------------------------
resource "aws_instance" "terraform-pub-ec2-bastion-2a" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.terraform-pub-subnet-2a.id
  vpc_security_group_ids      = [aws_security_group.terraform-sg-bastion.id]
  associate_public_ip_address = true
  key_name                    = "mykey"

  tags = {
    Name = "terraform-pub-ec2-bastion-2a"
  }
}

# ----------------------------
# Web Server in Private Subnet 2a
# ----------------------------
resource "aws_instance" "terraform-pri-ec2-web_2a" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.terraform-pri-subnet-2a.id
  vpc_security_group_ids = [aws_security_group.terraform-sg-bastion.id]
  key_name               = "mykey"

  tags = {
    Name = "terraform-pri-ec2-web-2a"
  }
}

# ----------------------------
# Web Server in Private Subnet 2c
# ----------------------------
resource "aws_instance" "terraform-pri-ec2-web_2c" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.terraform-pri-subnet-2c.id
  vpc_security_group_ids = [aws_security_group.terraform-sg-bastion.id]
  key_name               = "mykey"

  tags = {
    Name = "terraform-pri-ec2-web-2c"
  }
}
