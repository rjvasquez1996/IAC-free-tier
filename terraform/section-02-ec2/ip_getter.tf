# Fetch the current public IPv4 address of the machine running Terraform.
# Always fetched, but only used when ssh_whitelist is empty.
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

locals {
  fetched_cidr = "${chomp(data.http.my_ip.response_body)}/32"
  ssh_cidrs    = length(var.ssh_whitelist) > 0 ? var.ssh_whitelist : [local.fetched_cidr]
}
