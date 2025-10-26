resource "random_string" "random_bucket" {
  lower = true
  upper =  false
  length           = 44
  special          = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.random_bucket.result

  tags = {
    UserUuid = var.user_uuid
  }
}

