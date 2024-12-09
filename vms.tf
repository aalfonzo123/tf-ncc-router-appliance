resource "google_service_account" "simple-sa" {
  account_id   = "simple-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "vm-center-1" {
  name         = "vm-center-1"
  machine_type = "e2-small"
  zone         = "us-west4-a"

  boot_disk {
    initialize_params {
      image = "debian-12"
      #size  = 30
    }
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  can_ip_forward = "true"
  network_interface {
    subnetwork = google_compute_subnetwork.vpc-center-1.name
  }

  service_account {
    email  = google_service_account.simple-sa.email
    scopes = ["cloud-platform"]
  }

  scheduling {
    provisioning_model          = "SPOT"
    preemptible                 = true
    automatic_restart           = false
    instance_termination_action = "STOP"
  }

  metadata = {
    "enable-oslogin" = "true"
  }
}

# resource "google_compute_instance" "vm-center-1-b" {
#   name         = "vm-center-1-b"
#   machine_type = "e2-small"
#   zone         = "us-west4-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-12"
#       #size  = 30
#     }
#   }

#   shielded_instance_config {
#     enable_secure_boot = true
#   }

#   can_ip_forward = "true"
#   network_interface {
#     subnetwork = google_compute_subnetwork.vpc-center-1-b.name
#   }

#   service_account {
#     email  = google_service_account.simple-sa.email
#     scopes = ["cloud-platform"]
#   }

#   scheduling {
#     provisioning_model          = "SPOT"
#     preemptible                 = true
#     automatic_restart           = false
#     instance_termination_action = "STOP"
#   }

#   metadata = {
#     "enable-oslogin" = "true"
#   }
# }

resource "google_compute_instance" "vm-edge-2" {
  name         = "vm-edge-2"
  machine_type = "e2-small"
  zone         = "us-west4-a"

  boot_disk {
    initialize_params {
      image = "debian-12"
      #size  = 30
    }
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc-edge-2.name
  }

  service_account {
    email  = google_service_account.simple-sa.email
    scopes = ["cloud-platform"]
  }

  scheduling {
    provisioning_model          = "SPOT"
    preemptible                 = true
    automatic_restart           = false
    instance_termination_action = "STOP"
  }

  metadata = {
    "enable-oslogin" = "true"
  }
}

# #
# resource "google_compute_instance" "vm-edge-3" {
#   name         = "vm-edge-3"
#   machine_type = "e2-small"
#   zone         = "us-west4-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-12"
#       #size  = 30
#     }
#   }

#   shielded_instance_config {
#     enable_secure_boot = true
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.vpc-edge-3.name
#   }

#   service_account {
#     email  = google_service_account.simple-sa.email
#     scopes = ["cloud-platform"]
#   }

#   scheduling {
#     provisioning_model          = "SPOT"
#     preemptible                 = true
#     automatic_restart           = false
#     instance_termination_action = "STOP"
#   }

#   metadata = {
#     "enable-oslogin" = "true"
#   }
# }