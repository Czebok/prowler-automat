terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
      bucket = "bucket-terraform-stan"
      key = "tf-stan"
      region = "eu-central-1"
    }
}

provider "aws" {
  region = "eu-central-1"
}

module "backend" {
  source = "./modules/backend"
}