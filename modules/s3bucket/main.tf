resource "aws_s3_bucket" "main" {
  provider      = aws.user
  bucket        = "classpass-atlantis-poc-${var.environment_name}"
  force_destroy = "false"           # Will prevent destruction of bucket with contents inside
}

resource "aws_s3_object" "objects" {
  for_each = fileset("myfiles/", "*")
  bucket   = aws_s3_bucket.main.bucket
  key      = "${each.value}"
  source   = "myfiles/${each.value}"
  etag     = filemd5("myfiles/${each.value}")
}

provider "aws" {
  alias   = "user"
  region  = "us-east-1"
}

resource "aws_ssm_parameter" "environment_name" {
  name  = "/atlantis/poc/environment_name"
  type  = "String"
  value = var.environment_name
  overwrite = true
}

resource "aws_ssm_parameter" "enabled" {
  name  = "/atlantis/${var.environment_name}/enabled"
  type  = "String"
  value = "true"
  overwrite = true
}