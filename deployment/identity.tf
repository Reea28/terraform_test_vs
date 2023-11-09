resource "google_service_account" "kube_identity" {
  account_id   = "kube-identity"
  display_name = "kube-identity"
  description  = "custom service account to authenticate for kubernetes service account"
}
//bind the service account to necessary IAM roles 
resource "google_project_iam_member" "roles" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.kube_identity.email}"
}

resource "kubernetes_service_account" "kube_sa" {
  metadata {
    name      = "kubernetes-sa"
    namespace = "default"
    annotations = {
      "iam.gke.io/gcp-service-account" = "${google_service_account.kube_identity.email}"
    }
  }
}

resource "google_service_account_iam_binding" "ksa-bind" {
  service_account_id = google_service_account.kube_identity.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[kns/ksa]"
  ]
}
