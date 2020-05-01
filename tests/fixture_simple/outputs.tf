output "hostname" {
  value = format("https://%s", module.appservice.app_service.default_site_hostname)
}