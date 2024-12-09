# rds.tf

resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"  # O tipo da instância RDS, você pode tornar variável também
  username             = var.db_username  # Usando a variável db_username
  password             = var.db_password  # Usando a variável db_password

  skip_final_snapshot  = true  # Não criar snapshot final ao excluir a instância

  tags = {
    Name = "wordpress-rds"
  }
}