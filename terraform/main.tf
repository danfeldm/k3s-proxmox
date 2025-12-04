module "cluster" {
  source            = "../modules/cluster"
  proxmox_node_name = "proxmox1"
  
  default_gateway   = "192.168.0.1"
  master_node_ips = ["192.168.0.100", "192.168.0.101", "192.168.0.102"]
  worker_node_ips = ["192.168.0.103", "192.168.0.104"]

  #attach an additional 50GB disk to each worker-node for longhorn storage 
  worker_node_config= {
    longhorn_disk_size = 50
  }
}