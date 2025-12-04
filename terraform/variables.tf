variable "proxmox_url" {
  type        = string
  description = "url of proxmox host"
}

variable "proxmox_username" {
  type        = string
  description = "proxmox username"
  sensitive   = true
}

variable "proxmox_password" {
  type        = string
  description = "proxmox password"
  sensitive   = true
}