# Azure App Service

*Id: azappserviceplan | Date: 20.04.2021*

![appservice_icon.png](./Azure-App-Service/.images/appservice_icon.png)

The Azure App Service Web App is an Azure component providing a way to run application code in a serverless way. It runs on top of a Windows or Linux based Azure App Service Plan.

The Azure App Service component module delivers the automated provisioning of an Azure Web App component, resulting in a secure deployment of the resource, which can be used to host your web application.

It is comprised of the Terraform code, provisioning the functionality, compliance validation based on the Cloud Security Framework and full documentation for engineers. Preconfigured with default values it allows for both easy starting up as well as customization options, while still ensuring compliance with the good industry security practices. An App Service Plan resource is a prerequisite to being able to deploy an App Service Web App.

### Access Control

The network integration options for App Service Plan are directly related to the chosen service plan. The option to use private endpoints comes with Premium plans and above, leaving the consumption plan with allowing or denying public and private traffic based on IP addresses or Azure subnets.

### Monitoring

App Service Web Apps integrate directly with Application Insights to collect application-level metrics. These metrics can be viewed and obtained via the Azure Portal or [Azure Application Insights APIs](https://dev.applicationinsights.io/documentation/Using-the-API) and can further bet integrated into a comprehensive monitoring solution.

### Availability

The availability of an App Service Web Application is dependent on the App Service Plan. By default, the App service plan provides resiliency in the boundaries of a single region. For availability spanning more than one region, a solution running multiple Apps on multiple App Service plans should be developed.

### Backup

The Web Apps provisioned on a Web App Service are stateless in their nature. While native backup options are available for the modules by Azure, their availability varies based on the App Service Plan pricing tier. Thus, the application code is recommended to be kept in a versioned code repository as part of the software release pipeline. Any stateful information accessed by the Web App is outside the scope of the App Service Plan backup requirements and should be backed up at the level of the persistent storage component level.

### Management Plane access

The management plane can be accessed via the Portal or a corresponding [API](https://docs.microsoft.com/en-us/rest/api/appservice/webapps). The management of the Web App is decoupled from the management of the App Service Plan.

### Data Plane access

The data plane of a Web App is the end result presented to the user - a web application or an API. The application is accessed via HTTPS (or FTPS), encrypted using TLS 1.2. An authentication to access the App can also be integrated by using Azure AD as an identity provider.

## Security Compliance

Using public cloud infrastructure and PaaS components brings new challenges to maintaining security of the IT infrastructure. The Cloud Security Framework (CSF) is a security governance solution that helps organizations fast track their cloud cybersecurity maturity level. It implements policy-based guardrails based on security best practices based on benchmarks and standards:

- Azure Security Centre
- Azure Security Benchmark
- ISO 27001:2013
- NIST SP800 171 R2 and SP800 53 R4
- CIS 1.1.0

The App Service Web App component module includes the settings to fulfill the compliance requirements for the CSF, covering the full set of ISO 27001, CIS 1.1.0, NIST SP800 171 R2 and SP800 53 R4. As with any security related products, the CSF is also constantly being developed as new threats emerge and the component modules are being updated as well.

| Standard | Compliance | Required policies |
|--|--|--|
| ISO 27001:2013 | ![checkbox.png](./Azure-App-Service/.images/checkbox.png) | - | 
| NIST SP800 171 R2 | ![checkbox.png](./Azure-App-Service/.images/checkbox.png) | Remote debugging should be turned off for Web Apps <br/> Web App should only be accessible over HTTPS <br/> Ensure that {{ Used_framework }} should be updated to the latest version for your Web App <br/> Latest TLS version should be used in your Web App |
| NIST SP800 53 R4 | ![checkbox.png](./Azure-App-Service/.images/checkbox.png) | CORS should not allow every resource to access your Web Applications <br/> Web App should only be accessible over HTTPS <br/> |
| CIS 1.1.0 | ![checkbox.png](./Azure-App-Service/.images/checkbox.png) | Ensure that {{ Used_framework }} should be updated to the latest version for your Web app <br/> Ensure that 'HTTP Version' is the latest, if used to run the Web App <brt/> Managed identity should be used in your Web App <br/> Ensure Web App has 'Client Certificates (Incoming client certificates)' set to 'On' <br/> Authentication should be enabled on your Web App |


## Internal documentation references

- [Azure App Service Web App component technical documentation](./Azure-App-Service/Documentation.md)
- [Azure App Service Web App compliance documentation](./Azure-App-Service/Compliance.md)
- [Azure App Service Web App component risk assessment documentation](./Azure-App-Service/Risk-Assessment.md)
