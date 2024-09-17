provider "aws" {
  profile = "cloud-adm"
}
resource "aws_instance" "demo-ec2" {
  ami = "ami-066784287e358dad1"
  instance_type = "t3.medium"

  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "demo-ec2-instance"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "terraform-firewall"
  description = "Managed from Terraform"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "${aws_eip.eip.public_ip}/32"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_eip" "eip" {
  instance = aws_instance.demo-ec2.id
  domain   = "vpc"
}

output "ec2_public_ip" {
  value = aws_eip.eip.public_ip
}

output "App_URL" {
  value = "http://${aws_eip.eip.private_ip}:8080"
}