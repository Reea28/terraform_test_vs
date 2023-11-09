# resource "kubernetes_deployment" "my_deployment" {
#   metadata {
#     name = "my-deployment"
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "my-app"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "my-app"
#         }
#       }

#       spec {
#         container {
#           name  = "app"
#           image = "us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0"  # Replace with your actual Docker image
#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "my_service" {
#   provider = kubernetes
#   metadata {
#     name = "my-service"
#   }

#   spec {
#     selector = {
#       app = "my-app"
#     }

#     port {
#       port        = 80
#       target_port = 80
#     }
#     type = "LoadBalancer"
#   }
# }

# resource "kubernetes_ingress_v1" "my_ingress" {
#   metadata {
#     name = "my-ingress"
#   }

#   spec {
#     rule {
#       http {
#         path {
#           path = "/"
#           backend {
#             service_name = kubernetes_service.my_service.metadata.0.name
#             service_port = kubernetes_service.my_service.spec.0.port.0.port
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_ingress_v1" "my_ingress" {
#    metadata {
#       name        = "example-ingress"
#    }
#    spec {
#       rule {
#         http {
#          path {
#            path = "/"
#            backend {
#              service {
#                name = kubernetes_service.my_service.metadata.0.name
#                port {
#                  number = kubernetes_service.my_service.spec.0.port.0.port
#                }
#              }
#            }
#         }
#       }
#     }
#   }
# }
