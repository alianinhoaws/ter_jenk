
provider "google" {
  credentials = "${file("/home/aws/eco-tenure-238419-ad5a7923a5b3.json")}"
  project = "eco-tenure-238419"
  region = "europe-west3"
  zone = "europe-west3-c"
}


resource "google_compute_instance" "http" {
  count = 1
  name         = "ubuntu${count.index}"
  machine_type = "g1-small"
	
metadata_startup_script = <<EOF
#!/bin/bash
apt update
sudo apt-get -y update
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get -y update 
sudo apt-get -y install python 3.6
"}

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
	
    }
   }
  network_interface {
   network = "default"
    access_config {
   }
}
}

resource "google_compute_instance" "centos"{
   count = 1
   name = "centos${count.index}"
   machine_type = "g1-small"

metadata_startup_script = <<EOF
#!/bin/bash
sudo yum update
sudo apt-get -y update
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip
"}

   boot_disk {
    initialize_params{
     image = "centos-cloud/centos-7"

  }
 }
  network_interface {
    network       = "default"
    access_config {
    }
  }

} 
resource "google_compute_project_metadata_item" "default" {
  key = "sshKeys"
  value = "${"alianinho"}:${file("/home/aws/gcp-key.pub")}"
}
