# Create an azure container registry
resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

# Let the cluster pull from this registry. admin_enabled is false and there is
# no imagePullSecret anywhere, so without this a pod referencing
# acrtflocaltestweu.azurecr.io fails with ImagePullBackOff.
#
# The grant goes to the kubelet identity (the kubelet's own managed identity),
# not the cluster's control-plane identity — pulling images is the kubelet's job.
resource "azurerm_role_assignment" "acr_pull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}