variable "default_gateway" {
  type        = string
  description = "Default gateway for Proxmox VMs in the K3s cluster"
}

variable "master_node_config" {
  type = object({
    disk_size    = optional(number, 20)
    disk_storage = optional(string, "local-lvm")
    memory       = optional(number, 2048)
    cpu_cores    = optional(number, 2)
    tags         = optional(list(string), ["k3s", "master-node"])
  })
  default     = {}
  description = "Config for K3S master node VMs"
}

variable "master_node_ips" {
  type        = list(string)
  default     = []
  description = "Proxmox VMs to provision as K3s master nodes"
}

variable "private_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519"
  description = "Path on local machine to SSH private key, for remote access to Proxmox VMs"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "Path on local machine to SSH public key for Proxmox VMs"
}

variable "snippet_storage" {
  type = string
  default = "local"
  description = "Storage identifier for cloud-init snippets"
}

variable "vm_cloud_image" {
  type = object({
    storage = optional(string, "local") #Storage identifier for cloud image
    url     = optional(string, "https://cloud-images.ubuntu.com/plucky/current/plucky-server-cloudimg-amd64.img")
  })
  default     = {}
  description = "Cloud image for Proxmox VMs. Default is Ubuntu 25.04 Jammy"
}

variable "vm_timezone" {
  type        = string
  description = "Timezone for Proxmox VMs"
  default     = "America/New_York"
}

variable "vm_username" {
  type        = string
  description = "Username for Proxmox VMs"
  default     = "ubuntu"
}

variable "worker_node_config" {
  type = object({
    disk_size             = optional(number, 20)
    disk_storage          = optional(string, "local-lvm")
    longhorn_disk_size    = optional(number, 50) #Additional disk to provision for longhorn storage
    longhorn_storage_path = optional(string, "/mnt/longhorn")
    memory                = optional(number, 8192)
    cpu_cores             = optional(number, 4)
    tags                  = optional(list(string), ["k3s", "worker-node"])
  })
  default     = {}
  description = "Config for K3s worker node VMs"
}

variable "worker_node_ips" {
  type        = list(string)
  default     = []
  description = "Proxmox VMs to provision as K3s worker nodes"
}


variable "proxmox_node_name" {
  type        = string
  description = "Name of proxmox node"
}