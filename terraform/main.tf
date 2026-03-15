resource "aws_key_pair" "honeynet_key_us" {
  provider   = aws.us
  key_name   = "honeynet-key"
  public_key = file("/mnt/c/Users/harir/.ssh/honeynet_key.pub")
}

resource "aws_key_pair" "honeynet_key_eu" {
  provider   = aws.eu
  key_name   = "honeynet-key"
  public_key = file("/mnt/c/Users/harir/.ssh/honeynet_key.pub")
}

resource "aws_key_pair" "honeynet_key_ap" {
  provider   = aws.ap
  key_name   = "honeynet-key"
  public_key = file("/mnt/c/Users/harir/.ssh/honeynet_key.pub")
}

resource "aws_security_group" "honeynet_sg_us" {
  provider = aws.us
  name     = "honeynet-sg"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2222
    to_port   = 2222
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "honeynet_sg_eu" {
  provider = aws.eu
  name     = "honeynet-sg"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2222
    to_port   = 2222
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "honeynet_sg_ap" {
  provider = aws.ap
  name     = "honeynet-sg"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2222
    to_port   = 2222
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu_us" {
  provider = aws.us
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_eu" {
  provider = aws.eu
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_ap" {
  provider = aws.ap
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "honeypot_us" {
  provider = aws.us

  ami = data.aws_ami.ubuntu_us.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.honeynet_key_us.key_name
  
  vpc_security_group_ids = [aws_security_group.honeynet_sg_us.id]

  tags = {
    Name = "honeynet-us-east"
  }
}

resource "aws_instance" "honeypot_eu" {
  provider = aws.eu

  ami = data.aws_ami.ubuntu_eu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.honeynet_key_eu.key_name
  
  vpc_security_group_ids = [aws_security_group.honeynet_sg_eu.id]

  tags = {
    Name = "honeynet-eu-west"
  }
}

resource "aws_instance" "honeypot_ap" {
  provider = aws.ap

  ami = data.aws_ami.ubuntu_ap.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.honeynet_key_ap.key_name
  
  vpc_security_group_ids = [aws_security_group.honeynet_sg_ap.id]

  tags = {
    Name = "honeynet-ap-south"
  }
}

output "honeypot_ips" {
  value = [
    aws_instance.honeypot_us.public_ip,
    aws_instance.honeypot_eu.public_ip,
    aws_instance.honeypot_ap.public_ip
  ]
}