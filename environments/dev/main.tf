terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket       = "cp-terraform-resources"
    key          = "POC/atlantis/dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  alias   = "user"
  region  = "us-east-1"
}

 module "s3bucket" {
  source = "../../modules/s3bucket"
  environment_name = "development"
} 