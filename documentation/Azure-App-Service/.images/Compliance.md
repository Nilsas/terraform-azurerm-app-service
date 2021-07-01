<!--
This document is not maintained in this wiki.
Please only modify it at the source!
If you make changes here they may be overwritten and lost.
For documentation origin refer to the file metadata.json.
-->

# Azure App Service Web App

The Compliance of Function App is enforced by multiple Azure Policies for both Security concerns and for Operational concerns.

[[_TOC_]]

Microsoft specifies a list of [Azure Policy definitions](https://docs.microsoft.com/en-us/security/benchmark/azure/baselines/app-service-security-baseline) that are specific to Azure Web Apps, based on different benchmarks. This component implements all of these secuirty policies as defined in Cloudeon's Cloud Security Framework:

- Managed identity should be used in your Web App
- FTPS should be required in your Web App
- Ensure that 'HTTP Version' is the latest, if used to run the Web app
- Latest TLS version should be used in your Web App
- Ensure that {{ used framework }} version is the latest, if used as a part of the Web app
- Authentication should be enabled on your web app



The security risks, that are being addressed by these policies are detailed in depth in the risk assessment section.
When provisioning the resource with the provided definition and set of parameters, the provisioned resource is always compliant with these security policies. Items provisioned in a Azure App Service Web Applications have separate policies, which mitigate the security risks associated with them.

## Cloud Security Framework (CSF) Policy

The policies that govern security compliance for Azure App Service Web Apps.

---

### Managed identity should be used in your Web App

|||
|--|--|
| Name | Managed identity should be used in your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Access |

A managed identity from Azure Active Directory (Azure AD) allows your app to easily access other Azure AD-protected resources such as Azure Key Vault. The identity is managed by the Azure platform and does not require you to provision or rotate any secrets. This policy checks for usage of managed identity on a Web App.

---

### FTPS should be required in your Web App

|||
|--|--|
| Name | FTPS should be required in your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data protection |

By default, each Web app has an FTP endpoint enabled. The FTP endpoint is accessed using deployment credentials.
FTP isn't recommended for deploying your function code as it allows for the data to be transmitted in plain text. This policy checks for usage of FTPS on function app.

---

### Ensure that 'HTTP Version' is the latest, if used to run the Web App

|||
|--|--|
| Name | Ensure that 'HTTP Version' is the latest, if used to run the Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

HTTP/2 is a rework of how HTTP semantics flow over TCP connections, and HTTP/2 support is present in Windows 10 and Windows Server 2016. HTTP/2 is a major upgrade after nearly two decades of HTTP/1.1 use and reduces the impact of latency and connection load on web servers. This policy checks for presence of HTTP/2 setting enabled on a Web App.

---

### Latest TLS version should be used in your Web App

|||
|--|--|
| Name | Latest TLS version should be used in your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

By default, clients can connect to function endpoints by using both HTTP or HTTPS. You should redirect HTTP to HTTPs because HTTPS uses the SSL/TLS protocol to provide a secure connection, which is both encrypted and authenticated. This policy checks for usage of HTTPS on a Web App.

---

### Ensure that {{ used framework }} version is the latest, if used as a part of the Web App

|||
|--|--|
| Name | Ensure that {{ used framework }} version is the latest, if used as a part of the Web app |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | ------------ |

Periodically, newer versions are released for Java, Python, PHP either due to security flaws or to include additional functionality. Using the latest Java, Python, PHP version for API apps is recommended in order to take advantage of security fixes, if any, and/or new functionalities of the latest version. 
Currently, this policy only applies to Linux Web Apps.

---

### Authentication should be enabled on your Web App

|||
|--|--|
| Name | Authentication should be enabled on your Function app |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

The recommended way to truly secure your Web App endpoints is implementing positive authentication of clients accessing your functions. It is possible then make authorization decisions based on identity. The App Service platform lets you use Azure Active Directory (AAD) and several third-party identity providers to authenticate clients. This policy checks for authentication setup on Web App.

---
