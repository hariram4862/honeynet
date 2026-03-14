resource "aws_key_pair" "honeynet_key" {
  key_name   = "honeynet-key"
  public_key = file("/mnt/c/Users/harir/.ssh/honeynet_key.pub")
}

resource "aws_security_group" "honeynet_sg" {
  name        = "honeynet-sg"
  description = "Security group for honeynet node"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (official Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "honeypot" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.honeynet_key.key_name

  vpc_security_group_ids = [aws_security_group.honeynet_sg.id]

  tags = {
    Name = "honeynet-node"
  }
}

output "honeypot_ip" {
  value = aws_instance.honeypot.public_ip
}