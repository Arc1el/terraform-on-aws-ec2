# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-09cd5dd529c3c1f40"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  subnet_id = aws_subnet.example.id
  tags = {  
    "Name" = "EC2 Demo"
    "hmkim" = "EC2"
  }
}