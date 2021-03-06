variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "dns_zone" {
  type = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "cluster_version" {
  description = "The target version of kubernetes"
  type        = string
  default     = "1.21"
}

variable "cert_manager_helm_repo" {
  description = "URL for cert-manager helm chart repository"
  type        = string
  default     = "https://charts.jetstack.io"
}

variable "helm_timeout" {
  description = "Timeout value to wait for helm chart deployment"
  type        = number
  default     = 600
}

variable "eks_map_users" {
  description = "Additional IAM users to add to the aws-auth configmap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "eks_map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "worker_groups" {
  type = list(object({
    name                 = string
    instance_type        = string
    asg_desired_capacity = number
  }))
  default = [
    {
      name                 = "worker-group-1"
      instance_type        = "m5.large"
      asg_desired_capacity = 3
    }
  ]
}

variable "ingress_helm_repo" {
  description = "URL for Ingress Controller helm chart"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "grafana_helm_repo" {
  description = "URL for grafana helm chart repository"
  type        = string
  default     = "https://grafana.github.io/helm-charts"
}

variable "grafana_helm_chart_version" {
  description = "Version for grafana helm chart"
  type        = string
  default     = "6.17.5"
}

variable "k8s_dashboard_helm_repo" {
  description = "A repository url of helm chart to deploy k8s dashboard"
  type        = string
  default     = "https://kubernetes.github.io/dashboard/"
}

variable "k8s_dashboard_helm_chart_version" {
  description = "Helm chart version for k8s_dashboard"
  type        = string
  default     = "5.0.3"
}

