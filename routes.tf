# resource "google_compute_route" "gateway-center-edge-2" {
#   name        = "gateway-center-edge-2"
#   dest_range  = "10.0.0.0/8"
#   network     = google_compute_network.vpc-edge-2.name
#   next_hop_ip = "10.1.0.2"
#   priority    = 100
# }

# resource "google_compute_route" "gateway-center-edge-3" {
#   name        = "gateway-center-edge-3"
#   dest_range  = "10.0.0.0/8"
#   network     = google_compute_network.vpc-edge-3.name
#   next_hop_ip = "10.1.0.2"
#   priority    = 100
# }

