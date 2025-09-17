terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "~> 1.19.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data sources
data "aws_eks_cluster" "cluster" {
  name = "eks-${var.projectName}"
}

data "aws_eks_cluster_auth" "auth" {
  name = "eks-${var.projectName}"
}

# Configure kubectl provider
provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  load_config_file       = false
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name,
      "--region",
      var.aws_region,
    ]
  }
}