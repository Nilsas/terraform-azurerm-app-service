output "app_service_plan" {
  value = azurerm_app_service_plan.asp
}

output "app_service" {
  value = azurerm_app_service.prod
}

output "app_service_certificate" {
  value = azurerm_app_service_certificate.app_cert
}

output "app_service_custom_hostname_binding" {
  value = azurerm_app_service_custom_hostname_binding.cert_bind
}