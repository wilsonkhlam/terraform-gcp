provider "google" {
  credentials = "${file("private/account.json")}"
  project = "k8s-cluster-poc-wl"
  region  = "asia-east1"
  zone    = "asia-east1-c"
}
