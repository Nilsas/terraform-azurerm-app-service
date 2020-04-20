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
  reserved            = var.plan_kind == "Windows" || var.plan_kind == "App" ? false : true
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

  dynamic "identity" {
    for_each = var.identity == true ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  site_config {
    always_on                = var.always_on
    app_command_line         = var.app_command_line
    dotnet_framework_version = var.dotnet_framework_version
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