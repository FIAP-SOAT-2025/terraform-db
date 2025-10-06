terraform {
  backend "s3" {
    bucket         = "terraform-state-tc3-g38-lanchonete-v1"
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
