resource "tls_private_key" "TEST-PSP" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "TEST-PSP"
  public_key = tls_private_key.TEST-PSP.public_key_openssh
}
