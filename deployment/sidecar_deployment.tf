resource "kubernetes_deployment" "sca-project-depl" {
  metadata {
    name = "flask-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "flask"
      }
    }
    template {
      metadata {
        labels = {
          app = "flask"
        }
      }
      spec {
        service_account_name = kubernetes_service_account.kube_sa.metadata.0.name
        container {
          name  = "flask"
          image = "us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0"
          command = ["sleep","infinity"]
        #   port {
        #     container_port = 5000
        #   }

          env {
            name  = "DB_PASS"
            value = var.db_pass
          }
          env {
            name  = "DB_USER"
            value = var.db_user
          }
          env {
            name  = "BD_NAME"
            value = var.db_user
          }
        }
        container {
          name  = "cloud-sql-proxy"
          image = "gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.1.0"
          args = [
            "--private-ip",
            "--structured-logs",
            "--port=3306",
            "valued-watch-401005:us-central1:private-instance-b18d6b30"
          ]
        }
      }

    }
  }
}
