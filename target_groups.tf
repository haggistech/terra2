resource "aws_lb_target_group" "tgblue" {
  name                         = "psp-https-blue"
  port                         = 443
  protocol                     = "HTTPS"
  vpc_id                       = "vpc-2df94b4a"
  health_check {
    path                         = "/healthcheck"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    timeout                      = 10
  }
}

resource "aws_lb_target_group" "tggreen" {
  name     = "psp-https-green"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "vpc-2df94b4a"
  health_check {
    path                         = "/healthcheck"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    timeout                      = 10
  }
}


resource "aws_lb_target_group" "tgpxy" {
  name     = "psp-https-pxy"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "vpc-2df94b4a"
  health_check {
    path                         = "/healthcheck"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    timeout                      = 10
  }
}

output "http_blue_tg_arn" {
  value = "${aws_lb_target_group.tgblue.arn}"
}

output "http_green_tg_arn" {
  value = "${aws_lb_target_group.tggreen.arn}"
}

output "http_proxy_tg_arn" {
  value = "${aws_lb_target_group.tgpxy.arn}"
}