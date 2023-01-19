output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnets_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnet.id
}

output "back_alb" {
  value = "${aws_security_group.back_alb.id}"
}

output "alb_back_alb" {
  value = "${aws_security_group.alb_back_alb.id}"
}

output "front_alb" {
  value = "${aws_security_group.front_alb.id}"
}
output "alb_front_alb" {
  value = "${aws_security_group.alb_front_alb.id}"
}