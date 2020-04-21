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

variable "identity" {
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
  description = "when using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true"
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