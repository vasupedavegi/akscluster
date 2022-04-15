# Create Outputs
# 1. Resource Group Location
# 2. Resource Group Id
# 3. Resource Group Name

# Resource Group Outputs
output "location" {
  value = var.location
}

output "resource_group_id" {
  value = "/subscriptions/c9a2c4bf-579f-4d52-99f6-2555e370f4a5/resourceGroups/RG-Container"
}

output "resource_group_name" {
  value = var.resource_group_name
}

# Azure AKS Versions Datasource
output "versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}

output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}

# Azure AD Group Object Id
# output "azure_ad_group_id" {
#   value = azuread_group.aks_administrators.id
# }
# output "azure_ad_group_objectid" {
#   value = azuread_group.aks_administrators.object_id
# }


# Azure AKS Outputs

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
}
