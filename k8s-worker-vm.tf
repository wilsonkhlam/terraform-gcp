resource "google_compute_instance" "k8s_worker_instance" {
  count        = 2 
  name         = "k8s-worker-vm-${count.index}"
  machine_type = "f1-micro"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "coreos-cloud/coreos-stable"
    }
  }
 
 tags = [
   "k8s-worker"
 ]

  metadata {
    hostname = "worker-${count.index}.k8s-poc.org"
  }

  network_interface {
    subnetwork       = "${google_compute_subnetwork.k8s_subnetwork_master.self_link}"
    access_config = {
    }
  }
}
