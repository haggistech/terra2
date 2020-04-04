module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "psp-app-lb"

  load_balancer_type = "application"

  vpc_id             = "vpc-2df94b4a"
  subnets            = ["subnet-0e90bee9455ee4b12", "subnet-0ac026c7191a1931b", "subnet-0fb32465f9a0c3f6d"]
  security_groups    = [module.alb_sg.this_security_group_id]


  target_groups = [
    {
      name      = "psp-https-blue"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
    {
      name      = "psp-https-green"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
    {
      name      = "psp-https-pxy"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }

  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.this_acm_certificate_arn
      target_group_index = 0
    }
  ]
}

