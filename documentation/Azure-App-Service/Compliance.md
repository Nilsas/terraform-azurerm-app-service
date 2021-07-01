<!--
This document is not maintained in this wiki.
Please only modify it at the source!
If you make changes here they may be overwritten and lost.
For documentation origin refer to the file metadata.json.
-->

# Azure App Service Web App

The Compliance of Web App is enforced by multiple Azure Policies for both Security concerns and for Operational concerns.

[[_TOC_]]

Microsoft specify a list of [Azure Policy definitions](https://docs.microsoft.com/en-us/security/benchmark/azure/baselines/app-service-security-baseline) that are specific to Azure App Service Web Apps, based on different benchmarks. This component implements all of these security policies as defined in Cloudeon's Cloud Security Framework:


- {{ Used_framework }} should be updated to the latest version for your Web App
- Ensure that ' {{ Used_framework }} version' is the latest, if used as a part of the Web App
- Web App should only be accessible over HTTPS
- Latest TLS version should be used in your Web App
- Managed identity should be used in your Web App
- Ensure that 'HTTP Version' is the latest, if used to run the Web App
- Web Apps should have 'Client Certificates (Incoming client certificates)' enabled
- Remote debugging should be turned off for Web Apps
- CORS should not allow every resource to access your Web Applications
- Authentication should be enabled on your Web App


The security risks, that are being addressed by these policies are detailed in depth in the risk assessment section.
When provisioning the resource with the provided definition and set of parameters, the provisioned resource is always compliant with these security policies. Items provisioned in a Azure Web Apps have separate policies, which mitigate the security risks associated with them.

## Cloud Security Framework (CSF) Policy

The policies that govern security compliance for Azure Web Apps.

---

### {{ Used_framework }} should be updated to the latest version for your Web App

|||
|--|--|
| Name | {{ Used_framework }} should be updated to the latest version for your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | ------------ |

Azure Web Apps currently supports three versions of the runtime host: 3.x, 2.x, and 1.x. All three versions are supported for production scenarios. This policy checks the runtime version of Web App. Defaults to version 3.x (~3).

---

### Ensure that ' {{ Used_framework }} version' is the latest, if used as a part of the Web App

|||
|--|--|
| Name | Ensure that ' {{ Used_framework }} version' is the latest, if used as a part of the Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | --------- |

Periodically, newer versions are released for Java, Python, PHP either due to security flaws or to include additional functionality. Using the latest Java, Python, PHP version for API apps is recommended to take advantage of security fixes, if any, and/or new functionalities of the latest version. 
Currently, this policy only applies to Linux web apps.

---

### Web App should only be accessible over HTTPS

|||
|--|--|
| Name | Web App should only be accessible over HTTPS |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

HTTPS should only be used to access the Web Application as it uses the SSL/TLS protocol to provide a fully encrypted communication channel between the client and the Web App. This policy checks for usage of HTTPS on Web App.

---------

### Latest TLS version should be used in your Web App

|||
|--|--|
| Name | Latest TLS version should be used in your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

By default, clients can connect to Web App endpoints by using either HTTP or HTTPS. You should redirect HTTP to HTTPs because HTTPS uses the SSL/TLS protocol to provide a secure connection, which is both encrypted and authenticated. This policy checks for usage of HTTPS on Web App.

---------

### Managed identity should be used in your Web App

|||
|--|--|
| Name | Managed identity should be used in your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Access |

A managed identity from Azure Active Directory (Azure AD) allows your app to easily access other Azure AD-protected resources such as Azure Key Vault. The identity is managed by the Azure platform and does not require you to provision or rotate any secrets. This policy checks for usage of managed identity on a Web App.

---

### Ensure that 'HTTP Version' is the latest, if used to run the Web App

|||
|--|--|
| Name | Ensure that 'HTTP Version' is the latest, if used to run the Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

HTTP/2 is a rework of how HTTP semantics flow over TCP connections, and HTTP/2 support is present in Windows 10 and Windows Server 2016. HTTP/2 is a major upgrade after nearly two decades of HTTP/1.1 use and reduces the impact of latency and connection load on web servers.HTTP/2 is a rework of how HTTP semantics flow over TCP connections, and HTTP/2 support is present in Windows 10 and Windows Server 2016. HTTP/2 is a major upgrade after nearly two decades of HTTP/1.1 use and reduces the impact of latency and connection load on web servers. This policy checks for presence of HTTP/2 setting enabled on a Web App.

---

### Web Apps should have 'Client Certificates (Incoming client certificates)' enabled

|||
|--|--|
| Name | Web Apps should have 'Client Certificates (Incoming client certificates)' enabled |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

It is possible to restrict access to your Azure App Service app by enabling different types of authentication for it. One way to do it is to request a client certificate when the client request is over TLS/SSL and validate the certificate. This mechanism is called TLS mutual authentication or client certificate authentication. This policy checks for client certificates setting on Web App.

---

### Remote debugging should be turned off for Web Apps

|||
|--|--|
| Name | Remote debugging should be turned off for Web Apps |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

It is required to make sure that remote debugging is disabled, except when you are actively debugging your web applications. This policy checks if remote debugging is disabled on Web App.

---

### CORS should not allow every resource to access your Web Applications

|||
|--|--|
| Name | CORS should not allow every resource to access your Web Applications |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

Azure Web Apps support cross-origin resource sharing (CORS). The CORS allowed origins list applies at the Web App level. With CORS enabled, responses include the Access-Control-Allow-Origin header. This policy checks CORS configuration to restrict access to Web App.

---

### Authentication should be enabled on your Web App

|||
|--|--|
| Name | Authentication should be enabled on your Web App |
| Version| `1.0.0` |
| Type | `BuiltIn` |
| Risk area | - Data Security |

While application keys can provide some mitigation for unwanted access, the only way to truly secure your Web App endpoints is by implementing positive authentication of clients accessing your Web Apps. It is possible then make authorization decisions based on identity. The App Service platform lets you use Azure Active Directory (AAD) and several third-party identity providers to authenticate clients. This policy checks for authentication setup on Web App.

---
