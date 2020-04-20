variable "location" {
  type        = string
  default     = "westeurope"
  description = "This variable will point all resource into one Azure location"
}

variable "resource_group_name" {
  type        = string
  default     = "my-resource-group"
  description = "This will tell us to which resource group we need to deploy the resources of this module"
}

variable "prefix" {
  type        = string
  default     = "my-prefix"
  description = "This variable is used to unify all resource naming within this module"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "This variable is used to refference same tags through all resources"
}

variable "plan_kind" {
  type        = string
  default     = "Windows"
  description = "(Optional) The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan)."
}

variable "sku" {
  type        = string
  default     = "Standard_S1"
  description = "Plan's Pricing tier and size noted similarly as Azure VM sizes are written. Example: Standard_S1"
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Map of KEY = VALUE pairs to pass to App Service environment, all values will be registered as plain text environment variables"
}

variable "conn_string" {
  type        = object({
    name  = string
    type  = string
    value = string
  })
  default     = {
    name  = ""
    type  = ""
    value = ""
  }
  description = "Possible type values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Can the App Service only be accessed via HTTPS?"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Is the App Service Enabled?"
}

variable "indetity" {
  type        = bool
  default     = false
  description = "Toggle for SystemAssigned managed identity. Defaults to false"
}

variable "always_on" {
  type        = fool
  default     = true
  description = "Should the app be loaded at all times?"
}

variable "app_command_line" {
  type        = string
  default     = ""
  description = "App command line to launch, e.g. /sbin/myserver -b 0.0.0.0"
}

variable "dotnet_framework_version" {
  type        = string
  default     = null
  description = "The version of the .net framework's CLR used in this App Service. See https://en.wikipedia.org/wiki/.NET_Framework_version_history#Overview"
}