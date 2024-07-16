region       = "us-east-2"
environment  = "dev"
project_name = "tech-test"

buckets = {
  "dev-twinkl-image-bucket-c" = {
    lifecycle_enabled   = false
    website_enabled     = false
    block_public_access = true
    cloudfront_enabled  = false
  },
  "dev-twinkl-temp-bucket-d" = {
    lifecycle_enabled   = true
    transition_days     = 1
    storage_class       = "INTELLIGENT_TIERING"
    expiration_days     = 2
    website_enabled     = false
    block_public_access = true
    cloudfront_enabled  = false
  },
  "dev-twinkl-static-website-a" = {
    lifecycle_enabled   = false
    website_enabled     = true
    block_public_access = true
    cloudfront_enabled  = true
  },
  "dev-twinkl-static-website-b" = {
    lifecycle_enabled   = false
    website_enabled     = true
    block_public_access = true
    cloudfront_enabled  = true
  }
}

default_tags = {
  Environment = "dev"
  IaC    = "Terraform"
}