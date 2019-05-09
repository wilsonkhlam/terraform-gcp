resource "google_compute_instance" "k8s_master_instance" {
  count        = 1 
  name         = "k8s-master-vm-${count.index}"
  machine_type = "n1-standard-2"
  boot_disk {
    initialize_params {
      image = "projects/gce-uefi-images/global/images/centos-7-v20190326"
    }
  }
 
 tags = [
   "k8s-master"
 ]

  metadata {
    hostname = "master-${count.index}.k8s-poc.org"
    VmDnsSetting = "ZonalOnly"
  }

  network_interface {
    subnetwork       = "${google_compute_subnetwork.k8s_subnetwork_master.self_link}"
    access_config = {
    }
  }

}
