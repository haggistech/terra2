module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  
  name = "pspappngrn"

  # Launch configuration
  lc_name = "pspappngrn"

  image_id        = var.ami
  instance_type   = "t2.micro"
  security_groups = [module.web_sg.this_security_group_id]
  target_group_arns   = [aws_lb_target_group.tgblue.arn]

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
  vpc_zone_identifier       = ["subnet-2d7d8d76","subnet-6542ff2c","subnet-79299d1e"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
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