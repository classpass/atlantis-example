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

resource "aws_s3_bucket" "example" {
  provider      = aws.user
  bucket        = "classpass-atlantis-poc-6831407"
  force_destroy = "false"           # Will prevent destruction of bucket with contents inside
}

resource "aws_s3_object" "objects" {
  for_each = fileset("myfiles/", "*")
  bucket   = aws_s3_bucket.example.bucket
  key      = "new_objects"
  source   = "myfiles/${each.value}"
  etag     = filemd5("myfiles/${each.value}")
}