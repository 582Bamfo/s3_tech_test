region       = "us-west-2"
environment  = "prod"
project_name = "tech-test"

buckets = {
  "prod-twinkl-image-bucket-c" = {
    lifecycle_enabled   = false
    website_enabled     = false
    block_public_access = true
    cloudfront_enabled  = false
  },
  "prod-twinkl-temp-bucket-d" = {
    lifecycle_enabled   = true
    transition_days     = 1
    storage_class       = "INTELLIGENT_TIERING"
    expiration_days     = 2
    website_enabled     = false
    block_public_access = true
    cloudfront_enabled  = false
  },
  "prod-twinkl-static-website-a" = {
    lifecycle_enabled   = false
    website_enabled     = true
    block_public_access = true
    cloudfront_enabled  = true
  },
  "prod-twinkl-static-website-b" = {
    lifecycle_enabled   = false
    website_enabled     = true
    block_public_access = true
    cloudfront_enabled  = true
  }
}

default_tags = {
  Environment = "Prod"
  IaC    = "Terraform"
}