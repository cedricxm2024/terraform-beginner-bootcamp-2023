terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }

    aws = {
      source = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}

resource "random_string" "random_bucket" {
  lower = true
  upper =  false
  length           = 44
  special          = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.random_bucket.result

}

output "random_bucket_id" {
  value = random_string.random_bucket.id
}
