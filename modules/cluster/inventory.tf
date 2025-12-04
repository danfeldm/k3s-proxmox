output "test" {
  value = proxmox_virtual_environment_vm.master_nodes
}

resource "ansible_group" "all" {
  name = "all"
  variables = {
    ansible_user                 = var.vm_username
    ansible_ssh_private_key_file = var.private_key_path
    ansible_python_interpreter: "/usr/bin/python3"
  }
}

resource "ansible_group" "groups" {
  for_each = toset(["master_nodes", "worker_nodes"])
  name     = each.key
}

resource "ansible_host" "hosts" {
  for_each = merge(local.master_nodes,local.worker_nodes)
  name = each.key
  variables = {
    ansible_host = each.value
  }
  groups = startswith(each.key,"master") ? ["master_nodes"] : ["worker_nodes"]
}
