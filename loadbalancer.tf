resource "aws_lb" "front_end" {
  name               = "front-end-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_front_alb.id]
  subnets            = aws_subnet.public_subnets.*.id

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_target_group" "front_end" {
  name     = "front-end-lb-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb" "back_alb" {
  name               = "back-tier-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_back_alb.id]
  subnets            = aws_subnet.private_subnets.*.id

}

resource "aws_lb_listener" "back_alb" {
  load_balancer_arn = aws_lb.back_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_alb.arn
  }
}

resource "aws_lb_target_group" "back_alb" {
  name     = "front-tier-lb-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}