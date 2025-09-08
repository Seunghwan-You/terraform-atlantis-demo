variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "koreacentral"
}

variable "vnet_cidr" {
  description = "CIDR for VNet"
  type        = string
  default     = "10.20.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR for Subnet"
  type        = string
  default     = "10.20.1.0/24"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for VM login"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "prod"
    ManagedBy   = "Terraform"
    Project     = "Atlantis-GitOps"
  }
}


