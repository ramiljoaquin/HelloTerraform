provider "kubernetes" {
  config_context_auth_info = "clusterUser_Ubidy.IT.Kubernetes.SoutheastAsia.DevLab_ubidy-kube-devlab"
  config_context_cluster   = "ubidy-kube-devlab"
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = "my-first-devlab-namespace"
  }
}