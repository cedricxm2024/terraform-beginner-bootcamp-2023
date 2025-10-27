terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "random_string" "suffix" {
  lower   = true
  upper   = false
  length  = 44
  special = false
}


resource "aws_s3_bucket" "gameing_bucket" {
  bucket = "cedric-gaming-site-${random_string.suffix.result}"

  tags = {
    UserUuid    = var.user_uuid
    Name        = "Cedric Game Site"
    Environment = "Dev"
    Owner       = "Cedric"
    ManagedBy   = "Terraform"
  }
}
resource "aws_s3_bucket_public_access_block" "gameing_bucket_block" {
  bucket = aws_s3_bucket.gameing_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.gameing_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
# Upload index.html
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.gameing_bucket.bucket
  key          = "index.html"
  source       = "${path.root}/public/index.html"
  content_type = "text/html"

  etag = filemd5("${path.root}/public/index.html")
}

# Upload error.html
resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.gameing_bucket.bucket
  key          = "error.html"
  source       = "${path.root}/public/error.html"
  content_type = "text/html"

  etag = filemd5("${path.root}/public/error.html")
}
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "cf-oac-${random_string.suffix.result}"
  description                       = "OAC for CloudFront to access S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket_website_configuration.site.website_endpoint
    origin_id   = aws_s3_bucket.gameing_bucket.id

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.gameing_bucket.id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    UserUuid    = var.user_uuid
    Name        = "Cedric Game Site CDN"
    Environment = "Dev"
    Owner       = "Cedric"
    ManagedBy   = "Terraform"
  }
}
