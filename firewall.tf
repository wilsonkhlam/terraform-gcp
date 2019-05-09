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

  target_tags = ["k8s-master"]
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

  target_tags = ["k8s-worker"]

}

resource "google_compute_firewall" "k8s_worker_node_fw_to_mgmt" {
  name    = "worker-node-firewall-to-mgmt"
  network = "${google_compute_network.k8s_network.self_link}"
  priority = 1
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["3128"]
  }

  target_tags = ["k8s-master", "k8s-worker"]
}

resource "google_compute_firewall" "k8s_worker_node_fw_to_k8scomm" {
  name    = "worker-node-firewall-to-k8scomm"
  network = "${google_compute_network.k8s_network.self_link}"
  priority = 2
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "2379-2380", "10250", "10251", "10252", "30000-32767"]
  }

  destination_ranges = ["172.24.1.0/24", "172.24.2.0/24"]

  target_tags = ["k8s-master", "k8s-worker"]
}

resource "google_compute_firewall" "k8s_worker_node_fw_block" {
  name    = "worker-node-firewall-block"
  network = "${google_compute_network.k8s_network.self_link}"
  priority = 3
  direction = "EGRESS"
  deny {
  	protocol = "tcp"
  }

  target_tags = ["k8s-master", "k8s-worker"]

}


/*
   - Open only port 22 and 3128
   - Open ALL OUTBOUND
*/
resource "google_compute_firewall" "k8s_mgmt_node_fw" {
  name    = "mgmt-node-firewall"
  network = "${google_compute_network.k8s_network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["3128", "22"]
  }

  target_tags = ["management-station"]
}

/* 
    - Open only INBOUND port 22 to public and private access
    - Open ALL OUTBOUND
*/
resource "google_compute_firewall" "k8s_vnc_node_fw" {
  name    = "vnc-node-firewall"
  network = "${google_compute_network.k8s_network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["vnc-server"]
}
