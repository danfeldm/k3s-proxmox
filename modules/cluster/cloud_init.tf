resource "proxmox_virtual_environment_file" "cloud_init_config_file" {
  for_each     = toset(["default", "longhorn"])
  content_type = "snippets"
  datastore_id = var.vm_cloud_image.storage
  node_name    = var.proxmox_node_name
  source_raw {
    data = templatefile("${path.module}/templates/${each.value}.yaml", {
      ssh_key  = trimspace(file(var.public_key_path)),
      username = var.vm_username,
      timezone = var.vm_timezone,
      longhorn_storage = var.worker_node_config.longhorn_storage_path
    })

    file_name = "${each.value}.yaml"
  }
}

resource "proxmox_virtual_environment_download_file" "cloud_image" {
  content_type = "iso"
  datastore_id = var.vm_cloud_image.storage
  node_name    = var.proxmox_node_name
  url          = var.vm_cloud_image.url
}