resource "google_compute_network" "k8s_network" {
  name                    = "k8s-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s_subnetwork_master" {
  name                    = "k8s-master-subnetwork"
  ip_cidr_range = "172.24.1.0/24"
  network = "${google_compute_network.k8s_network.self_link}"
}

resource "google_compute_subnetwork" "k8s_subnetwork_worker" {
  name                    = "k8s-worker-subnetwork"
  ip_cidr_range = "172.24.2.0/24"
  network = "${google_compute_network.k8s_network.self_link}"
}


resource "google_compute_subnetwork" "mgmt_subnetwork" {
  name                    = "mgmt-subnetwork"
  ip_cidr_range = "172.24.3.0/24"
  network = "${google_compute_network.k8s_network.self_link}"
}

resource "google_compute_subnetwork" "vnc_subnetwork" {
  name                    = "vnc-subnetwork"
  ip_cidr_range = "172.24.4.0/24"
  network = "${google_compute_network.k8s_network.self_link}"
}