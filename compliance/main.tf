module "app_service" {
  source                = "git@ssh.dev.azure.com:v3/__tenant__/__project_name__/__app_service_module_name__?ref=__app_service_module_branch__"
  resource_group_name   = azurerm_resource_group.main.name
  name                  = local.name
  app_service_plan_id   = azurerm_app_service_plan.main.id
  app_service_plan_kind = azurerm_app_service_plan.main.kind

  # One of [storage_account_id, log_analytics_workspace_id, event_hub_name] has to be supplied
  storage_account_id = module.storage_account.id

  # Container Support
  docker_container = "hello-world:latest"
  # OR
  # compose_file_path = "/path/to/docker-compose.yml"
  # OR
  # kubernetes_file_path = "/path/to/kubernetes.yml"

  # By policy App Service should use authentication
  auth_active_directory = {
    client_id         = var.client_id
    client_secret     = var.client_secret
    allowed_audiences = null
  }

  # IP Restriction Support
  ip_restriction = {
    example_name = {
      ip_address = "78.58.9.80/32"
      priority   = 200
    }
  }

  # Custom Domain Support
  # cert_path     = "certificate.pfx"
  # cert_secret   = data.azurerm_key_vault_secret.example.value
  # custom_domain = "cloudeon.com"
}
