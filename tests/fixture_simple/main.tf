provider "azurerm" {
  features {}
}

locals {
  name = format("tf%s", replace(lower(random_id.id.b64_url), "_", ""))
}

resource "random_id" "id" {
  byte_length = 5
}

data "http" "ip" {
  url = "https://api.ipify.org/"
}

resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = format("rg-%s", local.name)
  tags = {
    Application = "Terratest"
    Environment = "Development"
  }
}

resource "azurerm_app_service_plan" "asp" {
  name                = format("asp-%s", local.name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true
  tags                = azurerm_resource_group.rg.tags

  sku {
    tier = "Standard"
    size = "S1"
  }
}

module "appservice" {
  source                = "../../"
  resource_group_name   = azurerm_resource_group.rg.name
  tags                  = azurerm_resource_group.rg.tags
  name                  = local.name
  app_service_plan_id   = azurerm_app_service_plan.asp.id
  app_service_plan_kind = azurerm_app_service_plan.asp.kind

  docker_container = "hello-world:latest"

  ip_restriction  = {
    allow_agent = {
      ip_address = "${data.http.ip.body}/32"
    }
  }

  logs_enabled          = true
  http_logs_enabled     = true
  http_logs_file_system = {
    retention_in_days = 30
    retention_in_mb   = 50
  }
}
