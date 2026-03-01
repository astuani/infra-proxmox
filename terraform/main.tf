resource "proxmox_virtual_environment_vm" "k3s_cluster" {
  for_each = var.k3s_nodes

  name      = each.value.name
  vm_id     = each.value.id
  
  # --- LOGICA DE DISTRIBUIÇÃO ---
  # Se o ID da VM for par, vai para o pve1, se for ímpar, vai para o pve2
  # (Ou você pode basear isso em uma nova propriedade no seu map de variáveis)
  node_name = "pve1"

  # --- CONFIGURAÇÃO PARA O ISTIO ---
  cpu {
    cores = 4
    type  = "host" 
  }

  memory {
    dedicated = 4096 # 4GB de RAM para aguentar o Service Mesh
  }

  clone {
    vm_id 9000
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