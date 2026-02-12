resource "proxmox_virtual_environment_vm" "master_nodes" {
  count = length(var.master_node_ips)
  name      = "master-node-${count.index+1}"
  node_name = var.proxmox_node_name
  tags      = var.master_node_config.tags

  agent {
    enabled = true
  }

  cpu {
    cores = var.master_node_config.cpu_cores
  }

  memory {
    dedicated = var.master_node_config.memory
  }

  disk {
    datastore_id = var.master_node_config.disk_storage
    file_id      = proxmox_virtual_environment_download_file.cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.master_node_config.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${var.master_node_ips[count.index]}/24"
        gateway = var.default_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_init_config_file["default"].id

  }

  network_device {
    bridge = "vmbr0"
  }
}