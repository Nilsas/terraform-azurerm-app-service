output "app_service" {
  value       = azurerm_app_service.prod
  description = "Outputs a full App Service Object from this module"
}

output "app_servie_slot" {
  value       = azurerm_app_service_slot.staging
  description = "Outputs a full App Service Slot Object from this module"
}

output "app_service_certificate" {
  value       = azurerm_app_service_certificate.app_cert
  description = "Outputs a full App Service Certificate Object from this module"
}

output "app_service_custom_hostname_binding" {
  value       = azurerm_app_service_custom_hostname_binding.cert_bind
  description = "Outputs a full App Service Custom Hostname Binding Object from this module"
}

output "diagnostic_setting" {
  value       = azurerm_monitor_diagnostic_setting.main
  description = "Outputs Diagnostic settings of Redis Cache."
}
