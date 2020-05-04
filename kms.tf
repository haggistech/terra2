resource "aws_kms_key" "kmskey" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
  policy                  = file("IAM Policies/KMS_Policy.txt")
}


resource "aws_kms_alias" "kmskeyalias" {
  name          = "alias/${var.proj}-dev-kms-key"
  target_key_id = aws_kms_key.kmskey.key_id
}