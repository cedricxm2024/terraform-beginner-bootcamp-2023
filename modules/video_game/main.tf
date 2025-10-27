terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
   region = "us-east-1"
}

resource "random_string" "gameing_bucket" {
  lower = true
  upper =  false
  length           = 44
  special          = false
}


resource "aws_s3_bucket" "gameing_bucket" {
  bucket = random_string.gameing_bucket.result

  tags = {
    UserUuid = var.user_uuid
    Name        = "Cedric Game Site"
    Environment = "Dev"
    Owner       = "Cedric"
    ManagedBy   = "Terraform"
  }
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
  acl          = "public-read"

    etag = filemd5("${path.root}/public/index.html")
}

# Upload error.html
resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.gameing_bucket.bucket
  key          = "error.html"
  source       = "${path.root}/public/error.html"
  content_type = "text/html"
  acl          = "public-read"

   etag = filemd5("${path.root}/public/error.html")
}