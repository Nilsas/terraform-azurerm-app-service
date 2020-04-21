terraform {
  required_providers {
    azurerm = ">= 2.0.0"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_app_service_plan" "asp" {
  name                = format("%s-asp", var.prefix)
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = var.plan_kind
  reserved            = lower(var.plan_kind) == "windows" ? false : true
  tags                = var.tags

  sku {
    tier = split("_", var.sku)[0]
    size = split("_", var.sku)[1]
  }
}

resource "azurerm_app_service" "prod" {
  name                = format("%s-app", var.prefix)
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  app_settings        = var.app_settings
  https_only          = var.https_only
  enabled             = var.enabled
  tags                = var.tags

  connection_string {
    name  = var.conn_string["name"]
    type  = var.conn_string["type"]
    value = var.conn_string["value"]
  }

  site_config {
    always_on                 = var.always_on
    app_command_line          = var.app_command_line
    dotnet_framework_version  = var.dotnet_framework_version
    php_version               = var.php_version
    python_version            = var.python_version
    java_version              = var.java["version"]
    java_container            = var.java["container"]
    java_container_version    = var.java["container_version"]
    local_mysql_enabled       = var.local_mysql_enabled
    linux_fx_version          = var.docker_container && lower(var.plan_kind) == "linux" ? format("DOCKER|%s", var.docker_container) : null
    windows_fx_version        = var.docker_container && lower(var.plan_kind) == "windows" ? format("DOCKER|%s", var.docker_container) : null
    min_tls_version           = var.min_tls_version
    remote_debugging_enabled  = var.remote_debugging_enabled
    remote_debugging_version  = var.remote_debugging_version
    scm_type                  = var.scm_type
    use_32_bit_worker_process = var.use_32_bit_worker_process
    websockets_enabled        = var.websockets_enabled
  }

  dynamic "identity" {
    for_each = var.identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  dynamic "storage_account" {
    for_each = var.storage_account != null ? [1] : []
    content {
      name         = var.storage_account["name"]
      type         = var.storage_account["type"]
      account_name = var.storage_account["account_name"]
      share_name   = var.storage_account["share_name"]
      access_key   = var.storage_account["access_key"]
      mount_path   = var.storage_account["mount_path"]
    }
  }
}

resource "azurerm_app_service_slot" "staging" {
  name                = "staging"
  app_service_name    = azurerm_app_service.prod.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  app_settings        = var.app_settings
  tags                = var.tags

  site_config {
    linux_fx_version = "DOCKER|nilsas/tf-go-docker:71"
  }

}