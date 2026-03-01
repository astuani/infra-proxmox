terraform {
  cloud {
    organization = "astuani" # Crie uma conta gratuita em app.terraform.io

    workspaces {
      name = "k3s-proxmox-infra"
    }
  }
}