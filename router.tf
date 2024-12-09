resource "google_compute_router" "gcp-router" {
  name    = "gcp-router"
  region  = "us-west4"
  network = google_compute_network.vpc-center-1.id
  bgp {
    advertise_mode = "CUSTOM"
    asn            = 64514
    # advertised_ip_ranges {
    #   range = "10.2.0.0/24"
    # }
  }
}

resource "google_compute_router_nat" "gcp-router-nat" {
  name                               = "gcp-router-nat"
  router                             = google_compute_router.gcp-router.name
  region                             = google_compute_router.gcp-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_address" "gcp-router-interface-addr" {
  name         = "gcp-router-interface-addr"
  region       = "us-west4"
  subnetwork   = google_compute_subnetwork.vpc-center-1.id
  address_type = "INTERNAL"
}

resource "google_compute_address" "gcp-router-interface-addr-redundant" {
  name         = "gcp-router-interface-addr-redundant"
  region       = "us-west4"
  subnetwork   = google_compute_subnetwork.vpc-center-1.id
  address_type = "INTERNAL"
}

resource "google_compute_router_interface" "gcp-router-interface-redundant" {
  name               = "gcp-router-interface-redundant"
  region             = "us-west4"
  router             = google_compute_router.gcp-router.name
  subnetwork         = google_compute_subnetwork.vpc-center-1.id
  private_ip_address = google_compute_address.gcp-router-interface-addr-redundant.address
}

resource "google_compute_router_interface" "gcp-router-interface" {
  name                = "gcp-router-interface"
  region              = "us-west4"
  router              = google_compute_router.gcp-router.name
  subnetwork          = google_compute_subnetwork.vpc-center-1.id
  private_ip_address  = google_compute_address.gcp-router-interface-addr.address
  redundant_interface = google_compute_router_interface.gcp-router-interface-redundant.name
}

resource "google_compute_router_peer" "gcp-router-vm-peer" {
  name                          = "gcp-router-vm-peer"
  router                        = google_compute_router.gcp-router.name
  region                        = "us-west4"
  interface                     = google_compute_router_interface.gcp-router-interface.name
  router_appliance_instance     = google_compute_instance.vm-center-1.self_link
  custom_learned_route_priority = 500
  advertised_route_priority     = 600
  peer_asn                      = 65513
  peer_ip_address               = google_compute_instance.vm-center-1.network_interface.0.network_ip
}