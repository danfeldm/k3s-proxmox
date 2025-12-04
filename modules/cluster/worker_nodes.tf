resource "proxmox_virtual_environment_vm" "worker_nodes" {
  for_each = local.worker_nodes
  name      = each.key
  node_name = var.proxmox_node_name
  tags      = var.worker_node_config.tags

  agent {
    enabled = true
  }

  cpu {
    cores = var.worker_node_config.cpu_cores
  }

  memory {
    dedicated = var.worker_node_config.memory
  }

  disk {
    datastore_id = var.worker_node_config.disk_storage
    file_id      = proxmox_virtual_environment_download_file.cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.worker_node_config.disk_size
  }
  dynamic "disk" {
    for_each = var.worker_node_config.longhorn_disk_size > 0 ? [1] : []
    content {
      datastore_id = var.worker_node_config.disk_storage
      iothread     = true
      interface    = "virtio1"
      size         = var.worker_node_config.longhorn_disk_size
      serial       = "longhorn-disk"
    }
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value}/24"
        gateway = var.default_gateway
      }
    }

    user_data_file_id = (
      var.worker_node_config.longhorn_disk_size > 0 ?
      proxmox_virtual_environment_file.cloud_init_config_file["longhorn"].id :
      proxmox_virtual_environment_file.cloud_init_config_file["default"].id
    )
  }

  network_device {
    bridge = "vmbr0"
  }
}
