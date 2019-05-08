/*
resource "google_compute_instance" "vnc_instance" {
  count        = 1 
  name         = "vnc-server"
  machine_type = "g1-small"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "projects/gce-uefi-images/global/images/ubuntu-1804-bionic-v20190429"
    }
  }
 
 tags = [
   "vnc-server"
 ]

  metadata {
    hostname = "vnc-server.k8s-poc.org"
    VmDnsSetting = "ZonalOnly"
  }

  network_interface {
    subnetwork       = "${google_compute_subnetwork.vnc_subnetwork.self_link}"
    access_config = {
    }
  }
}
*/
