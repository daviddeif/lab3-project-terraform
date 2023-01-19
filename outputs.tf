output "load_balancer_dns" {
  value = aws_lb.front_end.dns_name
}
