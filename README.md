
# Anypoint Template: APIkit OData Extension

+ [License Agreement](#licenseagreement)
+ [Use Case](#usecase)
+ [Supported Runtimes](#runtimes)
+ [Model Definition](#model)

# License Agreement <a name="licenseagreement"/>
Note that using this example is subject to the conditions of this [License Agreement](AnypointTemplateLicense.pdf).
Please review the terms of the license before downloading and using this template. In short, you are allowed to use the template for free with Mule ESB Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case <a name="usecase"/>

This example is based on [this template](https://github.com/mulesoft/apikit-odata-template) and is designed to show how to create an OData API or a Custom DataGateway using APIKIT OData Extension.

# Supported Runtimes <a name="runtimes"/>

This example runs on Mule +3.8.1.

# Model Definition <a name="model"/>

In this example we are using the following [OData RAML Type model](/src/main/api/odata.raml).

The model must be defined as a `RAML Library`, where each `DataType` represents an `EntityModel`, like:

### Model

```raml
#%RAML 1.0 Library
uses:
  odata: !include libraries/odata.raml

types:
  Employee:
    properties:
      id:
        type: integer
        (odata.key)
      name:
        type: string
```

You must annotate at least one of the properties on each `Entity` by using the annotation `(odata.key)`.

The following annotations are optional for each property:

- `(odata.nullable)`: bool
- `(odata.precision)`: int
- `(odata.scale)`: int

There's an optional `(odata.remote)` annotation for the `Entity`'s, that allow you to provide the name of the `Entity` in the remote data source.

# Known Issues <a name="knownissues"/>

1. **MySQL Driver is missing Error**

 If your example project does not find MySQL Driver, you need to update your Maven dependencies:
  1. Mavenize your project (unless you have already imported it as a Maven-based Mule Project from pom.xml)
  2. Right click on your project -> Maven Support in Studio -> Update Project Dependencies.
