variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT Gateway"
}

variable "eip_name" {
  type        = string
  description = "Name of the EIP"
}

variable "vswitch_id" {
  type        = string
  description = "VSwitch ID for NAT Gateway"
}

variable "route_table_id" {
  type        = string
  description = "Route table ID"
}

variable "snat_source_cidrs" {
  type        = list(string)
  description = "Source CIDRs for SNAT entries"
}

variable "nat_type" {
  type        = string
  description = "NAT Gateway type"
}

variable "payment_type" {
  type        = string
  description = "Payment type"
}

variable "network_type" {
  type        = string
  description = "Network type"
}

variable "eip_bandwidth" {
  type        = number
  description = "EIP bandwidth in Mbps"
}

variable "eip_internet_charge_type" {
  type        = string
  description = "EIP charge type"
}

variable "eip_isp" {
  type        = string
  description = "EIP ISP"
}

variable "create_route" {
  type        = bool
  description = "Whether to create route to NAT Gateway"
  default     = true
}