# Create EIP for NAT Gateway
resource "alicloud_eip_address" "eip" {
    address_name         = var.eip_name
    internet_charge_type = var.eip_internet_charge_type
    bandwidth            = var.eip_bandwidth
    isp                  = var.eip_isp
    payment_type         = var.payment_type
}

# Create NAT Gateway
resource "alicloud_nat_gateway" "nat_gw" {
    vpc_id           = var.vpc_id
    nat_type         = var.nat_type
    payment_type     = var.payment_type
    network_type     = var.network_type
    nat_gateway_name = var.nat_gateway_name
    vswitch_id       = var.vswitch_id
}

# Associate EIP with NAT Gateway
resource "alicloud_eip_association" "eip_nat_associate" {
    allocation_id = alicloud_eip_address.eip.id
    instance_id   = alicloud_nat_gateway.nat_gw.id
}

# Create SNAT entries
resource "alicloud_snat_entry" "snat_entries" {
    for_each = toset(var.snat_source_cidrs)
    
    snat_table_id = alicloud_nat_gateway.nat_gw.snat_table_ids
    source_cidr   = each.value
    snat_ip       = alicloud_eip_address.eip.ip_address
    
    depends_on = [alicloud_eip_association.eip_nat_associate]
}

# Add route to NAT Gateway
resource "alicloud_route_entry" "nat_route" {
    count = var.create_route ? 1 : 0
    
    route_table_id        = var.route_table_id
    destination_cidrblock = "0.0.0.0/0"
    nexthop_type          = "NatGateway"
    nexthop_id            = alicloud_nat_gateway.nat_gw.id
}