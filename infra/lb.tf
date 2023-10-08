resource "aws_lb" "lb" {
  name               = "api-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnets[*].id]
  security_groups    = [aws_security_group.sg.id]
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "hello-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_route53_zone" "zone" {
  name = "test-interview.com"
}

resource "aws_route53_record" "api_record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "api.test-interview.com"
  type    = "A"
  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}
