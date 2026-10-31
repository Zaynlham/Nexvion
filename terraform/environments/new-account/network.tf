data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  common_tags = {
    Project     = "Nexvion"
    Environment = "public"
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "nexvion-public-vpc"
  cidr = "10.20.0.0/16"

  azs = local.availability_zones

  public_subnets = [
    "10.20.0.0/24",
    "10.20.1.0/24",
  ]

  private_subnets = [
    "10.20.10.0/24",
    "10.20.11.0/24",
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = local.common_tags
}
