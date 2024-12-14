resource "aws_instance" "wordpress" {
  count         = 2  # Criando 2 instâncias EC2
  ami           = var.ami_id  # Usando a variável ami_id
  instance_type = var.instance_type  # Usando a variável instance_type
  key_name      = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "wordpress-instance-${count.index}"
  }

 connection {
    type        = "ssh"
    user        = "ubuntu"  # Ou o usuário padrão da sua AMI
    private_key = file("/home/rodrigo/.ssh/id_ed25519")
    host        = self.public_ip

 }

}