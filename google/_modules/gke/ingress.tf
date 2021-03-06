resource "google_compute_address" "current" {
  count = var.disable_default_ingress ? 0 : 1

  region  = google_container_cluster.current.location
  project = var.project

  name = var.metadata_name
}

resource "kubernetes_service" "current" {
  count = var.disable_default_ingress ? 0 : 1

  provider = kubernetes.gke

  metadata {
    name      = "ingress-kbst-default"
    namespace = "ingress-kbst-default"
  }

  spec {
    type             = "LoadBalancer"
    load_balancer_ip = google_compute_address.current[0].address

    selector = {
      "kubestack.com/ingress-default" = "true"
    }

    port {
      name        = "http"
      port        = 80
      target_port = "http"
    }

    port {
      name        = "https"
      port        = 443
      target_port = "https"
    }
  }

  # the cluster_services module creates the ingress-kbst-default namespace
  depends_on = [module.cluster_services]
}

resource "google_dns_managed_zone" "current" {
  count = var.disable_default_ingress ? 0 : 1

  project = var.project

  name     = var.metadata_name
  dns_name = "${var.metadata_fqdn}."
}

resource "google_dns_record_set" "host" {
  count = var.disable_default_ingress ? 0 : 1

  project = var.project

  name = google_dns_managed_zone.current[0].dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.current[0].name

  rrdatas = [google_compute_address.current[0].address]
}

resource "google_dns_record_set" "wildcard" {
  count = var.disable_default_ingress ? 0 : 1

  project = var.project

  name = "*.${google_dns_managed_zone.current[0].dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.current[0].name

  rrdatas = [google_compute_address.current[0].address]
}
