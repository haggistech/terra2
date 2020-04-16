resource "aws_kms_key" "pspdevkmskey" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
  policy                  = file("IAM Policies/KMS_Policy.txt")
}


resource "aws_kms_alias" "pspdevkmskeyalias" {
  name          = "alias/psp-dev-kms-key"
  target_key_id = aws_kms_key.pspdevkmskey.key_id
}