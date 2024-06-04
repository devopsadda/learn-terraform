
resource "aws_ebs_volume" "ec2_ebs_volume" {
  availability_zone = "us-east-1a"
  size              = 10           
  tags = {
    Name = "ec2_ebs_volume"
  }
}

resource "aws_security_group" "ec2_security_group" {
  description = "EC2 Security Group"
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
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
    Name = "ec2_security_group"
  }
}

resource "aws_instance" "demo-ec2" {
  ami = "ami-051f8a213df8bc089"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.doa_instance_profile.name
}

resource "aws_volume_attachment" "ebs" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.ec2_ebs_volume.id
  instance_id = aws_instance.demo-ec2.id
}