variable "environment" {
  description = "The deployment environment"
  default     = "dev"
}

variable "region" {
  description = "The AWS Region"
}

variable "availability_zones" {
  type        = list(any)
}

variable "vpc_cidr" {
}

variable "public_subnets_cidr" {
  type        = list(any)
}

variable "private_subnets_cidr" {
  type        = list(any)
}
variable "amazon_machine_image" {
  default = "ami-0b0ea68c435eb488d"
}
variable "instance_type" {
  default = "t2.micro"
}
