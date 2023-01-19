provider "aws" {
  region = var.region
  alias  = "east"
  shared_config_files      = ["~/Desktop/conf"]
  shared_credentials_files = ["~/Desktop/mycredintial"]
  profile                  = "default"

}


module "network" {
  source = "./networking"

  vpc_cidr = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.0.0/24","10.0.2.0/24"]
  private_subnets_cidr = ["10.0.1.0/24","10.0.3.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  environment          = "dev"
  region               = "us-east-1"
}
