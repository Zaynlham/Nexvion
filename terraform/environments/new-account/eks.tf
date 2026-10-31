module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.26.0"

  name               = var.cluster_name
  kubernetes_version = "1.37"

  endpoint_private_access      = true
  endpoint_public_access       = true
  endpoint_public_access_cidrs = var.eks_api_allowed_cidrs

  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
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
      name           = "nexvion-public-workers"
      subnet_ids     = module.vpc.private_subnets
      instance_types = ["t3.small"]
      ami_type       = "AL2023_x86_64_STANDARD"

      min_size     = 2
      max_size     = 3
      desired_size = 2

      capacity_type = "ON_DEMAND"
      disk_size     = 20

      labels = {
        Project     = "Nexvion"
        Environment = "public"
      }
    }
  }

  tags = local.common_tags
}
