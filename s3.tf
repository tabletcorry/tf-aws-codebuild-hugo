resource "aws_s3_bucket" "cache" {
  bucket_prefix = var.name
}

resource "aws_s3_bucket_acl" "cache" {
  bucket = aws_s3_bucket.cache.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "cache" {
  bucket = aws_s3_bucket.cache.id

  block_public_acls   = true
  block_public_policy = true
}