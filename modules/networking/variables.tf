variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR for VNet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR for Subnet"
  type        = string
}


