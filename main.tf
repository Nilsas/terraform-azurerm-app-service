/**
*
* # Azure App Service Module
*/
resource "azurerm_app_service" "prod" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  app_settings            = var.app_settings
  https_only              = var.https_only
  enabled                 = var.enabled
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  tags                    = local.tags

  dynamic "auth_settings" {
    for_each = var.auth_enabled ? [1] : []
    content {
      enabled                        = var.auth_enabled
      issuer                         = var.issuer
      additional_login_params        = var.additional_login_params
      allowed_external_redirect_urls = var.allowed_external_redirect_urls
      default_provider               = var.default_provider
      runtime_version                = var.runtime_version
      token_refresh_extension_hours  = var.token_refresh_extension_hours
      token_store_enabled            = var.token_store_enabled
      unauthenticated_client_action  = var.unauthenticated_client_action

      dynamic "active_directory" {
        for_each = var.auth_active_directory != null ? [1] : []
        content {
          client_id         = var.auth_active_directory["client_id"]
          client_secret     = var.auth_active_directory["client_secret"]
          allowed_audiences = var.auth_active_directory["allowed_audiences"]
        }
      }

      dynamic "facebook" {
        for_each = var.auth_facebook != null ? [1] : []
        content {
          app_id       = var.auth_facebook["app_id"]
          app_secret   = var.auth_facebook["app_secret"]
          oauth_scopes = var.auth_facebook["oauth_scopes"]
        }
      }

      dynamic "google" {
        for_each = var.auth_google != null ? [1] : []
        content {
          client_id     = var.auth_google["client_id"]
          client_secret = var.auth_google["client_secret"]
          oauth_scopes  = var.auth_google["oauth_scopes"]
        }
      }

      dynamic "microsoft" {
        for_each = var.auth_microsoft != null ? [1] : []
        content {
          client_id     = var.auth_microsoft["client_id"]
          client_secret = var.auth_microsoft["client_secret"]
          oauth_scopes  = var.auth_microsoft["oauth_scopes"]
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_string
    content {
      name  = var.connection_string[0]["name"]
      type  = var.connection_string[0]["type"]
      value = var.connection_string[0]["value"]
    }
  }

  site_config {
    always_on        = var.always_on
    app_command_line = var.app_command_line
    cors {
      allowed_origins     = var.cors["allowed_origins"]
      support_credentials = var.cors["support_credentials"]
    }
    default_documents        = var.default_documents
    dotnet_framework_version = var.dotnet_framework_version
    ftps_state               = var.ftps_state
    http2_enabled            = var.http2_enabled

    dynamic "ip_restriction" {
      for_each = var.ip_restriction
      content {
        ip_address                = try(ip_restriction.value["ip_address"], null)
        service_tag               = try(ip_restriction.value["service_tag"], null)
        virtual_network_subnet_id = try(ip_restriction.value["virtual_network_subnet_id"], null)
        name                      = ip_restriction.key
        priority                  = try(ip_restriction.value["priority"], null)
        action                    = try(ip_restriction.value["action"], null)
        headers {
          x_azure_fdid      = try([ip_restriction.value["x_azure_fdid"]], null)
          x_fd_health_probe = try([ip_restriction.value["x_fd_health_probe"]], null)
          x_forwarded_for   = try([ip_restriction.value["x_forwarded_for"]], null)
          x_forwarded_host  = try([ip_restriction.value["x_forwarded_host"]], null)
        }
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = var.scm_ip_restriction
      content {
        ip_address                = try(scm_ip_restriction.value["ip_address"], null)
        service_tag               = try(scm_ip_restriction.value["service_tag"], null)
        virtual_network_subnet_id = try(scm_ip_restriction.value["virtual_network_subnet_id"], null)
        name                      = scm_ip_restriction.key
        priority                  = try(scm_ip_restriction.value["priority"], null)
        action                    = try(scm_ip_restriction.value["action"], null)
        headers {
          x_azure_fdid      = try([scm_ip_restriction.value["x_azure_fdid"]], null)
          x_fd_health_probe = try([scm_ip_restriction.value["x_fd_health_probe"]], null)
          x_forwarded_for   = try([scm_ip_restriction.value["x_forwarded_for"]], null)
          x_forwarded_host  = try([scm_ip_restriction.value["x_forwarded_host"]], null)
        }
      }
    }

    scm_use_main_ip_restriction = length(var.scm_ip_restriction) > 0 ? false : var.scm_use_main_ip_restriction
    php_version                 = var.php_version
    python_version              = var.python_version
    java_version                = var.java == null ? null : var.java["version"]
    java_container              = var.java == null ? null : var.java["container"]
    java_container_version      = var.java == null ? null : var.java["container_version"]
    local_mysql_enabled         = var.local_mysql_enabled
    linux_fx_version            = lower(var.app_service_plan_kind) == "linux" ? var.docker_container != null ? format("DOCKER|%s", var.docker_container) : var.compose_file_path != null ? "COMPOSE|${filebase64(var.compose_file_path)}" : var.kubernetes_file_path != null ? "KUBE|${filebase64(var.kubernetes_file_path)}" : var.linux_fx_version : null
    windows_fx_version          = lower(var.app_service_plan_kind) == "windows" ? var.docker_container != null ? format("DOCKER|%s", var.docker_container) : var.windows_fx_version : null
    managed_pipeline_mode       = var.managed_pipeline_mode
    min_tls_version             = var.min_tls_version
    remote_debugging_enabled    = var.remote_debugging_enabled
    remote_debugging_version    = var.remote_debugging_version
    scm_type                    = var.scm_type
    use_32_bit_worker_process   = var.use_32_bit_worker_process
    websockets_enabled          = var.websockets_enabled
  }

  dynamic "identity" {
    for_each = var.identity ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
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

  dynamic "backup" {
    for_each = var.backup_enabled ? [1] : []
    content {
      enabled             = var.backup_enabled
      name                = format("%s-%s", var.name, var.backup_name)
      storage_account_url = var.backup_storage_account_url
      schedule {
        frequency_interval       = var.backup_schedule["frequency_interval"]
        frequency_unit           = var.backup_schedule["frequency_unit"]
        keep_at_least_one_backup = var.backup_schedule["keep_at_least_one_backup"]
        retention_period_in_days = var.backup_schedule["retention_period_in_days"]
        start_time               = var.backup_schedule["start_time"]
      }
    }
  }

  dynamic "logs" {
    for_each = var.logs_enabled ? [1] : []
    content {

      dynamic "application_logs" {
        for_each = var.app_logs_enabled ? [1] : []
        content {
          azure_blob_storage {
            level             = var.app_logs_azure_blob_storage["level"]
            retention_in_days = var.app_logs_azure_blob_storage["retention_in_days"]
            sas_url           = var.app_logs_azure_blob_storage["sas_url"]
          }
        }
      }

      dynamic "http_logs" {
        for_each = var.http_logs_enabled ? [1] : []
        content {

          dynamic "file_system" {
            for_each = var.http_logs_file_system != null ? [1] : []
            content {
              retention_in_days = var.http_logs_file_system["retention_in_days"]
              retention_in_mb   = var.http_logs_file_system["retention_in_mb"]
            }
          }

          dynamic "azure_blob_storage" {
            for_each = var.http_logs_azure_blob_storage != null ? [1] : []
            content {
              retention_in_days = var.http_logs_azure_blob_storage["retention_in_days"]
              sas_url           = var.http_logs_azure_blob_storage["sas_url"]
            }
          }
        }
      }
    }
  }
}

# Slots don't have storage_account and backup blocks as well as client_cert_enabled variable
# also does not have scm_ip_restrictions
resource "azurerm_app_service_slot" "staging" {
  name                    = "staging"
  app_service_name        = azurerm_app_service.prod.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  app_settings            = var.app_settings
  https_only              = var.https_only
  enabled                 = var.enabled
  client_affinity_enabled = var.client_affinity_enabled
  tags                    = local.tags

  dynamic "auth_settings" {
    for_each = var.auth_enabled ? [1] : []
    content {
      enabled                        = var.auth_enabled
      issuer                         = var.issuer
      additional_login_params        = var.additional_login_params
      allowed_external_redirect_urls = var.allowed_external_redirect_urls
      default_provider               = var.default_provider
      runtime_version                = var.runtime_version
      token_refresh_extension_hours  = var.token_refresh_extension_hours
      token_store_enabled            = var.token_store_enabled

      dynamic "active_directory" {
        for_each = var.auth_active_directory != null ? [1] : []
        content {
          client_id         = var.auth_active_directory["client_id"]
          client_secret     = var.auth_active_directory["client_secret"]
          allowed_audiences = var.auth_active_directory["allowed_audiences"]
        }
      }

      dynamic "facebook" {
        for_each = var.auth_facebook != null ? [1] : []
        content {
          app_id       = var.auth_facebook["app_id"]
          app_secret   = var.auth_facebook["app_secret"]
          oauth_scopes = var.auth_facebook["oauth_scopes"]
        }
      }

      dynamic "google" {
        for_each = var.auth_google != null ? [1] : []
        content {
          client_id     = var.auth_google["client_id"]
          client_secret = var.auth_google["client_secret"]
          oauth_scopes  = var.auth_google["oauth_scopes"]
        }
      }

      dynamic "microsoft" {
        for_each = var.auth_microsoft != null ? [1] : []
        content {
          client_id     = var.auth_google["client_id"]
          client_secret = var.auth_google["client_secret"]
          oauth_scopes  = var.auth_google["oauth_scopes"]
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_string
    content {
      name  = var.connection_string[0]["name"]
      type  = var.connection_string[0]["type"]
      value = var.connection_string[0]["value"]
    }
  }

  site_config {
    always_on        = var.always_on
    app_command_line = var.app_command_line
    cors {
      allowed_origins     = var.cors["allowed_origins"]
      support_credentials = var.cors["support_credentials"]
    }
    default_documents        = var.default_documents
    dotnet_framework_version = var.dotnet_framework_version
    ftps_state               = var.ftps_state
    http2_enabled            = var.http2_enabled

    dynamic "ip_restriction" {
      for_each = var.ip_restriction
      content {
        ip_address                = try(ip_restriction.value["ip_address"], null)
        service_tag               = try(ip_restriction.value["service_tag"], null)
        virtual_network_subnet_id = try(ip_restriction.value["virtual_network_subnet_id"], null)
        name                      = ip_restriction.key
        priority                  = try(ip_restriction.value["priority"], null)
        action                    = try(ip_restriction.value["action"], null)
        headers {
          x_azure_fdid      = try([ip_restriction.value["x_azure_fdid"]], null)
          x_fd_health_probe = try([ip_restriction.value["x_fd_health_probe"]], null)
          x_forwarded_for   = try([ip_restriction.value["x_forwarded_for"]], null)
          x_forwarded_host  = try([ip_restriction.value["x_forwarded_host"]], null)
        }
      }
    }

    php_version               = var.php_version
    python_version            = var.python_version
    java_version              = var.java == null ? null : var.java["version"]
    java_container            = var.java == null ? null : var.java["container"]
    java_container_version    = var.java == null ? null : var.java["container_version"]
    local_mysql_enabled       = var.local_mysql_enabled
    linux_fx_version          = lower(var.app_service_plan_kind) == "linux" ? var.docker_container != null ? format("DOCKER|%s", var.docker_container) : var.compose_file_path != null ? "COMPOSE|${filebase64(var.compose_file_path)}" : var.kubernetes_file_path != null ? "KUBE|${filebase64(var.kubernetes_file_path)}" : null : null
    windows_fx_version        = lower(var.app_service_plan_kind) == "windows" ? var.docker_container != null ? format("DOCKER|%s", var.docker_container) : null : null
    managed_pipeline_mode     = var.managed_pipeline_mode
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

  dynamic "logs" {
    for_each = var.logs_enabled ? [1] : []
    content {
      dynamic "application_logs" {
        for_each = var.app_logs_enabled ? [1] : []
        content {
          azure_blob_storage {
            level             = var.app_logs_azure_blob_storage["level"]
            retention_in_days = var.app_logs_azure_blob_storage["retention_in_days"]
            sas_url           = var.app_logs_azure_blob_storage["sas_url"]
          }
        }
      }

      dynamic "http_logs" {
        for_each = var.http_logs_enabled ? [1] : []
        content {

          dynamic "file_system" {
            for_each = var.http_logs_file_system != null ? [1] : []
            content {
              retention_in_days = var.http_logs_file_system["retention_in_days"]
              retention_in_mb   = var.http_logs_file_system["retention_in_mb"]
            }
          }

          dynamic "azure_blob_storage" {
            for_each = var.http_logs_azure_blob_storage != null ? [1] : []
            content {
              retention_in_days = var.http_logs_azure_blob_storage["retention_in_days"]
              sas_url           = var.http_logs_azure_blob_storage["sas_url"]
            }
          }
        }
      }
    }
  }
}

resource "azurerm_app_service_certificate" "app_cert" {
  count               = var.cert_path != null || var.key_vault_secret_id != null ? 1 : 0
  name                = var.cert_name != null ? var.cert_name : format("%s-cert", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  pfx_blob            = var.cert_path != null ? filebase64(var.cert_path) : null
  password            = var.cert_secret
  key_vault_secret_id = var.key_vault_secret_id
}

resource "azurerm_app_service_custom_hostname_binding" "cert_bind" {
  count               = var.custom_domain != null ? 1 : 0
  hostname            = var.custom_domain
  app_service_name    = azurerm_app_service.prod.name
  resource_group_name = var.resource_group_name
  ssl_state           = var.ssl_state
  thumbprint          = azurerm_app_service_certificate.app_cert[0].thumbprint
}
