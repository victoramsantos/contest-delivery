output "assets_url" {
  value = module.cloudfront_assets.url
}

output "assets_bucket_url" {
  value = module.cloudfront_assets.bucket_url
}

output "site_url" {
  value = module.cloudfront_site.url
}

output "site_bucket_url" {
  value = module.cloudfront_site.bucket_url
}