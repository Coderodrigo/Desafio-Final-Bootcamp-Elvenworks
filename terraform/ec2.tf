#Chave SSH para o EC2
resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file("/home/rodrigo/.ssh/id_rsa.pub")

}

# EC2 para o Wordpress
resource "aws_instance" "wordpress" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  key_name   = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.sc-ec2-wordpress.id] #Vinculando o EC2 ao Security Group

  


  tags = { Name = "wordpress-instance" }
}

#EC2 para o monitoramento Grafana + Prometheus
resource "aws_instance" "monitoring" {
  ami           = var.ami_id 
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_1.id

  tags = { Name = "monitoring-instance" }
}

