locals {
  master_nodes = { for idx,ip in var.master_node_ips : "master-node-${idx+1}" => ip}  
  worker_nodes = { for idx,ip in var.worker_node_ips : "worker-node-${idx+1}" => ip}  
}