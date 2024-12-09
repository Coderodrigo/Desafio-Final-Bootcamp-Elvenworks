resource "aws_instance" "wordpress" {
  count         = 2  # Criando 2 instâncias EC2
  ami           = var.ami_id  # Usando a variável ami_id
  instance_type = var.instance_type  # Usando a variável instance_type
  

  tags = {
    Name = "wordpress-instance-${count.index}"
  }
}
