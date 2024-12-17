# EC2 para o Wordpress
resource "aws_instance" "wordpress" {
  ami                         = "ami-036841078a4b68e14" 
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true

  tags = { Name = "wordpress-instance" }
}

#EC2 para o monitoramento Grafana + Prometheus
resource "aws_instance" "monitoring" {
  ami           = "ami-036841078a4b68e14" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_1.id

  tags = { Name = "monitoring-instance" }
}

