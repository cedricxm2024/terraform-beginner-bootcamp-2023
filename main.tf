terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "random_bucket" {
  length           = 16
  special          = false
}

output "random_bucket_id" {
  value = random_string.random_bucket.id
}

output "random_bucket_result" {
  value = random_string.random_bucket.result
}
