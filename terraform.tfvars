environment          = "dev"
region               = "us-east-1"
availability_zones   = ["us-east-1a", "us-east-1b"]
vpc_cidr             = "10.0.0.0/16"
public_subnets_cidr  = ["10.0.0.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.1.0/24", "10.0.3.0/24"]
amazon_machine_image = "ami-0b0ea68c435eb488d"
instance_type        = "t2.micro"

