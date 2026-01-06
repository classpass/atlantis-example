terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias   = "user"
  region  = "us-east-1"
}

module "s3bucket" {
  source = "../../modules/s3bucket"
  environment_name = "production"
}