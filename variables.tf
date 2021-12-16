variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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

