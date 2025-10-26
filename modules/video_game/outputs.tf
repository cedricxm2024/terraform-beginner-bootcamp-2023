output "gameing_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.gameing_bucket.id
}

output "gameing_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.gameing_bucket.bucket
}
