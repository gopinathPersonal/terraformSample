# Ec2 Instance Creation

resource "aws_instance" "Gopi_server" {
  ami           = var.ami_ec2
  instance_type = var.instance_type_ec2
  key_name = var.key_name_ec2
  subnet_id = var.subnet01
  security_groups  = [var.security_groups]

  tags = {
    Name = "Gopi_server"
  }
}

# Adding Instance as a Backend Server of LB
resource "aws_elb_attachment" "Gopi_addec2" {
  elb      = var.elb
  instance = aws_instance.Gopi_server.id
}

# output
output "instance" {
  value = aws_instance.Gopi_server.id
}
