terraform {
  backend "s3" {
    bucket         = "terraform-state-tc3-g38-lanchonete"
    key            = "db/terraform.tfstate"
    region         = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}
