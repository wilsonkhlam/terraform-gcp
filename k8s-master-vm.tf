resource "google_compute_instance" "k8s_master_instance" {
  count        = 1 
  name         = "k8s-master-vm-${count.index}"
  machine_type = "n1-standard-2"
#  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "coreos-cloud/coreos-stable-1967-3-0-v20190108"
    }
  }
 
 tags = [
   "k8s-master"
 ]

  metadata {
    hostname = "master-${count.index}.k8s-poc.org"
  }

  network_interface {
    subnetwork       = "${google_compute_subnetwork.k8s_subnetwork_master.self_link}"
    access_config = {
    }
  }

 provisioner "local-exec" {
	command = "echo hello > /tmp/ppp"
 }

}
