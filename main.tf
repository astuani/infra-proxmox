resource "proxmox_virtual_environment_vm" "k3s_cluster" {
  # O segredo está aqui: o for_each cria uma VM para cada item da variável
  for_each = var.k3s_nodes

  name      = each.value.name
  node_name = "pve1"
  vm_id     = each.value.id

  clone {
    vm_id = 9000 # Seu template de 100GB
  }

  initialization {
    datastore_id = "Dados"

    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.vm_gateway
      }
    }

    user_account {
      username = "astuani"
      password = var.vm_user_password
      keys     = [var.ssh_public_key]
    }
  }

  network_device {
    bridge = "vmbr0"
  }
}