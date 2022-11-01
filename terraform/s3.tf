resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${local.website_bucket_name}"
}

resource "aws_s3_bucket_acl" "www_bucket_acl" {
  bucket = aws_s3_bucket.www_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "www_bucket_public_block" {
  bucket = aws_s3_bucket.www_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "www_bucket_policy" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = templatefile("${path.module}/templates/s3_public_read_policy.tpl", { bucket = "www.${local.website_bucket_name}", cloudfront = aws_cloudfront_origin_access_identity.www_s3_id.iam_arn })
}

resource "aws_s3_bucket_website_configuration" "www_website_bucket" {
  bucket = "www.${local.website_bucket_name}"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "root_bucket" {
  bucket = local.website_bucket_name
}

resource "aws_s3_bucket_acl" "root_bucket_acl" {
  bucket = aws_s3_bucket.root_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "root_bucket_public_block" {
  bucket = aws_s3_bucket.root_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket = aws_s3_bucket.root_bucket.id
  policy = templatefile("${path.module}/templates/s3_public_read_policy.tpl", { bucket = local.website_bucket_name, cloudfront = aws_cloudfront_origin_access_identity.www_s3_id.iam_arn })
}

resource "aws_s3_bucket_website_configuration" "root_website_bucket" {
  bucket = local.website_bucket_name
  redirect_all_requests_to {
    host_name = "www.${var.domain_name}"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.www_bucket.id
  key          = "index.html"
  content      = var.content
  source_hash  = var.content
  content_type = "text/html"
}