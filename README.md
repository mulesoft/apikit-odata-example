
# Anypoint Template: APIkit OData Extension

+ [License Agreement](#licenseagreement)
+ [Use Case](#usecase)
+ [Model Definition](#model)
+ [Datasource](#datasource)
+ [Run the example](#run)

# License Agreement <a name="licenseagreement"/>
Note that using this example is subject to the conditions of this [License Agreement](AnypointTemplateLicense.pdf).
Please review the terms of the license before downloading and using this template. In short, you are allowed to use the template for free with Mule ESB Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case <a name="usecase"/>

This example is based on [this template](https://github.com/mulesoft/apikit-odata-template) and is designed to show how to create an OData API or a Custom DataGateway using APIKIT OData Extension.

# Model Definition <a name="model"/>

In this example we are using the following [JSON model](/src/main/api/model.json):


```javascript
{
  "entities": [
    {
      "entity": {
        "name": "orders",
        "remoteName": "Orders",
        "properties": [
          {
            "field": {
              "name": "OrderID",
              "type": "Edm.Int32",
              "nullable": false,
              "key": true,
              "description": "This is the order ID",
              "sample": "1"
            }
          },
          {
            "field": {
              "name": "ShipName",
              "type": "Edm.String",
              "nullable": false,
              "key": true,
              "sample": "John Doe",
              "maxLength": 40,
			  "fixedLength": false
            }
          },
          {
            "field": {
              "name": "ShipAddress",
              "type": "Edm.String",
              "nullable": false,
              "key": false,
              "sample": "Av Corrientes 300",
              "maxLength": 60,
			  "fixedLength": false
            }
          },
          {
            "field": {
              "name": "OrderDate",
              "type": "Edm.DateTime",
              "nullable": true,
              "key": false,
              "sample": "Av Corrientes 300"
            }
          },
          {
            "field": {
              "name": "Freight",
              "type": "Edm.Decimal",
              "nullable": true,
              "key": false
            }
          },
          {
            "field": {
              "name": "Price",
              "type": "Edm.Double",
              "nullable": true,
              "key": false
            }
          },
          {
            "field": {
              "name": "Priority",
              "type": "Edm.Int16",
              "nullable": true,
              "key": false
            }
          }
        ]
      }
    },
    {
      "entity": {
        "name": "customers",
        "remoteName": "Customers",
        "properties": [
          {
            "field": {
              "name": "CustomerID",
              "type": "Edm.String",
              "nullable": false,
              "key": true,
              "description": "This is the Customer ID",
              "sample": "1",
              "maxLength": 5,
              "fixedLength": false
            }
          },
          {
            "field": {
              "name": "CompanyName",
              "type": "Edm.String",
              "nullable": true,
              "key": false,
              "sample": "John Doe",
              "maxLength": 40,
			  "fixedLength": false
            }
          },
          {
            "field": {
              "name": "ContactName",
              "type": "Edm.String",
              "nullable": true,
              "key": false,
              "maxLength": 30,
			  "fixedLength": false
            }
          },
          {
            "field": {
              "name": "ContactTitle",
              "type": "Edm.String",
              "nullable": true,
              "key": false,
			  "fixedLength": false,
			  "maxLength":30
            }
          }
        ]
      }
    }
  ]
}
```
# Datasource <a name="datasource"/>

For this example we used a simple MySQL database. In the root of the project you will find a [SQL script](example.sql) that contains all the data you need to run this Data Gateway.
We suggest using MySQL Workbench 6.3 or later. Replace the properties in "mule-app.properties" to point to the correct database. 

# Run the example <a name="run"/>

In this example you do not need to run the scaffolder since the RAML and the flows are already generated, so just import the project into Studio and run your application. Then when you hit this endpoint 
```javascript
http://localhost:8081/api/odata.svc/$metadata
```
The response will be: 
```javascript
<?xml version='1.0' encoding='utf-8'?>
<edmx:Edmx Version="1.0" xmlns:edmx="http://schemas.microsoft.com/ado/2007/06/edmx">
    <edmx:DataServices m:DataServiceVersion="2.0" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata">
        <Schema Namespace="odata2.namespace" xmlns="http://schemas.microsoft.com/ado/2008/09/edm">
            <EntityType Name="customers">
                <Key>
                    <PropertyRef Name="CustomerID"/>
                </Key>
                <Property Name="CompanyName" Type="Edm.String" Nullable="true" MaxLength="40" FixedLength="false"/>
                <Property Name="ContactName" Type="Edm.String" Nullable="true" MaxLength="30" FixedLength="false"/>
                <Property Name="ContactTitle" Type="Edm.String" Nullable="true" MaxLength="30" FixedLength="false"/>
                <Property Name="CustomerID" Type="Edm.String" Nullable="false" MaxLength="5" FixedLength="false"/>
            </EntityType>
            <EntityType Name="orders">
                <Key>
                    <PropertyRef Name="OrderID"/>
                    <PropertyRef Name="ShipName"/>
                </Key>
                <Property Name="Freight" Type="Edm.Decimal" Nullable="true"/>
                <Property Name="OrderDate" Type="Edm.DateTime" Nullable="true"/>
                <Property Name="OrderID" Type="Edm.Int32" Nullable="false"/>
                <Property Name="Price" Type="Edm.Double" Nullable="true"/>
                <Property Name="Priority" Type="Edm.Int16" Nullable="true"/>
                <Property Name="ShipAddress" Type="Edm.String" Nullable="false" MaxLength="60" FixedLength="false"/>
                <Property Name="ShipName" Type="Edm.String" Nullable="false" MaxLength="40" FixedLength="false"/>
            </EntityType>
            <EntityContainer Name="ODataEntityContainer" m:IsDefaultEntityContainer="true">
                <EntitySet Name="customers" EntityType="odata2.namespace.customers"/>
                <EntitySet Name="orders" EntityType="odata2.namespace.orders"/>
            </EntityContainer>
        </Schema>
    </edmx:DataServices>
</edmx:Edmx>
```