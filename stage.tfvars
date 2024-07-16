region       = "us-east-1"
environment  = "stage"
project_name = "tech-test"

buckets = {
  "stage-twinkl-image-bucket-c" = {
    lifecycle_enabled   = false
    website_enabled     = false
    block_public_access = true
    cloudfront_enabled  = false
  },
  "stage-twinkl-temp-bucket-d" = {
    lifecycle_enabled   = true
    transition_days     = 1
    storage_class       = "INTELLIGENT_TIERING"
    expiration_days     = 2
    website_enabled     = false
    block_public_access = true
    cloudfront_enabled  = false
  },
  "stage-twinkl-static-website-a" = {
    lifecycle_enabled   = false
    website_enabled     = true
    block_public_access = true
    cloudfront_enabled  = true
  },
  "stage-twinkl-static-website-b" = {
    lifecycle_enabled   = false
    website_enabled     = true
    block_public_access = true
    cloudfront_enabled  = true
  }
}

default_tags = {
  Environment = "stage"
  IaC    = "Terraform"
}