module "nlb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> v3.6.0"

  name        = "sg_${lower(var.proj)}_nlb"
  description = "Security group for NLB"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      description = "Allow in from Ping"
      source_security_group_id = "${lookup(var.known-sg, "ping_web", "No way this should happen")}"
    }
  ]
  egress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      source_security_group_id = "${module.pxy_sg.this_security_group_id}"
      description = "Allow egress to Proxies"
    }
  ]
}

module "pxy_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> v3.6.0"

  name        = "sg_${lower(var.proj)}_pxy"
  description = "Security group for Proxy Servers"
  vpc_id      = var.vpc_id
  
  computed_ingress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      source_security_group_id = "${module.nlb_sg.this_security_group_id}"
      description = "Allow ingress from NLB"
    }
  ]
  egress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      source_security_group_id = "${module.alb_sg.this_security_group_id}"
      description = "Allow egress to ALB from Proxies"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}


module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> v3.6.0"

  name        = "sg_${lower(var.proj)}_alb"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      source_security_group_id = "${module.pxy_sg.this_security_group_id}"
      description = "Allow ingress from Proxies"
    }
  ]
  egress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      source_security_group_id = "${module.web_sg.this_security_group_id}"
      description = "Allow egress to App Servers"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "web_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> v3.6.0"

  name        = "sg_${lower(var.proj)}_web"
  description = "Security group for App Servers"
  vpc_id      = var.vpc_id

  
  
  computed_ingress_with_source_security_group_id = [
    {
      rule = "https-443-tcp"
      source_security_group_id = "${module.alb_sg.this_security_group_id}"
      description = "Allow ingress from ALB"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}



output "psp_alb_sg_id" {
  value = "${module.alb_sg.this_security_group_id}"
}
output "psp_web_sg_id" {
  value = "${module.web_sg.this_security_group_id}"
}
output "psp_nlb_sg_id" {
  value = "${module.nlb_sg.this_security_group_id}"
}
output "psp_pxy_sg_id" {
  value = "${module.pxy_sg.this_security_group_id}"
}

