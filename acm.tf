module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name  = "mikmclean.co.uk"
  zone_id      = "ZW79SE7DKXTIB"

  subject_alternative_names = [
    "*.mikmclean.co.uk",
    "app.sub.mikmclean.co.uk",
  ]

  tags = {
    Name = "mikmclean.co.uk"
  }
}

output "test-cert_id" {
  value = "${module.acm.this_acm_certificate_arn}"
}

