module "asggrn" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  
  name = "pspappngrn"

  # Launch configuration
  lc_name = "pspappngrn"

  image_id              = var.ami
  instance_type         = "t2.micro"
  security_groups       = [module.web_sg.this_security_group_id,var.default-sg.mgmt_remote,var.default-sg.mgmt_service]
  target_group_arns     = [aws_lb_target_group.tggrn.arn]
  termination_policies  = ["OldestInstance"]
  default_cooldown      = 1000
  user_data             = "${file("userdata.sh")}"
  iam_instance_profile   = aws_iam_role.OLBServer.name





  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "10"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "10"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "pspappngrn"
  vpc_zone_identifier       = var.vpc01_subnets
  health_check_type         = "ELB"
  min_size                  = 0
  max_size                  = 0
  desired_capacity          = 0
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "PSP"
      propagate_at_launch = true
    },
  ]

 tags_as_map = var.default_tags
}

module "asgblu" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  
  name = "pspappnblu"

  # Launch configuration
  lc_name = "pspappnblu"

  image_id              = var.ami
  instance_type         = "t2.micro"
  security_groups       = [module.web_sg.this_security_group_id,var.default-sg.mgmt_remote,var.default-sg.mgmt_service]
  target_group_arns     = [aws_lb_target_group.tgblu.arn]
  termination_policies  = ["OldestInstance"]
  default_cooldown      = 1000
  iam_instance_profile   = aws_iam_role.OLBServer.name


  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "10"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "10"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "pspappnblu"
  vpc_zone_identifier       = var.vpc01_subnets
  health_check_type         = "ELB"
  min_size                  = 0
  max_size                  = 0
  desired_capacity          = 0
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "PSP"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}


module "asgpxy" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  
  name = "psppxy"

  # Launch configuration
  lc_name = "psppxy"

  image_id              = var.ami
  instance_type         = "t2.micro"
  security_groups       = [module.web_sg.this_security_group_id,var.default-sg.mgmt_remote,var.default-sg.mgmt_service,module.nlb_sg.this_security_group_id]
  target_group_arns     = [aws_lb_target_group.tgpxy.arn]
  termination_policies  = ["OldestInstance"]
  default_cooldown      = 1000
  iam_instance_profile   = aws_iam_role.OLBServer.name


  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "10"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "10"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "psppxy"
  vpc_zone_identifier       = var.vpc01_subnets
  health_check_type         = "ELB"
  min_size                  = 0
  max_size                  = 0
  desired_capacity          = 0
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "PSP"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}