output "nat_gateway_id" {
  value = alicloud_nat_gateway.nat_gw.id
}

output "eip_address" {
  value = alicloud_eip_address.eip.ip_address
}

output "eip_id" {
  value = alicloud_eip_address.eip.id
}