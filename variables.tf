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
  description = "The kind of the App Service Plan to create. Possible values are Windows, Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan)."
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
  type        = list(object({
    name  = string
    type  = string
    value = string
  }))
  default     = []
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

variable "client_affinity_enabled" {
  type        = bool
  default     = false
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
}

variable "client_cert_enabled" {
  type        = bool
  default     = false
  description = "Does the App Service require client certificates for incoming requests? Defaults to false."
}

variable "identity" {
  type        = bool
  default     = false
  description = "Toggle for SystemAssigned managed identity. Defaults to false"
}

variable "always_on" {
  type        = bool
  default     = true
  description = "Should the app be loaded at all times?"
}

variable "app_command_line" {
  type        = string
  default     = ""
  description = "App command line to launch, e.g. /sbin/myserver -b 0.0.0.0"
}

variable "cors" {
  type        = object({
    allowed_origins     = list(string)
    support_credentials = bool
  })
  default     = {
    allowed_origins     = []
    support_credentials = null
  }
  description = "Object to define CORS block in site config"
}

variable "default_documents" {
  type        = list(string)
  default     = null
  description = "The ordering of default documents to load, if an address isn't specified."
}

variable "ftps_state" {
  type        = string
  default     = "Disabled"
  description = "State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to Disabled for security concerns"
}

variable "http2_enabled" {
  type        = bool
  default     = false
  description = "Is HTTP2 Enabled on this App Service? Defaults to false."
}

variable "allowed_ip_addresses" {
  type        = list(string)
  default     = []
  description = "List of allowed IPs in CIDR notation ex. 10.10.10.10/32"
}

variable "allowed_subnet_ids" {
  type        = list(string)
  default     = []
  description = "List allowed subnet IDs to access this App Service"
}

variable "local_mysql_enabled" {
  type        = bool
  default     = false
  description = "This runs a local MySQL instance with your app and shares resources from the App Service plan."
}

variable "docker_container" {
  type        = string
  default     = null
  description = "<user/image:tag> to run a docker image; I do not intend to do COMPOSE or KUBE support"
}

variable "min_tls_version" {
  type        = string
  default     = "1.2"
  description = "The minimum supported TLS version for the app service. Possible values are 1.0, 1.1, and 1.2"
}

variable "managed_pipeline_mode" {
  type        = string
  default     = "Integrated"
  description = "The Managed Pipeline Mode. Possible values are Integrated and Classic. "
}

variable "dotnet_framework_version" {
  type        = string
  default     = null
  description = "The version of the .net framework's CLR used in this App Service. See https://en.wikipedia.org/wiki/.NET_Framework_version_history#Overview"
}

variable "php_version" {
  type        = string
  default     = null
  description = "The version of PHP to use in this App Service. Possible values are 5.5, 5.6, 7.0, 7.1, 7.2, and 7.3"
}

variable "python_version" {
  type        = string
  default     = null
  description = "The version of Python to use in this App Service. Possible values are 2.7 and 3.4"
}

variable "java" {
  type        = object({
    version           = string
    container         = string
    container_version = string
  })
  default     = null
  description = "Java version possible values are 1.7, 1.8 and 11 and their specific versions. Java container possible values are JAVA, JETTY, and TOMCAT."
}

variable "remote_debugging_enabled" {
  type        = bool
  default     = false
  description = "Is Remote Debugging Enabled?"
}

variable "remote_debugging_version" {
  type        = string
  default     = "VS2017"
  description = "Which version of Visual Studio should the Remote Debugger be compatible with?"
}

variable "scm_type" {
  type        = string
  default     = "None"
  description = "The type of Source Control enabled for this App Service. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM"
}

variable "use_32_bit_worker_process" {
  type        = bool
  default     = false
  description = "When using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true"
}

variable "websockets_enabled" {
  type        = bool
  default     = false
  description = "Should WebSockets be enabled?"
}

variable "storage_account" {
  type        = object({
    name         = string
    # The name of the storage account identifier.
    type         = string
    # Possible values are AzureBlob and AzureFiles.
    account_name = string
    # The name of the storage account.
    share_name   = string
    # The name of the file share (container name, for Blob storage).
    access_key   = string
    # The access key for the storage account.
    mount_path   = string
    # (Optional) The path to mount the storage within the site's runtime environment.
  })
  default     = null
  description = "Optional object that can include storage account blovk to the configuration"
}

variable "auth_enabled" {
  type        = bool
  default     = false
  description = "Is Authentication enabled?"
}

variable "auth_active_directory" {
  type        = object({
    client_id         = string
    client_secret     = string
    allowed_audiences = list(string)
  })
  default     = null
  description = "Object defining AD authentication integration. Required: client_id and client_secret"
}

variable "additional_login_params" {
  type        = map(string)
  default     = {}
  description = "Login parameters to send to the OpenID Connect authorization endpoint when a user logs in. Each parameter must be in the form key=value"
}

variable "allowed_external_redirect_urls" {
  type        = list(string)
  default     = []
  description = "External URLs that can be redirected to as part of logging in or logging out of the app."
}

variable "default_provider" {
  type        = string
  default     = null
  description = "The default provider to use when multiple providers have been set up. Possible values are AzureActiveDirectory, Facebook, Google, MicrosoftAccount and Twitter."
}

variable "auth_facebook" {
  type        = object({
    app_id       = string
    app_secret   = string
    oauth_scopes = list(string)
  })
  default     = null
  description = "Object defining Facebook authetication integration. Required: app_id and app_secret"
}

variable "auth_google" {
  type        = object({
    client_id     = string
    client_secret = string
    oauth_scopes  = list(string)
  })
  default     = null
  description = "Object defining Google authetication integration. Required: client_id and client_secret"
}

variable "auth_microsoft" {
  type        = object({
    client_id     = string
    client_secret = string
    oauth_scopes  = list(string)
  })
  default     = null
  description = "Object defining Microsoft authetication integration. Required: client_id and client_secret"
}

variable "issuer" {
  type        = string
  default     = null
  description = "Issuer URI. When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/."
}

variable "runtime_version" {
  type        = string
  default     = null
  description = "The runtime version of the Authentication/Authorization module."
}

variable "token_refresh_extension_hours" {
  type        = number
  default     = null
  description = "The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72."
}

variable "token_store_enabled" {
  type        = bool
  default     = null
  description = "If enabled the module will durably store platform-specific security tokens that are obtained during login flows. Defaults to false."
}

variable "unauthenticated_client_action" {
  type        = string
  default     = null
  description = "The action to take when an unauthenticated client attempts to access the app. Possible values are AllowAnonymous and RedirectToLoginPage."
}

variable "backup_enabled" {
  type        = bool
  default     = false
  description = "Should abckup be enabled?"
}

variable "backup_name" {
  type        = string
  default     = "bak"
  description = "Specifies the name for this Backup."
}

variable "backup_storage_account_url" {
  type        = string
  default     = ""
  description = "The SAS URL to a Storage Container where Backups should be saved."
}

variable "backup_schedule" {
  type        = object({
    frequency_interval       = number
    frequency_unit           = string
    keep_at_least_one_backup = bool
    retention_period_in_days = number
    start_time               = string
  })
  default     = {
    frequency_interval       = 1
    frequency_unit           = "Day"
    keep_at_least_one_backup = true
    retention_period_in_days = 30
    start_time               = null
  }
  description = "Object defining backup schedule, Required if backup_enabled = true"
}

variable "logs_enabled" {
  type        = bool
  default     = false
  description = "Should Logs be enabled?"
}

variable "app_logs_enabled" {
  type        = bool
  default     = false
  description = "Should Application logs be enabled? For this to work logs_enabled need to be true"
}

variable "app_logs_azure_blob_storage" {
  type        = object({
    level             = string
    # Possible values include Error, Warning, Information, Verbose and Off.
    # NOTE: above field is not available for http_logs
    retention_in_days = number
    # The number of days to retain logs for.
    sas_url           = string
    # The URL to the storage container, with a Service SAS token appended.
  })
  default     = null
  description = "Needs to be set if app_logs_enabled = true"
}

variable "http_logs_enabled" {
  type        = bool
  default     = false
  description = "Should HTTP logs be enabled? For this to work logs_enabled need to be true"
}

variable "http_logs_file_system" {
  type        = object({
    retention_in_days = number
    retention_in_mb   = number
  })
  default     = null
  description = "Retention specs if https logs need to be stored on the file system, both values are required."
}

variable "http_logs_azure_blob_storage" {
  type        = object({
    retention_in_days = number
    # The number of days to retain logs for.
    sas_url           = string
    # The URL to the storage container, with a Service SAS token appended.
  })
  default     = null
  description = "Needs to be set if http_logs_enabled == true and file_system storage is not set"
}

variable "cert_path" {
  type        = string
  default     = null
  description = "Path to your certificate pfx, if this is set custom_domain is required"
}

variable "cert_secret" {
  type        = string
  default     = ""
  description = "Password to your certificate pfx"
}

variable "key_vault_secret_id" {
  type        = string
  default     = null
  description = "Key Vault Secret ID for your App Certificate, ether this or cert_path needs to be specified, if this is set custom_domain is required"
}

variable "custom_domain" {
  type        = string
  default     = null
  description = "Custom domain to attach to the App Service"
}

variable "ssl_state" {
  type        = string
  default     = null
  description = "The SSL type. Possible values are IpBasedEnabled and SniEnabled,if this is set cert thumbprint needs to be generated by ether providing cert_path or key_vault_secret_id"
}