variable "location" {
  type        = string
  default     = "westeurope"
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "(Required) The name of the resource group in which to create the App Service."
}

variable "name" {
  type        = string
  default     = null
  description = "(Required) Specifies the name of the App Service. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "app_service_plan_id" {
  type        = string
  default     = null
  description = "(Required) The ID of the App Service Plan within which to create this App Service."
}

variable "app_service_plan_kind" {
  type        = string
  default     = null
  description = "(Required) The kind used for app service plan. Possible values are: 'Windows' and 'Linux'. Defaults to 'Windows'."
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "(Optional) Map of KEY = VALUE pairs to pass to App Service environment, all values will be registered as plain text environment variables."
}

variable "connection_string" {
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default     = []
  description = "(Optional) Possible type values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "(Optional) Can the App Service only be accessed via HTTPS?"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "(Optional) Is the App Service Enabled?"
}

variable "client_affinity_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
}

variable "client_cert_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Does the App Service require client certificates for incoming requests? Defaults to false."
}

variable "identity" {
  type        = bool
  default     = true
  description = "(Optional) Toggle for SystemAssigned managed identity. Defaults to true."
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "(Optional) Specifies the identity type of the App Service. Possible values are SystemAssigned (where Azure will generate a Service Principal for you), UserAssigned where you can specify the Service Principal IDs in the identity_ids field."
}

variable "identity_ids" {
  type        = list(string)
  default     = null
  description = "(Optional) Specifies a list of user managed identity ids to be assigned. Required if type is UserAssigned."
}

variable "always_on" {
  type        = bool
  default     = false
  description = "(Optional) Should the app be loaded at all times? Defaults to false."
}

variable "app_command_line" {
  type        = string
  default     = ""
  description = "(Optional) App command line to launch, e.g. '/sbin/myserver -b 0.0.0.0'."
}

variable "cors" {
  type = object({
    allowed_origins     = list(string)
    support_credentials = bool
  })
  default = {
    allowed_origins     = []
    support_credentials = null
  }
  description = "(Optional) Object to define CORS block in site config."
}

variable "default_documents" {
  type        = list(string)
  default     = null
  description = "(Optional) The ordering of default documents to load, if an address isn't specified."
}

variable "ftps_state" {
  type        = string
  default     = "Disabled"
  description = "(Optional) State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to Disabled."
}

variable "http2_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Is HTTP2 Enabled on this App Service? Defaults to true."
}

variable "ip_restriction" {
  type        = map(map(string))
  default     = {}
  description = "(Optional) A Map representing IP restrictions to the App Service."
}

variable "scm_ip_restriction" {
  type        = map(map(string))
  default     = {}
  description = "(Optional) A Map representing IP restrictions to the Kudu Management page (scm) App Service."
}

variable "scm_use_main_ip_restriction" {
  type        = bool
  default     = true
  description = "(Optional) IP security restrictions for Kudu Managment page (scm) to use main IP restrictions. Defaults to true."
}

variable "local_mysql_enabled" {
  type        = bool
  default     = false
  description = "(Optional) This runs a local MySQL instance with your app and shares resources from the App Service plan."
}

variable "docker_container" {
  type        = string
  default     = null
  description = "(Optional) <user/image:tag> to run a docker image."
}

variable "compose_file_path" {
  type        = string
  default     = null
  description = "(Optional) Path to a docker-compose file for App Service to run."
}

variable "kubernetes_file_path" {
  type        = string
  default     = null
  description = "(Optional) Path to kubernetes manifest for App Service to run."
}

variable "linux_fx_version" {
  type        = string
  default     = null
  description = "(Optional) Linux App Framework and version for the App Service. Contrary to the documentation there are more supported options than DOCKER| COMPOSE| and KUBE|. Values also available are DOTNETCORE| NODE| PHP| PYTHON| JAVA| RUBY|."
}

variable "windows_fx_version" {
  type        = string
  default     = null
  description = " (Optional) Windows App Framework and version for the App Service."
}

variable "min_tls_version" {
  type        = string
  default     = "1.2"
  description = "(Optional) The minimum supported TLS version for the app service. Possible values are '1.0', '1.1', and '1.2'."
}

variable "managed_pipeline_mode" {
  type        = string
  default     = "Integrated"
  description = "(Optional) The Managed Pipeline Mode. Possible values are Integrated and Classic."
}

variable "dotnet_framework_version" {
  type        = string
  default     = null
  description = "(Optional) The version of the .NET framework's CLR used in this App Service. See https://en.wikipedia.org/wiki/.NET_Framework_version_history#Overview ."
}

variable "php_version" {
  type        = string
  default     = null
  description = "(Optional) The version of PHP to use in this App Service. Possible values are '5.5', '5.6', '7.0', '7.1', '7.2', '7.3' and '7.4'."
}

variable "python_version" {
  type        = string
  default     = null
  description = "(Optional) The version of Python to use in this App Service. Possible values are '2.7' and '3.4'."
}

variable "java" {
  type = object({
    version           = string
    container         = string
    container_version = string
  })
  default     = null
  description = "(Optional) Java version possible values are 1.7, 1.8 and 11 and their specific versions. Java container possible values are JAVA, JETTY, and TOMCAT."
}

variable "remote_debugging_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Remote Debugging Enabled?"
}

variable "remote_debugging_version" {
  type        = string
  default     = "VS2017"
  description = "(Optional) Which version of Visual Studio should the Remote Debugger be compatible with? Possible values are VS2012, VS2013, VS2015 and VS2017."
}

variable "scm_type" {
  type        = string
  default     = "None"
  description = "(Optional) The type of Source Control enabled for this App Service. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM"
}

variable "use_32_bit_worker_process" {
  type        = bool
  default     = false
  description = "(Optional) When using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true"
}

variable "websockets_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should WebSockets be enabled?"
}

variable "storage_account" {
  type = object({
    # The name of the storage account identifier.
    name = string
    # Possible values are AzureBlob and AzureFiles.
    type = string
    # The name of the storage account.
    account_name = string
    # The name of the file share (container name, for Blob storage).
    share_name = string
    # The access key for the storage account.
    access_key = string
    # (Optional) The path to mount the storage within the site's runtime environment.
    mount_path = string
  })
  default     = null
  description = "(Optional) object that can include storage account block to the configuration."
}

variable "auth_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Authentication enabled?"
}

variable "auth_active_directory" {
  type = object({
    client_id         = string
    client_secret     = string
    allowed_audiences = list(string)
  })
  default     = null
  description = "(Optional) Object defining AD authentication integration. Required: client_id and client_secret."
}

variable "additional_login_params" {
  type        = map(string)
  default     = null
  description = "(Optional) Login parameters to send to the OpenID Connect authorization endpoint when a user logs in. Each parameter must be in the form key=value."
}

variable "allowed_external_redirect_urls" {
  type        = list(string)
  default     = []
  description = "(Optional) External URLs that can be redirected to as part of logging in or logging out of the app."
}

variable "default_provider" {
  type        = string
  default     = "AzureActiveDirectory"
  description = "(Optional) The default provider to use when multiple providers have been set up. Possible values are AzureActiveDirectory, Facebook, Google, MicrosoftAccount and Twitter."
}

variable "auth_facebook" {
  type = object({
    app_id       = string
    app_secret   = string
    oauth_scopes = list(string)
  })
  default     = null
  description = "(Optional) Object defining Facebook authetication integration. Required: app_id and app_secret."
}

variable "auth_google" {
  type = object({
    client_id     = string
    client_secret = string
    oauth_scopes  = list(string)
  })
  default     = null
  description = "(Optional) Object defining Google authetication integration. Required: client_id and client_secret."
}

variable "auth_microsoft" {
  type = object({
    client_id     = string
    client_secret = string
    oauth_scopes  = list(string)
  })
  default     = null
  description = "(Optional) Object defining Microsoft authetication integration. Required: client_id and client_secret."
}

variable "auth_twitter" {
  type = object({
    consumer_key    = string
    consumer_secret = string
  })
  default     = null
  description = "(Optional) Object defining Twitter authetication integration. Required: consumer_key and consumer_secret."
}

variable "issuer" {
  type        = string
  default     = null
  description = "(Optional) Issuer URI. When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/."
}

variable "runtime_version" {
  type        = string
  default     = null
  description = "(Optional) The runtime version of the Authentication/Authorization module."
}

variable "token_refresh_extension_hours" {
  type        = number
  default     = null
  description = "(Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72."
}

variable "token_store_enabled" {
  type        = bool
  default     = false
  description = "(Optional) If enabled the module will durably store platform-specific security tokens that are obtained during login flows. Defaults to false."
}

variable "unauthenticated_client_action" {
  type        = string
  default     = "RedirectToLoginPage"
  description = "(Optional) The action to take when an unauthenticated client attempts to access the app. Possible values are AllowAnonymous and RedirectToLoginPage."
}

variable "backup_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should backup be enabled?"
}

variable "backup_name" {
  type        = string
  default     = "bak"
  description = "(Optional) Specifies the name for this Backup."
}

variable "backup_storage_account_url" {
  type        = string
  default     = null
  description = "The SAS URL to a Storage Container where Backups should be saved."
}

variable "backup_schedule" {
  type = object({
    frequency_interval       = number
    frequency_unit           = string
    keep_at_least_one_backup = bool
    retention_period_in_days = number
    start_time               = string
  })
  default = {
    frequency_interval       = 1
    frequency_unit           = "Day"
    keep_at_least_one_backup = true
    retention_period_in_days = 30
    start_time               = null
  }
  description = "(Optional) Object defining backup schedule, Required if backup_enabled = true."
}

variable "logs_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should Logs be enabled?"
}

variable "app_logs_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should Application logs be enabled? For this to work logs_enabled need to be true."
}

variable "app_logs_azure_blob_storage" {
  type = object({
    # Possible values include Error, Warning, Information, Verbose and Off.
    # NOTE: below field is not available for http_logs
    level = string
    # The number of days to retain logs for.
    retention_in_days = number
    # The URL to the storage container, with a Service SAS token appended.
    sas_url = string
  })
  default     = null
  description = "(Optional) Needs to be set if app_logs_enabled = true."
}

variable "http_logs_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should HTTP logs be enabled? For this to work logs_enabled need to be true."
}

variable "http_logs_file_system" {
  type = object({
    retention_in_days = number
    retention_in_mb   = number
  })
  default     = null
  description = "(Optional) Retention specs if https logs need to be stored on the file system, both values are required."
}

variable "http_logs_azure_blob_storage" {
  type = object({
    # The number of days to retain logs for.
    retention_in_days = number
    # The URL to the storage container, with a Service SAS token appended.
    sas_url = string
  })
  default     = null
  description = "(Optional) Needs to be set if http_logs_enabled == true and file_system storage is not set."
}

variable "source_control" {
  type        = map(string)
  default     = null
  description = "(Optional) A Source Control block for the App Service."
}

variable "cert_name" {
  type        = string
  default     = null
  description = "(Optional) Name of the certificate resource. Defaults to App Service Name with '-cert' suffix."
}

variable "cert_path" {
  type        = string
  default     = null
  description = "(Optional) Path to your certificate pfx, if this is set custom_domain is required."
}

variable "cert_secret" {
  type        = string
  default     = ""
  description = "(Optional) Password to your certificate pfx."
}

variable "key_vault_secret_id" {
  type        = string
  default     = null
  description = "(Optional) Key Vault Secret ID for your App Certificate, ether this or cert_path needs to be specified, if this is set custom_domain is required."
}

variable "custom_domain" {
  type        = string
  default     = null
  description = "(Optional) Custom domain to attach to the App Service."
}

variable "ssl_state" {
  type        = string
  default     = null
  description = "(Optional) The SSL type. Possible values are IpBasedEnabled and SniEnabled, if this is set cert thumbprint needs to be generated by ether providing cert_path or key_vault_secret_id"
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "(Optional) Resource ID of an existing log analytics workspace. Providing ID enables logging."
}
