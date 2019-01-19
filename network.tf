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


resource "google_compute_firewall" "k8s_master_node_fw" {
  name    = "master-node-firewall"
  network = "${google_compute_network.k8s_network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "2379-2380", "10250", "10251", "10252"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["k8s-master"]
}

resource "google_compute_firewall" "k8s_worker_node_fw" {
  name    = "worker-node-firewall"
  network = "${google_compute_network.k8s_network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "10250", "30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
  source_tags = ["k8s-worker"]
}
