resource "google_compute_instance" "mgmt_ws_instance" {
  count        = 1 
  name         = "management-station"
  machine_type = "f1-micro"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "projects/gce-uefi-images/global/images/centos-7-v20190326"
    }
  }
 
 tags = [
   "management-station"
 ]

  metadata {
    hostname = "mgmt-ws.k8s-poc.org"
  }

  network_interface {
    subnetwork       = "${google_compute_subnetwork.mgmt_subnetwork.self_link}"
    access_config = {
    }
  }
}