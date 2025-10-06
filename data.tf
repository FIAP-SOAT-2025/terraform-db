data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "terraform-state-tc3-g38-lanchonete-v1"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}