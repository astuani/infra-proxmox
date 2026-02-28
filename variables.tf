variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "vm_user_password" {
  type      = string
  sensitive = true
}

variable "ssh_public_key" {
  type = string
}

variable "k3s_nodes" {
  type = map(object({
    id   = number
    ip   = string
    name = string
  }))
  default = {
    "node-1" = { id = 201, ip = "192.168.15.201", name = "k3s-master-1" }
    "node-2" = { id = 202, ip = "192.168.15.202", name = "k3s-master-2" }
    "node-3" = { id = 203, ip = "192.168.15.203", name = "k3s-master-3" }
    "node-4" = { id = 204, ip = "192.168.15.204", name = "k3s-worker-1" }
    "node-5" = { id = 205, ip = "192.168.15.205", name = "k3s-worker-2" }
  }
}

variable "vm_gateway" {
  type    = string
  default = "192.168.15.1"
}