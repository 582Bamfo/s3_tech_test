## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.oac](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_s3_bucket.buckets](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.static_acl](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.bucket_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.static_owner](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.bucket_cloudfront](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_access](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.static_encryption](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_website_configuration.static_website](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_iam_policy_document.product_group_access](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.product_group](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | n/a | `string` | `"private"` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | Map of bucket configurations | <pre>map(object({<br/>    lifecycle_enabled   = bool<br/>    transition_days     = optional(number)<br/>    storage_class       = optional(string)<br/>    expiration_days     = optional(number)<br/>    website_enabled     = bool<br/>    block_public_access = bool<br/>    cloudfront_enabled  = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags for all resources | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (dev, stage, prod) | `string` | n/a | yes |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | n/a | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | n/a | `string` | `"AES256"` | no |

### example
```
terraform
variable "buckets" {
  description = "Map of bucket configurations"
  type = map(object({
    lifecycle_enabled   = bool
    transition_days     = optional(number)
    storage_class       = optional(string)
    expiration_days     = optional(number)
    website_enabled     = bool
    block_public_access = bool
    cloudfront_enabled  = bool
  }))
}
```


## Outputs

No outputs.
