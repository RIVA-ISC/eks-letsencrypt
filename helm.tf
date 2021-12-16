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

resource "helm_release" "ingress-controller" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = var.ingress_helm_repo
  timeout          = var.helm_timeout
  create_namespace = false
  reset_values     = false

  set {
    name  = "controller.ingressClassResource.name"
    value = "insecure"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.ingress-nginx
  ]
}

resource "helm_release" "grafana" {
  name             = "grafana"
  chart            = "grafana"
  namespace        = "default"
  repository       = var.grafana_helm_repo
  timeout          = var.helm_timeout
  version          = var.grafana_helm_chart_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

 depends_on = [
    module.eks,
  ]
}