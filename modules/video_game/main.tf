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

