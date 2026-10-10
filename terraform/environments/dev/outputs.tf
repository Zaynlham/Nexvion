output "vpc_id" {
  description = "ID of the Nexvion VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the Nexvion VPC."
  value       = module.vpc.vpc_cidr_block
}

output "availability_zones" {
  description = "Availability Zones used by the Nexvion VPC."
  value       = module.vpc.azs
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.vpc.private_subnets
}

output "nat_gateway_public_ips" {
  description = "Public IP addresses assigned to the NAT Gateway."
  value       = module.vpc.nat_public_ips
}

output "eks_cluster_name" {
  description = "Name of the Nexvion EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API endpoint of the Nexvion EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  description = "Kubernetes version of the Nexvion EKS cluster."
  value       = module.eks.cluster_version
}

output "eks_cluster_security_group_id" {
  description = "Security group ID associated with the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "eks_node_security_group_id" {
  description = "Security group ID associated with the EKS worker nodes."
  value       = module.eks.node_security_group_id
}
