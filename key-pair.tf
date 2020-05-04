resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${upper(var.env)}-${upper(var.proj)}"
  public_key = tls_private_key.ssh-key.public_key_openssh
}
