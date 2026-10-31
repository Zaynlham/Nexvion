output "aws_region" {
  description = "AWS region hosting Nexvion."
  value       = var.aws_region
}

output "eks_cluster_name" {
  description = "Name of the Nexvion EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API endpoint for the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "ID of the new Nexvion VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnets used by internet-facing load balancers."
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Private subnets used by EKS worker nodes."
  value       = module.vpc.private_subnets
}
