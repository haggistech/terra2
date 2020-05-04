resource "aws_lb" "alb" {
  name               = "${var.proj}-app-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [module.alb_sg.this_security_group_id]
  subnets            = ["subnet-0e90bee9455ee4b12", "subnet-0ac026c7191a1931b", "subnet-0fb32465f9a0c3f6d"]

  enable_deletion_protection = false
}


resource "aws_lb" "nlb" {
  name               = "${var.proj}-internal"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["subnet-0e90bee9455ee4b12", "subnet-0ac026c7191a1931b", "subnet-0fb32465f9a0c3f6d"]

  enable_deletion_protection = false

}


resource "aws_lb_listener" "alblistener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.acm.this_acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tggrn.arn
  }
}



resource "aws_lb_listener_rule" "hostgrn" {
  listener_arn = aws_lb_listener.alblistener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tggrn.arn
  }

  # Condition field: host-header
  condition {
    host_header {
      values = ["grn*.*"]
    }
  }
}

resource "aws_lb_listener_rule" "hostblu" {
  listener_arn = aws_lb_listener.alblistener.arn
  priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgblu.arn
  }

  # Condition field: host-header
  condition {
    host_header {
      values = ["blu*.*"]
    }
  }
}


resource "aws_lb_listener_rule" "pathblu" {
  listener_arn = aws_lb_listener.alblistener.arn
  priority     = 97

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgblu.arn
  }

  # Condition field: host-header
  condition {
    path_pattern {
      values = ["/blu"]
    }
  }
}

resource "aws_lb_listener_rule" "pathgrn" {
  listener_arn = aws_lb_listener.alblistener.arn
  priority     = 96

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tggrn.arn
  }

  # Condition field: host-header
  condition {
    path_pattern {
      values = ["/grn"]
    }
  }
}

output "alb_arn" {
  value = "${aws_lb.alb.arn}"
}

output "grn_listner_arn" {
  value = "${aws_lb_listener.alblistener.arn}"
}
