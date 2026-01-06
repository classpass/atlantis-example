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