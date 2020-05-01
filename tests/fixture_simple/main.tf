provider "azurerm" {
  features {}
}

locals {
  prefix = format("tf%s", lower(random_id.id.b64_url))
}

resource "random_id" "id" {
  byte_length = 5
}

resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = format("%s-rg", local.prefix)
  tags     = {
    Application     = "Terratest"
    CreatedBy       = "Nilsas.Firantas@centric.eu"
    Department      = "Cloud Services"
    EnvironmentType = "Development"
  }
}

module "appservice" {
  source               = "../../"
  resource_group_name  = azurerm_resource_group.rg.name
  tags                 = azurerm_resource_group.rg.tags
  prefix               = local.prefix
  plan_kind            = "linux"
  allowed_ip_addresses = ["78.58.9.80/32"]
}