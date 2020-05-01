# terraform-azurerm-app-service
Terraform module to deploy App Service with AzureRM provider >= 2.0.0

### Usage example
```hcl
locals {
  prefix = format("tf%s", "myapp")
}

resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = format("%s-rg", local.prefix)
}

module "appservice" {
  source                = "../../"
  resource_group_name   = azurerm_resource_group.rg.name
  tags                  = azurerm_resource_group.rg.tags
  prefix                = local.prefix
  plan_kind             = "linux"
}
```

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_login\_params | Login parameters to send to the OpenID Connect authorization endpoint when a user logs in. Each parameter must be in the form key=value | `map(string)` | `{}` | no |
| allowed\_external\_redirect\_urls | External URLs that can be redirected to as part of logging in or logging out of the app. | `list(string)` | `[]` | no |
| allowed\_ip\_addresses | List of allowed IPs in CIDR notation ex. 10.10.10.10/32 | `list(string)` | `[]` | no |
| allowed\_subnet\_ids | List allowed subnet IDs to access this App Service | `list(string)` | `[]` | no |
| always\_on | Should the app be loaded at all times? | `bool` | `true` | no |
| app\_command\_line | App command line to launch, e.g. /sbin/myserver -b 0.0.0.0 | `string` | `""` | no |
| app\_logs\_azure\_blob\_storage | Needs to be set if app\_logs\_enabled = true | <pre>object({<br>    level             = string<br>    # Possible values include Error, Warning, Information, Verbose and Off.<br>    # NOTE: above field is not available for http_logs<br>    retention_in_days = number<br>    # The number of days to retain logs for.<br>    sas_url           = string<br>    # The URL to the storage container, with a Service SAS token appended.<br>  })</pre> | n/a | yes |
| app\_logs\_enabled | Should Application logs be enabled? For this to work logs\_enabled need to be true | `bool` | `false` | no |
| app\_settings | Map of KEY = VALUE pairs to pass to App Service environment, all values will be registered as plain text environment variables | `map(string)` | `{}` | no |
| auth\_active\_directory | Object defining AD authentication integration. Required: client\_id and client\_secret | <pre>object({<br>    client_id         = string<br>    client_secret     = string<br>    allowed_audiences = list(string)<br>  })</pre> | n/a | yes |
| auth\_enabled | Is Authentication enabled? | `bool` | `false` | no |
| auth\_facebook | Object defining Facebook authetication integration. Required: app\_id and app\_secret | <pre>object({<br>    app_id       = string<br>    app_secret   = string<br>    oauth_scopes = list(string)<br>  })</pre> | n/a | yes |
| auth\_google | Object defining Google authetication integration. Required: client\_id and client\_secret | <pre>object({<br>    client_id     = string<br>    client_secret = string<br>    oauth_scopes  = list(string)<br>  })</pre> | n/a | yes |
| auth\_microsoft | Object defining Microsoft authetication integration. Required: client\_id and client\_secret | <pre>object({<br>    client_id     = string<br>    client_secret = string<br>    oauth_scopes  = list(string)<br>  })</pre> | n/a | yes |
| backup\_enabled | Should abckup be enabled? | `bool` | `false` | no |
| backup\_name | Specifies the name for this Backup. | `string` | `"bak"` | no |
| backup\_schedule | Object defining backup schedule, Required if backup\_enabled = true | <pre>object({<br>    frequency_interval       = number<br>    frequency_unit           = string<br>    keep_at_least_one_backup = bool<br>    retention_period_in_days = number<br>    start_time               = string<br>  })</pre> | <pre>{<br>  "frequency_interval": 1,<br>  "frequency_unit": "Day",<br>  "keep_at_least_one_backup": true,<br>  "retention_period_in_days": 30,<br>  "start_time": null<br>}</pre> | no |
| backup\_storage\_account\_url | The SAS URL to a Storage Container where Backups should be saved. | `string` | `""` | no |
| cert\_path | Path to your certificate pfx, if this is set custom\_domain is required | `string` | n/a | yes |
| cert\_secret | Password to your certificate pfx | `string` | `""` | no |
| client\_affinity\_enabled | Should the App Service send session affinity cookies, which route client requests in the same session to the same instance? | `bool` | `false` | no |
| client\_cert\_enabled | Does the App Service require client certificates for incoming requests? Defaults to false. | `bool` | `false` | no |
| conn\_string | Possible type values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer. | <pre>list(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| cors | Object to define CORS block in site config | <pre>object({<br>    allowed_origins     = list(string)<br>    support_credentials = bool<br>  })</pre> | <pre>{<br>  "allowed_origins": [],<br>  "support_credentials": null<br>}</pre> | no |
| custom\_domain | Custom domain to attach to the App Service | `string` | n/a | yes |
| default\_documents | The ordering of default documents to load, if an address isn't specified. | `list(string)` | n/a | yes |
| default\_provider | The default provider to use when multiple providers have been set up. Possible values are AzureActiveDirectory, Facebook, Google, MicrosoftAccount and Twitter. | `string` | n/a | yes |
| docker\_container | <user/image:tag> to run a docker image; I do not intend to do COMPOSE or KUBE support | `string` | n/a | yes |
| dotnet\_framework\_version | The version of the .net framework's CLR used in this App Service. See https://en.wikipedia.org/wiki/.NET_Framework_version_history#Overview | `string` | n/a | yes |
| enabled | Is the App Service Enabled? | `bool` | `true` | no |
| ftps\_state | State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to Disabled for security concerns | `string` | `"Disabled"` | no |
| http2\_enabled | Is HTTP2 Enabled on this App Service? Defaults to false. | `bool` | `false` | no |
| http\_logs\_azure\_blob\_storage | Needs to be set if http\_logs\_enabled == true and file\_system storage is not set | <pre>object({<br>    retention_in_days = number<br>    # The number of days to retain logs for.<br>    sas_url           = string<br>    # The URL to the storage container, with a Service SAS token appended.<br>  })</pre> | n/a | yes |
| http\_logs\_enabled | Should HTTP logs be enabled? For this to work logs\_enabled need to be true | `bool` | `false` | no |
| http\_logs\_file\_system | Retention specs if https logs need to be stored on the file system, both values are required. | <pre>object({<br>    retention_in_days = number<br>    retention_in_mb   = number<br>  })</pre> | n/a | yes |
| https\_only | Can the App Service only be accessed via HTTPS? | `bool` | `true` | no |
| identity | Toggle for SystemAssigned managed identity. Defaults to false | `bool` | `false` | no |
| issuer | Issuer URI. When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/. | `string` | n/a | yes |
| java | Java version possible values are 1.7, 1.8 and 11 and their specific versions. Java container possible values are JAVA, JETTY, and TOMCAT. | <pre>object({<br>    version           = string<br>    container         = string<br>    container_version = string<br>  })</pre> | n/a | yes |
| key\_vault\_secret\_id | Key Vault Secret ID for your App Certificate, ether this or cert\_path needs to be specified, if this is set custom\_domain is required | `string` | n/a | yes |
| local\_mysql\_enabled | This runs a local MySQL instance with your app and shares resources from the App Service plan. | `bool` | `false` | no |
| location | This variable will point all resource into one Azure location | `string` | `"westeurope"` | no |
| logs\_enabled | Should Logs be enabled? | `bool` | `false` | no |
| managed\_pipeline\_mode | The Managed Pipeline Mode. Possible values are Integrated and Classic. | `string` | `"Integrated"` | no |
| min\_tls\_version | The minimum supported TLS version for the app service. Possible values are 1.0, 1.1, and 1.2 | `string` | `"1.2"` | no |
| php\_version | The version of PHP to use in this App Service. Possible values are 5.5, 5.6, 7.0, 7.1, 7.2, and 7.3 | `string` | n/a | yes |
| plan\_kind | The kind of the App Service Plan to create. Possible values are Windows, Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan). | `string` | `"Windows"` | no |
| prefix | This variable is used to unify all resource naming within this module | `string` | `"my-prefix"` | no |
| python\_version | The version of Python to use in this App Service. Possible values are 2.7 and 3.4 | `string` | n/a | yes |
| remote\_debugging\_enabled | Is Remote Debugging Enabled? | `bool` | `false` | no |
| remote\_debugging\_version | Which version of Visual Studio should the Remote Debugger be compatible with? | `string` | `"VS2017"` | no |
| resource\_group\_name | This will tell us to which resource group we need to deploy the resources of this module | `string` | `"my-resource-group"` | no |
| runtime\_version | The runtime version of the Authentication/Authorization module. | `string` | n/a | yes |
| scm\_type | The type of Source Control enabled for this App Service. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM | `string` | `"None"` | no |
| sku | Plan's Pricing tier and size noted similarly as Azure VM sizes are written. Example: Standard\_S1 | `string` | `"Standard_S1"` | no |
| ssl\_state | The SSL type. Possible values are IpBasedEnabled and SniEnabled,if this is set cert thumbprint needs to be generated by ether providing cert\_path or key\_vault\_secret\_id | `string` | n/a | yes |
| storage\_account | Optional object that can include storage account blovk to the configuration | <pre>object({<br>    name         = string<br>    # The name of the storage account identifier.<br>    type         = string<br>    # Possible values are AzureBlob and AzureFiles.<br>    account_name = string<br>    # The name of the storage account.<br>    share_name   = string<br>    # The name of the file share (container name, for Blob storage).<br>    access_key   = string<br>    # The access key for the storage account.<br>    mount_path   = string<br>    # (Optional) The path to mount the storage within the site's runtime environment.<br>  })</pre> | n/a | yes |
| tags | This variable is used to refference same tags through all resources | `map(string)` | `{}` | no |
| token\_refresh\_extension\_hours | The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72. | `number` | n/a | yes |
| token\_store\_enabled | If enabled the module will durably store platform-specific security tokens that are obtained during login flows. Defaults to false. | `bool` | n/a | yes |
| unauthenticated\_client\_action | The action to take when an unauthenticated client attempts to access the app. Possible values are AllowAnonymous and RedirectToLoginPage. | `string` | n/a | yes |
| use\_32\_bit\_worker\_process | When using an App Service Plan in the Free or Shared Tiers use\_32\_bit\_worker\_process must be set to true | `bool` | `false` | no |
| websockets\_enabled | Should WebSockets be enabled? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_service | n/a |
| app\_service\_certificate | n/a |
| app\_service\_custom\_hostname\_binding | n/a |
| app\_service\_plan | n/a |


