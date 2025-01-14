# Security Group para EC2 (WordPress)
resource "aws_security_group" "sc-ec2-wordpress" {
  name        = "pemitir-ssh-http"  # Nome do Security Group.
  description = "Allow SSH, HTTP"  # Descrição do Security Group.
  vpc_id      = aws_vpc.main.id  # ID da VPC onde o Security Group será criado.

  # Regras de entrada (Ingress)
  ingress {
    description = "SSH"  # Permitir acesso SSH (porta 22).
    from_port   = 22  # Porta inicial do intervalo (22 para SSH).
    to_port     = 22  # Porta final do intervalo (22 para SSH).
    protocol    = "tcp"  # Protocolo usado (TCP).
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (não recomendado para produção).
  }

  ingress {
    description = "HTTP"  # Permitir tráfego HTTP (porta 80).
    from_port   = 80  # Porta inicial do intervalo (80 para HTTP).
    to_port     = 80  # Porta final do intervalo (80 para HTTP).
    protocol    = "tcp"  # Protocolo usado (TCP).
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP.
  }

  ingress {
    description = "HTTPS"  # Permitir tráfego HTTPS (porta 443).
    from_port   = 443  # Porta inicial do intervalo (443 para HTTPS).
    to_port     = 443  # Porta final do intervalo (443 para HTTPS).
    protocol    = "tcp"  # Protocolo usado (TCP).
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP.
  }

  # Regras de saída (Egress)
  egress {
    from_port   = 0  # Porta inicial (0 permite todas as portas).
    to_port     = 0  # Porta final (0 permite todas as portas).
    protocol    = "-1"  # Permite todos os protocolos.
    cidr_blocks = ["0.0.0.0/0"]  # Permite tráfego de saída para qualquer IP.
  }
}

# Output para facilitar o acesso ao ID do Security Group
output "security_group_id" {
  value = aws_security_group.sc-ec2-wordpress.id  # Retorna o ID do Security Group criado.
}

# Security Group para RDS (Banco de Dados)
resource "aws_security_group" "allow_rds" {
  name        = "allow_rds"  # Nome do Security Group.
  description = "Allow MySQL traffic from EC2 instances"  # Descrição do Security Group.
  vpc_id      = aws_vpc.main.id  # ID da VPC onde o Security Group será criado.

  # Regras de entrada (Ingress)
  ingress {
    description = "MySQL"  # Permitir acesso MySQL (porta 3306).
    from_port   = 3306  # Porta inicial do intervalo (3306 para MySQL).
    to_port     = 3306  # Porta final do intervalo (3306 para MySQL).
    protocol    = "tcp"  # Protocolo usado (TCP).
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (use restrições mais seguras para produção).
  }

  # Regras de saída (Egress)
  egress {
    from_port   = 0  # Porta inicial (0 permite todas as portas).
    to_port     = 0  # Porta final (0 permite todas as portas).
    protocol    = "-1"  # Permite todos os protocolos.
    cidr_blocks = ["0.0.0.0/0"]  # Permite tráfego de saída para qualquer IP.
  }

  # Tags para facilitar a identificação no console AWS
  tags = {
    Name = "allow_rds"  # Nome do Security Group.
  }
}
