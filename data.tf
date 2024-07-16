data "aws_iam_policy_document" "s3_policy" {
  for_each = {
    for k, v in var.buckets : k => v if v.cloudfront_enabled
  }

  statement {
    actions   = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.buckets[each.key].arn}",
      "${aws_s3_bucket.buckets[each.key].arn}/*"
      ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution[each.key].arn]
    }
  }
}


data "aws_iam_role" "product_group" {
  name = "twinkl-product-team"  
}




data "aws_iam_policy_document" "product_group_access" {
  for_each = {
    for k, v in var.buckets : k => v if !v.cloudfront_enabled
}
  statement {

    principals { 
    type = "AWS" 
    identifiers = [data.aws_iam_role.product_group.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
       "${aws_s3_bucket.buckets[each.key].arn}",
      "${aws_s3_bucket.buckets[each.key].arn}/*",
    ]
  }
}
