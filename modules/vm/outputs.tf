output "public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.this.ip_address
}


