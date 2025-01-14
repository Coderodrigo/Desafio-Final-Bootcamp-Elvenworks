# Chave SSH para acessar o EC2
resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name  # Nome da chave SSH, definido na variável ssh_key_name.
  public_key = file("/home/rodrigo/.ssh/id_rsa.pub")  # Caminho para a chave pública que será usada para acessar o servidor.
}

# Instância EC2 para o WordPress
resource "aws_instance" "wordpress" {
  ami                         = var.ami_id  # ID da imagem AMI usada para criar a instância, definida em uma variável.
  instance_type               = var.instance_type  # Tipo da instância (por exemplo, t2.micro), definido em uma variável.
  subnet_id                   = aws_subnet.public_1.id  # Sub-rede pública onde a instância será criada.
  associate_public_ip_address = true  # Garante que a instância receba um IP público para acesso via internet.
  key_name                    = var.ssh_key_name  # Nome da chave SSH para acesso à instância.

  # Script de inicialização (user_data) para configurar a instância no provisionamento
  user_data = <<-EOF
              #!/bin/bash
              # Atualizar pacotes
              sudo apt update -y
              # Instalar Ansible 
              sudo apt install -y ansible git
              # Baixar o playbook do GitHub
              cd /tmp
              git clone https://github.com/seu-usuario/wordpress-playbook.git
              cd wordpress-playbook
              # Executar o playbook
              sudo ansible-playbook -i inventory wordpress.yml
              EOF

  monitoring = true  # Habilita o CloudWatch para monitorar a instância.
  vpc_security_group_ids = [aws_security_group.sc-ec2-wordpress.id]  # Vincula o Security Group à instância para controle de acesso.

  # Adiciona tags à instância para facilitar a identificação.
  tags = { 
    Name = "wordpress-instance"  # Nome da instância no console AWS.
  }
}

# Instância EC2 para o Monitoramento (Grafana + Prometheus)
resource "aws_instance" "monitoring" {
  ami           = var.ami_id  # ID da imagem AMI usada para criar a instância.
  instance_type = var.instance_type  # Tipo da instância (por exemplo, t2.micro).
  subnet_id     = aws_subnet.private_1.id  # Sub-rede privada para proteger o acesso externo.

  # Adiciona tags à instância para facilitar a identificação.
  tags = { 
    Name = "monitoring-instance"  # Nome da instância no console AWS.
  }
}

