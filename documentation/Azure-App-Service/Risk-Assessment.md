<!--
This document is not maintained in this wiki.
Please only modify it at the source!
If you make changes here they may be overwritten and lost.
For documentation origin refer to the file metadata.json.
-->

# Azure App Service Plan Component Risk Assessment

[[_TOC_]]

## Version Control

| Revision | Update Date | Created By | Notes | Approval Date | Approved By |
|--|--|--|--|--|--|
|1.0 | 2021-04-11 | Magnus Mårtensson | Initial Assessment | 2021-04-11 | Frank Mogensen

## Information

This document contains the risk assessment for the Azure App Service Plan as it is being delivered through the CCoE.

| Area | Description |
|--|--|
| Application Type | PaaS |
| Application Criticality | High |
| Application Data Sensitivity | High |
| Regulatory Requirements | GDPR,<br/>ISO27001,<br/>CIS 1.1.0,<br/>NIST SP 800-53 R4,<br/>NIST SP 800-171 R2 |

## Risk Assessment

|Vulnerability | Existing Controls | Severity
|--|--|--|
| Authentication | Access for the resource and the apps hosted on it are separated. An RBAC access policy permission model is enabled. <br/> Azure AD authentication is available for the Web App | Medium |
| Access | Access to the secrets can be restricted by selected networks and limited user roles | Medium |
| Security Logging | Diagnostic logs are enabled on each Web App and sent to a storage account | High |
| Data Encryption at rest |Azure Storage encrypts all data in a storage account at rest, where the Web App files are stored. Dependent on Storage Account component. More details in the Storage Account component documentation. | High |
| Data Encryption in Motion | TLS 1.2 is always enforced on an App Service Web App level | High |
| Network protection | Application whitelisting and filtering is available for each Web App | None |
| Disaster Recovery| Deployments of App Service Plan are region-bound. Multi-region availability of function and web apps is part of a larger solution | Low |
| Business Continuity | The App Service plan is highly available within a single Azure region, providing the same level of availability to the Web Apps | Low |
| Regulatory Compliance GDPR | Platform Enforcement of Asset Creation in EU Regions (defaults to West Europe (NL)) | High |
| Regulatory Compliance ISO27001:2013 | All Policies for ISO Compliance are applied (as a subset of the CSP) | High |
| Regulatory Compliance CIS 1.1.0 | All Policies for CIS v1.1 Compliance are applied (as a subset of the CSP) | High |
| Regulatory Compliance NIST SP 800-53 R4 | All Policies for NIST SP 800-53 R4 are applied (as a subset of the CSP) | High |
| Regulatory Compliance NIST SP 800-171 R2 | All Policies for NIST SP 800-171 R2 are applied (as a subset of the CSP) | High |
