

variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment (dev, stage, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

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

variable "object_ownership" {
  type = string
  default = "BucketOwnerEnforced"
}

variable "bucket_acl" {
  type = string
  default = "private"
}

variable "sse_algorithm" {
  type = string
  default = "AES256"
}


variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
