# Create S3 Bucket
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "mik-${var.proj}-${lower(var.env)}-${var.cf_bucket_suffix}"
  acl    = "private"
}
