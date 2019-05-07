resource "google_compute_instance" "k8s_worker_instance" {
  count        = 2 
  name         = "k8s-worker-vm-${count.index}"
  machine_type = "n1-standard-2"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "projects/gce-uefi-images/global/images/centos-7-v20190326"
    }
  }
 
 tags = [
   "k8s-worker"
 ]

  metadata {
    hostname = "worker-${count.index}.k8s-poc.org"
    VmDnsSetting = "ZonalOnly"
  }

  network_interface {
    subnetwork       = "${google_compute_subnetwork.k8s_subnetwork_worker.self_link}"
    access_config = {
    }
  }
}
