data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "terraform-state-tc4-lanchonete"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}