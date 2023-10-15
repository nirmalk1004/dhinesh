resource "aws_s3_bucket" "rail_web_app_bucket" {
  bucket = var.s3_name
}

resource "aws_s3_bucket_ownership_controls" "rail_web_app_bucket" {
  bucket = aws_s3_bucket.rail_web_app_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "rail_web_app_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.rail_web_app_bucket]
  bucket = aws_s3_bucket.rail_web_app_bucket.id
  acl    = "private"
}


output "s3_bucket_url" {
  value = "https://${aws_s3_bucket.rail_web_app_bucket.bucket}.s3.amazonaws.com/"
}


output "s3_region" {
  value = aws_s3_bucket.rail_web_app_bucket.region
}