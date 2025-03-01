output "bucket-name" {
  value= values(aws_s3_bucket.buckets)[*].arn
}