variable "region" {
  description = "Região onde os recursos serão criados"
  type        = string
  default     = "us-east-2"
}

variable "profile" {
  description = "Perfil AWS para autenticação"
  type        = string
  default     = "Rodrigo-Admin"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDRs das sub-redes públicas e privadas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"  # Tipo de instância, altere conforme necessário
}

variable "ami_id" {
  description = "ID da AMI para as instâncias EC2"
  type        = string
  default     = "ami-036841078a4b68e14"  
}

variable "db_username" {
  description = "Nome de usuário para o banco de dados RDS"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Senha para o banco de dados RDS"
  type        = string
  sensitive   = true 
}

# Nome da chave para acessar a EC2
variable "ssh_key_name" {
  description = "Nome Chaves SSH"
  type = string
  

}

