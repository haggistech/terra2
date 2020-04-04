
resource "aws_alb" "pspalb" {  
  name            = "psp-internal-alb"  
  subnets         = ["subnet-2d7d8d76","subnet-6542ff2c","subnet-79299d1e"]
  security_groups = [module.alb_sg.this_security_group_id]
  internal        = "true"   
}