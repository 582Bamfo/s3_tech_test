



resource "aws_s3_bucket" "buckets" {
  for_each      = var.buckets
  bucket        = "${var.environment}-${each.key}-${var.project_name}"
  force_destroy = true

  tags = merge(var.default_tags, {
    Name = "${var.environment}-${each.key}-${var.project_name}"
  })
}

#Object ownership
resource "aws_s3_bucket_ownership_controls" "static_owner" {
  for_each      = var.buckets
  bucket = aws_s3_bucket.buckets[each.key].id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "static_acl" {
  for_each      = var.buckets
  depends_on = [aws_s3_bucket_ownership_controls.static_owner]

  bucket = aws_s3_bucket.buckets[each.key].id
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "static_encryption" {
  for_each      = var.buckets
  bucket = aws_s3_bucket.buckets[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
    }
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  for_each = {
    for k, v in var.buckets : k => v if v.lifecycle_enabled
  }
  bucket   = aws_s3_bucket.buckets[each.key].id

  rule {
    id     = "transition-and-expiration"
    status = "Enabled"

    transition {
      days          = each.value.transition_days
      storage_class = each.value.storage_class
    }

    expiration {
      days = each.value.expiration_days
    }
  }
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  for_each = {
    for k, v in var.buckets : k => v if v.website_enabled
  }
  bucket = aws_s3_bucket.buckets[each.key].id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  for_each                = var.buckets
  bucket                  = aws_s3_bucket.buckets[each.key].id
  block_public_acls       = each.value.block_public_access
  block_public_policy     = each.value.block_public_access
  ignore_public_acls      = each.value.block_public_access
  restrict_public_buckets = each.value.block_public_access
}

resource "aws_cloudfront_origin_access_control" "oac" {
  for_each                          = {
    for k, v in var.buckets : k => v if v.cloudfront_enabled
  }
  name                              = "${var.environment}-${each.key}-${var.project_name}-oac"
  description                       = "OAC for ${each.key} bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}






resource "aws_s3_bucket_policy" "bucket_cloudfront" {
  for_each = {
    for k, v in var.buckets : k => v if v.cloudfront_enabled
  }
  bucket = aws_s3_bucket.buckets[each.key].id
  policy = data.aws_iam_policy_document.s3_policy[each.key].json
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  for_each = {
    for k, v in var.buckets : k => v if !v.cloudfront_enabled
  }
  bucket = aws_s3_bucket.buckets[each.key].id
  policy = data.aws_iam_policy_document.product_group_access[each.key].json
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  for_each = {
    for k, v in var.buckets : k => v if v.cloudfront_enabled
  }

  origin {
    domain_name              = aws_s3_bucket.buckets[each.key].bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac[each.key].id
    origin_id                = aws_s3_bucket.buckets[each.key].id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.buckets[each.key].id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.default_tags
}