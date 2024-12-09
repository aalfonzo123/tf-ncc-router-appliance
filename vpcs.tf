resource "google_compute_network" "vpc-center-1" {
  name                    = "vpc-center-1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc-center-1" {
  name          = "vpc-center-1-us-west4"
  ip_cidr_range = "10.1.0.0/24"
  region        = "us-west4"
  network       = google_compute_network.vpc-center-1.id
}

# resource "google_compute_subnetwork" "vpc-center-1-b" {
#   name          = "vpc-center-1-us-west4-b"
#   ip_cidr_range = "10.90.0.0/24"
#   region        = "us-west4"
#   network       = google_compute_network.vpc-center-1.id
# }

#
resource "google_compute_network" "vpc-edge-2" {
  name                    = "vpc-edge-2"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc-edge-2" {
  name          = "vpc-edge-2-us-west4"
  ip_cidr_range = "10.2.0.0/24"
  region        = "us-west4"
  network       = google_compute_network.vpc-edge-2.id
}

#
resource "google_compute_network" "vpc-edge-3" {
  name                    = "vpc-edge-3"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc-edge-3" {
  name          = "vpc-edge-3-us-west4"
  ip_cidr_range = "10.3.0.0/24"
  region        = "us-west4"
  network       = google_compute_network.vpc-edge-3.id
}

#
resource "google_compute_network" "vpc-edge-4" {
  name                    = "vpc-edge-4"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc-edge-4" {
  name          = "vpc-edge-4-us-west4"
  ip_cidr_range = "10.4.0.0/24"
  region        = "us-west4"
  network       = google_compute_network.vpc-edge-4.id
}
