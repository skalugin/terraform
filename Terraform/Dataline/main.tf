
terraform {
  # Версия terraform
  required_version = ">=0.12.0"
}

# Настройка провайдера для подключения к vCloud Director
provider "vcd" {
  version              = "~> 2.6"
  user                 = var.vcd_org_user
  password             = var.vcd_org_password
  org                  = var.vcd_org_org
  vdc                  = var.vcd_org_vdc
  url                  = var.vcd_org_url
  allow_unverified_ssl = var.vcd_org_allow_unverified_ssl
  max_retry_timeout    = var.vcd_org_max_retry_timeout
}

# Создание маршрутизируемой сети
resource "vcd_network_routed" "internalRouted" {
  name         = "Routed 192.168.1.0/24"
# Указывается имя edge шлюза
  edge_gateway = var.vcd_org_edge_name
# Шлюз сети организации
  gateway = "192.168.1.1"
# 
  dhcp_pool {
    start_address = "192.168.1.2"
    end_address   = "192.168.1.100"
  }

  static_ip_pool {
    start_address = "192.168.1.101"
    end_address   = "192.168.1.254"
  }
}

# Создание vApp

resource "vcd_vapp" "vms" {
  name = "application"
  power_on = "true"

  depends_on = [vcd_network_routed.internalRouted]
}

# Создание виртуальной машины vm1 в vApp

resource "vcd_vapp_vm" "vm1" {
  vapp_name     = vcd_vapp.vms.name
  name          = "applica_vm1"
  catalog_name  = var.vcd_org_catalog
  template_name = var.template_vm
  memory        = 2048
  cpus          = 2
  cpu_cores     = 1

  depends_on = [vcd_network_routed.internalRouted, vcd_vapp.vms]

  network {
    type               = "org"
    name               = vcd_network_routed.internalRouted.name
    ip                 = "192.168.1.101"
    ip_allocation_mode = "MANUAL"
  }
  }
