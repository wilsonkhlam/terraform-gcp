provider "google" {
  credentials = "${file("private/account.json")}"
  project = "k8s-cluster-poc-wl"
  region  = "asia-east2"
  zone    = "asia-east2-c"
}
