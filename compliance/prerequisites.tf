locals {
  name = format("az-app-service-%s", replace(lower(random_id.id.b64_url), "_", ""))
}

resource "random_id" "id" {
  byte_length = 5
}

resource "azurerm_resource_group" "main" {
  name     = format("%s-%s", "rg", local.name)
  location = var.location
}

resource "azurerm_app_service_plan" "main" {
  name                = format("%s-%s", "asp", local.name)
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

module "virtual_network" {
  source              = "git@ssh.dev.azure.com:v3/__tenant__/__project_name__/__virtual_network_module_name__?ref=__virtual_network_module_branch__"
  name                = format("vnet-%s", local.name)
  resource_group_name = azurerm_resource_group.main.name
  storage_account_id  = module.storage_account.id
  address_space       = ["10.255.0.0/24"]
  subnet_names        = ["subnet1"]

  subnet_service_endpoints = {
    subnet1 = ["Microsoft.Storage"]
  }

  network_security_group_id = {
    subnet1 = module.network_security_group.network_security_group.id
  }
}

module "network_security_group" {
  source              = "git@ssh.dev.azure.com:v3/__tenant__/__project_name__/__network_security_group_module_name__?ref=__network_security_group_module_branch__"
  name                = lower(format("%s-%s-%s", "nsg", local.name, random_id.id.b64_url))
  resource_group_name = azurerm_resource_group.main.name
  storage_account_id  = module.storage_account.id
}

module "storage_account" {
  source                     = "git@ssh.dev.azure.com:v3/__tenant__/__project_name__/__storage_account_module_name__?ref=__storage_account_module_branch__"
  name                       = lower(format("%s%s", "st", replace(local.name, "/[_-]/", "")))
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  virtual_network_subnet_ids = tolist(module.virtual_network.subnets[*].id)
}
