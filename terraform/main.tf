terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "my-ed25519-key"
  public_key = file("/home/rodrigo/.ssh/id_ed25519.pub")

}