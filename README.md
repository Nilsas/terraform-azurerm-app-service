<!-- BEGIN_TF_DOCS -->

# Azure App Service Web App Component

**Component Id:** `azappservice`
**Version:** `1.0.0`

## Prerequisites

1. Terraform version 14.8
1. AzureRM provider version 2.52
1. Resource group
1. App Service Plan
1. Storage account / Log Analytics / Event hub for diagnostics logs and metrics
1. Service Principal for Authentication Configuration

## Releases

| Version | Release Notes |
| ------- | ------------- |
| 1.0.0 | Initial release, as described above. |

How to call the module is documented in the README.md file for each released version.

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| additional\_login\_params | (Optional) Login parameters to send to the OpenID Connect authorization endpoint when a user logs in. Each parameter must be in the form key=value. | `map(string)` | `{}` |
| allowed\_external\_redirect\_urls | (Optional) External URLs that can be redirected to as part of logging in or logging out of the app. | `list(string)` | `[]` |
| always\_on | (Optional) Should the app be loaded at all times? Defaults to false. | `bool` | `false` |
| app\_command\_line | (Optional) App command line to launch, e.g. '/sbin/myserver -b 0.0.0.0'. | `string` | `""` |
| app\_logs\_azure\_blob\_storage | (Optional) Needs to be set if app\_logs\_enabled = true. | ```object({ # Possible values include Error, Warning, Information, Verbose and Off. # NOTE: below field is not available for http_logs level = string # The number of days to retain logs for. retention_in_days = number # The URL to the storage container, with a Service SAS token appended. sas_url = string })``` | `null` |
| app\_logs\_enabled | (Optional) Should Application logs be enabled? For this to work logs\_enabled need to be true. | `bool` | `false` |
| app\_service\_plan\_id | (Required) The ID of the App Service Plan within which to create this App Service. | `string` | `null` |
| app\_service\_plan\_kind | (Required) The kind used for app service plan. Possible values are: 'Windows' and 'Linux'. Defaults to 'Windows'. | `string` | `null` |
| app\_settings | (Optional) Map of KEY = VALUE pairs to pass to App Service environment, all values will be registered as plain text environment variables. | `map(string)` | `{}` |
| auth\_active\_directory | (Optional) Object defining AD authentication integration. Required: client\_id and client\_secret. | ```object({ client_id = string client_secret = string allowed_audiences = list(string) })``` | `null` |
| auth\_enabled | (Optional) Is Authentication enabled? | `bool` | `true` |
| auth\_facebook | (Optional) Object defining Facebook authetication integration. Required: app\_id and app\_secret. | ```object({ app_id = string app_secret = string oauth_scopes = list(string) })``` | `null` |
| auth\_google | (Optional) Object defining Google authetication integration. Required: client\_id and client\_secret. | ```object({ client_id = string client_secret = string oauth_scopes = list(string) })``` | `null` |
| auth\_microsoft | (Optional) Object defining Microsoft authetication integration. Required: client\_id and client\_secret. | ```object({ client_id = string client_secret = string oauth_scopes = list(string) })``` | `null` |
| backup\_enabled | (Optional) Should backup be enabled? | `bool` | `false` |
| backup\_name | (Optional) Specifies the name for this Backup. | `string` | `"bak"` |
| backup\_schedule | (Optional) Object defining backup schedule, Required if backup\_enabled = true. | ```object({ frequency_interval = number frequency_unit = string keep_at_least_one_backup = bool retention_period_in_days = number start_time = string })``` | ```{ "frequency_interval": 1, "frequency_unit": "Day", "keep_at_least_one_backup": true, "retention_period_in_days": 30, "start_time": null }``` |
| backup\_storage\_account\_url | The SAS URL to a Storage Container where Backups should be saved. | `string` | `null` |
| cert\_name | (Optional) Name of the certificate resource. Defaults to App Service Name with '-cert' suffix. | `string` | `null` |
| cert\_path | (Optional) Path to your certificate pfx, if this is set custom\_domain is required. | `string` | `null` |
| cert\_secret | (Optional) Password to your certificate pfx. | `string` | `""` |
| client\_affinity\_enabled | (Optional) Should the App Service send session affinity cookies, which route client requests in the same session to the same instance? | `bool` | `false` |
| client\_cert\_enabled | (Optional) Does the App Service require client certificates for incoming requests? Defaults to true. | `bool` | `true` |
| compose\_file\_path | (Optional) Path to a docker-compose file for App Service to run. | `string` | `null` |
| connection\_string | (Optional) Possible type values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer. | ```list(object({ name = string type = string value = string }))``` | `[]` |
| cors | (Optional) Object to define CORS block in site config. | ```object({ allowed_origins = list(string) support_credentials = bool })``` | ```{ "allowed_origins": [], "support_credentials": null }``` |
| custom\_domain | (Optional) Custom domain to attach to the App Service. | `string` | `null` |
| default\_documents | (Optional) The ordering of default documents to load, if an address isn't specified. | `list(string)` | `null` |
| default\_provider | (Optional) The default provider to use when multiple providers have been set up. Possible values are AzureActiveDirectory, Facebook, Google, MicrosoftAccount and Twitter. | `string` | `"AzureActiveDirectory"` |
| diagnostic\_settings | (Optional) Contains the diagnostics setting object. [Category, Enabled, Retention Enabled, Retention in days]. | `map(list(list(any)))` | ```{ "log": [ [ "AppServiceConsoleLogs", true, true, 30 ], [ "AppServiceHTTPLogs", true, true, 30 ], [ "AppServiceAuditLogs", true, true, 30 ], [ "AppServiceAppLogs", true, true, 30 ], [ "AppServiceIPSecAuditLogs", true, true, 30 ], [ "AppServicePlatformLogs", true, true, 30 ] ], "metric": [ [ "AllMetrics", true, true, 30 ] ] }``` |
| docker\_container | (Optional) <user/image:tag> to run a docker image. | `string` | `null` |
| dotnet\_framework\_version | (Optional) The version of the .NET framework's CLR used in this App Service. See https://en.wikipedia.org/wiki/.NET_Framework_version_history#Overview . | `string` | `null` |
| enabled | (Optional) Is the App Service Enabled? | `bool` | `true` |
| eventhub\_authorization\_rule\_id | (Optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. | `string` | `null` |
| eventhub\_name | (Optional) Specifies the name of the Event Hub where Diagnostics Data should be sent. | `string` | `null` |
| ftps\_state | (Optional) State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to Disabled. | `string` | `"Disabled"` |
| http2\_enabled | (Optional) Is HTTP2 Enabled on this App Service? Defaults to true. | `bool` | `true` |
| http\_logs\_azure\_blob\_storage | (Optional) Needs to be set if http\_logs\_enabled == true and file\_system storage is not set. | ```object({ # The number of days to retain logs for. retention_in_days = number # The URL to the storage container, with a Service SAS token appended. sas_url = string })``` | `null` |
| http\_logs\_enabled | (Optional) Should HTTP logs be enabled? For this to work logs\_enabled need to be true. | `bool` | `false` |
| http\_logs\_file\_system | (Optional) Retention specs if https logs need to be stored on the file system, both values are required. | ```object({ retention_in_days = number retention_in_mb = number })``` | `null` |
| https\_only | (Optional) Can the App Service only be accessed via HTTPS? | `bool` | `true` |
| identity | (Optional) Toggle for SystemAssigned managed identity. Defaults to true. | `bool` | `true` |
| identity\_ids | (Optional) Specifies a list of user managed identity ids to be assigned. Required if type is UserAssigned. | `list(string)` | `null` |
| identity\_type | (Optional) Specifies the identity type of the App Service. Possible values are SystemAssigned (where Azure will generate a Service Principal for you), UserAssigned where you can specify the Service Principal IDs in the identity\_ids field. | `string` | `"SystemAssigned"` |
| ip\_restriction | (Optional) A Map representing IP restrictions to the App Service. | `map(map(string))` | `{}` |
| issuer | (Optional) Issuer URI. When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/. | `string` | `null` |
| java | (Optional) Java version possible values are 1.7, 1.8 and 11 and their specific versions. Java container possible values are JAVA, JETTY, and TOMCAT. | ```object({ version = string container = string container_version = string })``` | `null` |
| key\_vault\_secret\_id | (Optional) Key Vault Secret ID for your App Certificate, ether this or cert\_path needs to be specified, if this is set custom\_domain is required. | `string` | `null` |
| kubernetes\_file\_path | (Optional) Path to kubernetes manifest for App Service to run. | `string` | `null` |
| linux\_fx\_version | (Optional) Linux App Framework and version for the App Service. Contrary to the documentation there are more supported options than DOCKER\| COMPOSE\| and KUBE\|. Values also available are DOTNETCORE\| NODE\| PHP\| PYTHON\| JAVA\| RUBY\|. | `string` | `null` |
| local\_mysql\_enabled | (Optional) This runs a local MySQL instance with your app and shares resources from the App Service plan. | `bool` | `false` |
| location | (Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | `"westeurope"` |
| log\_analytics\_workspace\_id | (Optional) Resource ID of an existing log analytics workspace. Providing ID enables logging. | `string` | `null` |
| logs\_enabled | (Optional) Should Logs be enabled? | `bool` | `false` |
| managed\_pipeline\_mode | (Optional) The Managed Pipeline Mode. Possible values are Integrated and Classic. | `string` | `"Integrated"` |
| min\_tls\_version | (Optional) The minimum supported TLS version for the app service. Possible values are '1.0', '1.1', and '1.2'. | `string` | `"1.2"` |
| name | (Required) Specifies the name of the App Service. Changing this forces a new resource to be created. | `string` | `null` |
| php\_version | (Optional) The version of PHP to use in this App Service. Possible values are '5.5', '5.6', '7.0', '7.1', '7.2', '7.3' and '7.4'. | `string` | `null` |
| python\_version | (Optional) The version of Python to use in this App Service. Possible values are '2.7' and '3.4'. | `string` | `null` |
| remote\_debugging\_enabled | (Optional) Is Remote Debugging Enabled? | `bool` | `false` |
| remote\_debugging\_version | (Optional) Which version of Visual Studio should the Remote Debugger be compatible with? Possible values are VS2012, VS2013, VS2015 and VS2017. | `string` | `"VS2017"` |
| resource\_group\_name | (Required) The name of the resource group in which to create the App Service. | `string` | `null` |
| runtime\_version | (Optional) The runtime version of the Authentication/Authorization module. | `string` | `null` |
| scm\_ip\_restriction | (Optional) A Map representing IP restrictions to the Kudu Management page (scm) App Service. | `map(map(string))` | `{}` |
| scm\_type | (Optional) The type of Source Control enabled for this App Service. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM | `string` | `"None"` |
| scm\_use\_main\_ip\_restriction | (Optional) IP security restrictions for Kudu Managment page (scm) to use main IP restrictions. Defaults to true. | `bool` | `true` |
| ssl\_state | (Optional) The SSL type. Possible values are IpBasedEnabled and SniEnabled, if this is set cert thumbprint needs to be generated by ether providing cert\_path or key\_vault\_secret\_id | `string` | `null` |
| storage\_account | (Optional) object that can include storage account block to the configuration. | ```object({ # The name of the storage account identifier. name = string # Possible values are AzureBlob and AzureFiles. type = string # The name of the storage account. account_name = string # The name of the file share (container name, for Blob storage). share_name = string # The access key for the storage account. access_key = string # (Optional) The path to mount the storage within the site's runtime environment. mount_path = string })``` | `null` |
| storage\_account\_id | (Optional) With this parameter you can specify a storage account which should be used to send the logs to. Parameter must be a valid Azure Resource ID. | `string` | `null` |
| tags | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` |
| token\_refresh\_extension\_hours | (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72. | `number` | `null` |
| token\_store\_enabled | (Optional) If enabled the module will durably store platform-specific security tokens that are obtained during login flows. Defaults to false. | `bool` | `false` |
| unauthenticated\_client\_action | (Optional) The action to take when an unauthenticated client attempts to access the app. Possible values are AllowAnonymous and RedirectToLoginPage. | `string` | `"RedirectToLoginPage"` |
| use\_32\_bit\_worker\_process | (Optional) When using an App Service Plan in the Free or Shared Tiers use\_32\_bit\_worker\_process must be set to true | `bool` | `false` |
| websockets\_enabled | (Optional) Should WebSockets be enabled? | `bool` | `false` |
| windows\_fx\_version | (Optional) Windows App Framework and version for the App Service. | `string` | `null` |

### Block `diagnostic_settings` supports the following arguments

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `name` | Name of the Diagnostic definition block, `log` and `metric` is currently supported in this module. | `string` | |
| `list_of_rules` | ["category_name",  "diagnostics_enabled(true/false)", "retention_enabled(true/false)", retention_period_days] All 4 elements are required. Even if diagnostics enabled is false. | `list(list(any))` | `` |
| `category_name` | Each resource has a set of allowed Category Names. | `string` | |
| `diagnostics_enabled` | Flag that allows diagnostics to be enabled. | `bool` | `true` |
| `retention_enabled` | Flag that sets whether the retention is enabled for these logs. | `bool` | `true` |
| `retention_period_days` | Number of days to keep the logs. | `number` | `30` |

### Block `auth_active_directory` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `client_id` | (Required) The Client ID of this relying party application. Enables OpenIDConnection authentication with Azure Active Directory. | `string` | `null` |
| `client_secret` | (Required) The Client Secret of this relying party application. If `null` is provided, implicit flow will be used. | `string` | `null` |
| `allowed_audiences` | (Optional) Allowed audience values to consider when validating JWTs issued by Azure Active Directory. | `list(string)` | `null` |

### Block `auth_facebook` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `app_id` | (Required) The App ID of the Facebook app used for login. | `string` | `null` |
| `app_secret` | (Required) The App Secret of the Facebook app used for Facebook Login. | `string` | `null` |
| `oauth_scopes` | (Optional) The OAuth 2.0 scopes that will be requested as part of Facebook Login authentication. | `list(string)` | `null` |

### Block `auth_google` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `client_id` | (Required) The OpenID Connect Client ID for the Google web application. | `string` | `null` |
| `client_secret` | (Required) The client secret associated with the Google web application. | `string` | `null` |
| `oauth_scopes` | (Optional) The OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. | `list(string)` | `null` |

### Block `auth_microsoft` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `client_id` | (Required) The OAuth 2.0 client ID that was created for the app used for authentication. | `string` | `null` |
| `client_secret` | (Required) The OAuth 2.0 client secret that was created for the app used for authentication. | `string` | `null` |
| `oauth_scopes` | (Optional) The OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. | `list(string)` | `null` |

### Block `connection_string` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `name` | (Required) The name of the Connection String. | `string` | `null` |
| `type` | (Required) The type of the Connection String. Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer. | `string` | `null` |
| `value` | (Required) The value for the Connection String. | `string` | `null` |

### Block `ip_restriction` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `name` | (Required) The name of the of IP Restriction Rule. Every rule is in it's own map, `name` is the Key of the map. | `string` | `null` |
| `ip_address` | (Optional) The IP Address used for this IP Restriction in CIDR notation. | `string` | `null` |
| `service_tag` | (Optional) The Service Tag used for this IP Restriction. | `string` | `null` |
| `virtual_network_subnet_id` | (Optional) The Virtual Network Subnet ID used for this IP Restriction. | `string` | null |
| `priority` | (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, priority is set to 65000 if not specified. | `number` | `null` |
| `action` | (Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow. | `string` | "Allow" |
| `x_azure_fdid` | (Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8. | `list(string)` | `null` |
| `x_fd_health_probe` | (Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1". | `string` | `null` |
| `x_forwarded_for` | (Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8 | `list(string)` | `null` |
| `x_forwarded_host` | (Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8. | `list(string)` | `null` |

### Block `scm_ip_restriction` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `name` | (Required) The name of the of SCM IP Restriction Rule. Every rule is in it's own map, `name` is the Key of the map. | `string` | `null` |
| `ip_address` | (Optional) The IP Address used for this IP Restriction in CIDR notation. | `string` | `null` |
| `service_tag` | (Optional) The Service Tag used for this IP Restriction. | `string` | `null` |
| `virtual_network_subnet_id` | (Optional) The Virtual Network Subnet ID used for this IP Restriction. | `string` | null |
| `priority` | (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, priority is set to 65000 if not specified. | `number` | `null` |
| `action` | (Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow. | `string` | "Allow" |
| `x_azure_fdid` | (Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8. | `list(string)` | `null` |
| `x_fd_health_probe` | (Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1". | `string` | `null` |
| `x_forwarded_for` | (Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8 | `list(string)` | `null` |
| `x_forwarded_host` | (Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8. | `list(string)` | `null` |

### Block `storage_account` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `name` | (Required) The name of the storage account identifier. | `string` | `null` |
| `type` | (Required) The type of storage. Possible values are AzureBlob and AzureFiles. | `string` | `null` |
| `account_name` | (Required) The name of the storage account. | `string` | `null` |
| `share_name` | (Required) The name of the file share (container name, for Blob storage). | `string` | `null` |
| `access_key` | (Required) The access key for the storage account. | `string` | `null` |
| `mount_path` | (Optional) The path to mount the storage within the site's runtime environment. If not specified `null` still need to be specified in the field. | `string` | `null` |

### Block `backup_schedule` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `frequency_interval` | (Required) Sets how often the backup should be executed. | `number` | `1` |
| `frequency_unit` | (Optional) Sets the unit of time for how often the backup should be executed. Possible values are Day or Hour. | `string` | "Day" |
| `keep_at_least_one_backup` | (Optional) Should at least one backup always be kept in the Storage Account by the Retention Policy, regardless of how old it is? | `bool` | true |
| `retention_period_in_days` | (Optional) Specifies the number of days after which Backups should be deleted. | `number` | `30` |
| `start_time` | (Optional) Sets when the schedule should start working. | `string` | `null` |

### Block `app_logs_azure_blob_storage` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `level` | (Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs. | `string` | `null` |
| `retention_in_days` | (Required) The number of days to retain logs for. | `number` | `null` |
| `sas_url` | (Required) The URL to the storage container with a shared access signature token appended.  | `string` | `null` |

### Block `http_logs_file_system` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `retention_in_days` | (Required) The number of days to retain logs for. | `number` | `null` |
| `retention_in_mb` | (Required) The maximum size in megabytes that http log files can use before being removed. | `number` | `null` |

### Block `http_logs_azure_blob_storage` support the following

| Name | Description | Type | Default |
| ---- | ---- | ------- | ----------- |
| `retention_in_days` | (Required) The number of days to retain logs for. | `number` | `null` |
| `sas_url` | (Required) The URL to the storage container with a shared access signature token appended.  | `string` | `null` |

## Usage

```ruby
module "app_service" {
  source                = "git@ssh.dev.azure.com:v3/__tenant__/__project_name__/__app_service_module_name__?ref=__app_service_module_branch__"
  resource_group_name   = azurerm_resource_group.main.name
  name                  = local.name
  app_service_plan_id   = azurerm_app_service_plan.main.id
  app_service_plan_kind = azurerm_app_service_plan.main.kind

  # One of [storage_account_id, log_analytics_workspace_id, event_hub_name] has to be supplied
  storage_account_id = module.storage_account.id

  # Container Support
  docker_container = "hello-world:latest"
  # OR
  # compose_file_path = "/path/to/docker-compose.yml"
  # OR
  # kubernetes_file_path = "/path/to/kubernetes.yml"

  # By policy App Service should use authentication
  auth_active_directory = {
    client_id         = var.client_id
    client_secret     = var.client_secret
    allowed_audiences = null
  }

  # IP Restriction Support
  ip_restriction = {
    example_name = {
      ip_address = "78.58.9.80/32"
      priority   = 200
    }
  }

  # Custom Domain Support
  # cert_path     = "certificate.pfx"
  # cert_secret   = data.azurerm_key_vault_secret.example.value
  # custom_domain = "cloudeon.com"
}

```

## Outputs

| Name | Description |
|------|-------------|
| app\_service | Outputs a full App Service Object from this module |
| app\_service\_certificate | Outputs a full App Service Certificate Object from this module |
| app\_service\_custom\_hostname\_binding | Outputs a full App Service Custom Hostname Binding Object from this module |
| app\_servie\_slot | Outputs a full App Service Slot Object from this module |
| diagnostic\_setting | Outputs Diagnostic settings of Redis Cache. |
<!-- END_TF_DOCS -->