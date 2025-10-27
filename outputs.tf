output "bucket_id" {
  value = module.video_game.gameing_bucket_id
}

output "bucket_name" {
  value = module.video_game.gameing_bucket_name
}
output "cloudfront_domain_name" {
  description = "The CloudFront domain name for the website"
  value       = module.video_game.cloudfront_domain
}
