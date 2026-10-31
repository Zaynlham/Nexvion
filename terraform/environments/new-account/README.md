# Nexvion on a new AWS account

This environment is isolated from the existing `dev` Terraform state. It creates a new VPC and an EKS cluster for the public Nexvion demo. It uses the existing public GHCR image and the Kubernetes manifests in `k8s/new-account/`.

## Resources

- A VPC across two availability zones, with public and private subnets.
- One NAT Gateway for private worker-node egress.
- An EKS 1.37 cluster with both private and restricted public API access.
- Two on-demand `t3.small` worker nodes, with room to scale to three.
- A public Kubernetes `LoadBalancer` Service for the website.

The EKS API is restricted to `eks_api_allowed_cidrs`; the website Service is internet-facing. The example CIDR is documentation-only and must be replaced with a trusted workstation or VPN CIDR. The website itself serves HTTP; no domain or TLS certificate is configured.

## Credentials and state

Use an IAM Identity Center role or another dedicated IAM role for Terraform. Do not use AWS root-user access keys. Do not put access keys in Terraform files, `.tfvars`, or the repository.

Terraform state is local to this directory and ignored by Git. Keep it backed up securely. A shared S3 backend should be added before multiple people manage this environment.

## Prepare and review

From this directory:

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set your own trusted CIDR.
2. Authenticate with the dedicated AWS role and confirm it with `aws sts get-caller-identity`.
3. Run `terraform init`, `terraform fmt -check`, `terraform validate`, and `terraform plan`.
4. Review the plan and AWS cost estimate before running `terraform apply`.

After the cluster is created, connect `kubectl` with:

```sh
aws eks update-kubeconfig --region ap-south-1 --name nexvion-public
kubectl apply -f ../../../k8s/new-account/
```

The service address appears in:

```sh
kubectl get service nexvion-web-svc -n nexvion
```

## Monitoring

The existing values file can install the Prometheus Community `kube-prometheus-stack` after the cluster is ready. Grafana stays `ClusterIP`-only; this stack does not expose monitoring dashboards to the public internet.

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  --version 92.16.1 \
  --namespace monitoring \
  --create-namespace \
  --values ../../../monitoring/monitoring-values.yaml
```

This collects cluster and node metrics. The application itself does not expose Prometheus metrics.

The browser app is a demo. Authentication and checkout are client-side only; do not enter real passwords, payment details, or personal data.
