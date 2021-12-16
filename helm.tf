resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  repository       = var.cert_manager_helm_repo
  timeout          = var.helm_timeout
  create_namespace = true
  reset_values     = false

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.cert-manager,
  ]
}

