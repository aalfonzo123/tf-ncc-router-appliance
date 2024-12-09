# resource "google_compute_firewall" "allow-ssh-iap-vpc-center-1" {
#   name    = "allow-ssh-iap"
#   network = "vpc-center-1"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["35.235.240.0/20"]
# }

resource "google_compute_network_firewall_policy" "iap-10-0-policy" {
  name        = "iap-10-0-policy"
  description = "Policy that allows IAP ssh and ping from 10.0.0.0/16"
}

resource "google_compute_network_firewall_policy_rule" "iap-22" {
  rule_name       = "iap-22"
  firewall_policy = google_compute_network_firewall_policy.iap-10-0-policy.id
  action          = "allow"
  direction       = "INGRESS"
  priority        = 1000

  match {
    src_ip_ranges = ["35.235.240.0/20"]

    layer4_configs {
      ip_protocol = "tcp"
      ports       = ["22"]
    }
  }
}

resource "google_compute_network_firewall_policy_rule" "local-ping" {
  rule_name       = "local-ping"
  firewall_policy = google_compute_network_firewall_policy.iap-10-0-policy.id
  action          = "allow"
  direction       = "INGRESS"
  priority        = 1001

  match {
    src_ip_ranges = ["10.0.0.0/8"]

    layer4_configs {
      ip_protocol = "icmp"
    }
  }
}

resource "google_compute_network_firewall_policy_rule" "bgp" {
  rule_name       = "bgp"
  firewall_policy = google_compute_network_firewall_policy.iap-10-0-policy.id
  action          = "allow"
  direction       = "INGRESS"
  priority        = 1002

  match {
    src_ip_ranges = ["10.0.0.0/8"]

    layer4_configs {
      ip_protocol = "tcp"
      ports       = ["179"]
    }
  }
}
#
locals {
  targets = toset([google_compute_network.vpc-center-1.id, google_compute_network.vpc-edge-2.id
  , google_compute_network.vpc-edge-3.id, google_compute_network.vpc-edge-4.id])
}

resource "google_compute_network_firewall_policy_association" "iap-10-0-vpc" {
  for_each          = local.targets
  name              = "iap-10-0-${element(split("/", each.key), length(split("/", each.key)) - 1)}"
  project           = "alf-project-431219"
  attachment_target = each.key
  firewall_policy   = google_compute_network_firewall_policy.iap-10-0-policy.id
}
