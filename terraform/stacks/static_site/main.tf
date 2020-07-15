provider "aws" {
  region = "us-east-1"
}

module "cloudfront_assets" {
  source = "../../modules/cloudfront/s3_distribution"

  bucket_name = "assets-${var.bucket_name}"
}

module "cloudfront_site" {
  source = "../../modules/cloudfront/s3_distribution"

  bucket_name = "site-${var.bucket_name}"
}

