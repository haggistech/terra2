resource "aws_lb_target_group" "tgblu" {
  name                         = "${var.proj}-https-blue"
  port                         = 443
  protocol                     = "HTTPS"
  vpc_id                       = var.vpc_id
  health_check {
    path                         = "/healthcheck"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    timeout                      = 10
  }
}

resource "aws_lb_target_group" "tggrn" {
  name     = "${var.proj}-https-green"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  health_check {
    path                         = "/healthcheck"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    timeout                      = 10
  }
}


resource "aws_lb_target_group" "tgpxy" {
  name     = "${var.proj}-https-pxy"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  health_check {
    path                         = "/healthcheck"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    timeout                      = 10
  }
}

output "http_blue_tg_arn" {
  value = "${aws_lb_target_group.tgblu.arn}"
}

output "http_green_tg_arn" {
  value = "${aws_lb_target_group.tggrn.arn}"
}

output "http_proxy_tg_arn" {
  value = "${aws_lb_target_group.tgpxy.arn}"
}