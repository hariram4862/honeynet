resource "aws_instance" "honeypot" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "honeypot-node"
  }
}