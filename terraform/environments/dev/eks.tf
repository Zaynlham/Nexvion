module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.26.0"

  name               = "nexvion-dev-eks"
  kubernetes_version = "1.34"

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets

  addons = {
    coredns = {}

    eks-pod-identity-agent = {
      before_compute = true
    }

    kube-proxy = {}

    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    nexvion_workers = {
      name = "nexvion-dev-workers"

      subnet_ids = module.vpc.private_subnets

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      capacity_type = "ON_DEMAND"

      disk_size = 20

      labels = {
        Project     = "Nexvion"
        Environment = "dev"
      }
    }
  }

  tags = {
    Project     = "Nexvion"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
