data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  depends_on = [
    helm_release.ingress-controller,
  ]
}

data "kubernetes_service" "k8s_dashboard" {
  metadata {
    name      = "k8s-dashboard-kubernetes-dashboard"
    namespace = "default"
  }

  depends_on = [
    helm_release.k8s_dashboard,
  ]
}

resource "kubernetes_ingress" "grafana" {

  wait_for_load_balancer = true

  metadata {
    name      = "grafana"
    namespace = "default"

    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "cert-manager"
    }
  }
  spec {
    rule {

      host = "grafana.${var.dns_zone}"

      http {
        path {
          path = "/"
          backend {
            service_name = "grafana"
            service_port = 3000
          }
        }
      }
    }

    tls {
      secret_name = "grafana-tls-secret"
    }
  }

  depends_on = [
    helm_release.grafana,
    helm_release.ingress-controller,
  ]
}


