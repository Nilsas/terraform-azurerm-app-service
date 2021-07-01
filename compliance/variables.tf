variable "client_id" {
  type        = string
  default     = ""
  description = "Specifies Service Principal ID (Application ID) to use for App Service Authentication."
}

variable "client_secret" {
  type        = string
  default     = ""
  description = "Specifies Service Principal Secret to use for App Service Authentication."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Specifies the supported Azure location where the resource exists."
}

variable "environment" {
  type        = string
  default     = "d"
  description = "Name of environment (eg., D, T, A, P)"
}
