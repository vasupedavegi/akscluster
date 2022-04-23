resource "azurerm_kubernetes_cluster" "aks_cluster" {
  dns_prefix          = var.resource_group_name
  location            = var.location
  name                = "${var.resource_group_name}-cluster"
  resource_group_name = var.resource_group_name
  kubernetes_version  = "1.22.6"
  node_resource_group = "${var.resource_group_name}-nrg1"


  default_node_pool {
    name       = "systempool"
    vm_size    = "Standard_DS2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type           = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = var.environment
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = var.environment
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }    
  }

# Identity (System Assigned or Service Principal)
  identity { type = "SystemAssigned" }

# Add On Profiles
  addon_profile {
    azure_policy { enabled = true }
    oms_agent {
      enabled                    = false
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }
  }
  

# RBAC and Azure AD Integration Block
#role_based_access_control {
#  enabled = false
#  azure_active_directory {
#    managed                = true
#    admin_group_object_ids = [azuread_group.aks_administrators.id]
#  }
#}  

# Windows Admin Profile
windows_profile {
  admin_username            = var.windows_admin_username
  admin_password            = var.windows_admin_password
}

# Linux Profile
linux_profile {
  admin_username = "ubuntu"
  ssh_key {
      key_data = file(var.ssh_public_key)
  }
}

# Network Profile
network_profile {
  load_balancer_sku = "Standard"
  network_plugin = "azure"
}

# AKS Cluster Tags 
tags = {
  Environment = var.environment
}


}
