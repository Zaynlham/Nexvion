variable "aws_region" {
  description = "AWS region for the Nexvion public environment."
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "Name for the new EKS cluster."
  type        = string
  default     = "nexvion-public"
}

variable "eks_api_allowed_cidrs" {
  description = "IPv4 CIDR blocks allowed to reach the EKS Kubernetes API. Use your trusted workstation or VPN CIDR, not 0.0.0.0/0."
  type        = list(string)

  validation {
    condition = length(var.eks_api_allowed_cidrs) > 0 && alltrue([
      for cidr in var.eks_api_allowed_cidrs : can(cidrnetmask(cidr)) && cidr != "0.0.0.0/0"
    ])
    error_message = "Set at least one valid IPv4 CIDR and do not allow the Kubernetes API from 0.0.0.0/0."
  }
}
