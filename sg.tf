module "web_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SGPSPWeb"
  description = "Security group for App Servers"
  vpc_id      = "vpc-2df94b4a"
  
#  ingress_cidr_blocks      = ["10.10.0.0/16"]
#  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = "10.10.0.0/16"
    },
#    {
#      rule        = "postgresql-tcp"
#      cidr_blocks = "0.0.0.0/0"
#    },
  ]
}

module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SGPSPalb"
  description = "Security group for ALB"
  vpc_id      = "vpc-2df94b4a"

#  ingress_cidr_blocks      = ["10.10.0.0/16"]
#  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = "10.10.0.0/16"
    },
#    {
#      rule        = "postgresql-tcp"
#      cidr_blocks = "0.0.0.0/0"
#    },
  ]
}

output "psp_alb_sg_id" {
  value = "${module.alb_sg.this_security_group_id}"
}
output "psp_web_sg_id" {
  value = "${module.alb_sg.this_security_group_id}"
}

