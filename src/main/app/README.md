
# Anypoint Template: APIkit OData Extension

+ [License Agreement](#licenseagreement)
+ [Use Case](#usecase)
+ [Model Definition](#model)
+ [Model Scaffolding](#scaffolding)

# License Agreement <a name="licenseagreement"/>
Note that using this template is subject to the conditions of this [License Agreement](AnypointTemplateLicense.pdf).
Please review the terms of the license before downloading and using this template. In short, you are allowed to use the template for free with Mule ESB Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case <a name="usecase"/>

This template is designed to serve as a starting point to create an OData API or a Custom DataGateway using APIKIT OData Extension.
Note that all the required dependencies have been already included, and within your API directory you will find a `model.json` file, with an example a data model ready to be scaffolded.

# Model Definition <a name="model"/>

The model described in your `model.json` file must follow this structure:

### Model

```javascript
{
	"entities": [ ... ]
}
```

First, define a single `entities` property, which will consist of an array of `entity`'s. Each entity must have the following structure:

### Entity

```javascript
{
	"entity": {
		"name": "Employees",
		"remoteName": "Employees",
		"properties": [ ... ]
	}
}
```

-	`name`: The name that the entity will be exposed with, i.e. the that the consumers of this OData API will use to query this entity.

-	`remoteName`: The name of the entity in the original/remote datasource, i.e. the name of a table in a database.

-	`properties`: An array containing the definition of each field of this entity, each of them will be defined in the following way:

### Field

```javascript
{
	"field": {
		"type": "Edm.Int32",
		"name": "id",
		"nullable": false,
		"key": true,
		"description": "This is the employee ID",
		"sample": "1"
	}
}
```

-	`type`: The data-type of this field. This is **mandatory for all fields**. The possible types are the following:

	- `Edm.Binary`: The binary data type is used to represent fixed or variable length binary data.

	- `Edm.DateTime`: The DateTime type represents date and time with values ranging from 12:00:00 midnight, January 1, 1753 A.D. through 11:59:59 P.M, December 31, 9999 A.D..

	- `Edm.Time`: The Time type represents the time of day with values ranging from 0:00:00.x to 23:59:59.y, where x and y depend upon the `precision`.

	- `Edm.DateTimeOffset`: The DateTimeOffset type represents date and time as an Offset in minutes from GMT, with values ranging from 12:00:00 midnight, January 1, 1753 A.D. through 11:59:59 P.M, December 9999 A.D.

	- `Edm.Decimal`: The Decimal type represents numeric values with fixed precision and scale. The required precision
	and scale can be specified using optional `precision` and `scale` properties. This type can describe a
	numeric value ranging from negative 10^255 + 1 to positive 10^255 -1.

	- `Edm.String`: The String type represents fixed or variable length character data. When this type is used it is **mandatory** to include as well the `maxLength` and `fixedLength` properties.

	- `Edm.Boolean`: The Boolean data type is used to represent the mathematical concept of binary valued logic. There are no applicable facets for this type.

	- `Edm.Byte`: The Byte type represents an unsigned 8-bit integer value.

	- `Edm.Double`: The Double type represents a floating point number with 15 digits precision that can represent values with approximate range of ± 2.23e -308 through ± 1.79e +308.

	- `Edm.Single`: The Single type represents a floating point number with 7 digits precision that can represent values
	with approximate range of ± 1.18e -38 through ± 3.40e +38

	- `Edm.Guid`: This Guid type, as specified in [RFC4122], represents a 16-byte (128-bit) unique identifier value.

	- `Edm.Int16`: The Int16 type represents a signed 16-bit integer value.

	- `Edm.Int32`: The Int32 type represents a signed 32-bit integer value.

	- `Edm.Int64`: The Int64 type represents a signed 64-bit integer value.

	- `Edm.SByte`: The SByte type represents a signed 8-bit integer value.

	- `Edm.Binary`: The binary data type is used to represent fixed or variable length binary data.

-	`name`: The name of the field. This is **mandatory** for **all types**.

-	`nullable`: Whether this field is nullable or not. This is **mandatory** for **all types**.

-	`key`: Whether this field is a key or not. This is **mandatory** for **all types**.

-	`description`: A description of the field. This is optional for all types.

-	`sample`: A sample value of data in this field. This is optional for all types.

-	`defaultValue`: A default value for this field. This is optional for all types.

-	`precision`: When this property is used in an **Edm.DateTime**, an **Edm.Time** or an **Edm.DateTimeOffset** this indicates the degree of granularity in fractions of a second, based on the number of decimal places supported. For example, a precision of 3 means the granularity supported is milliseconds. When this is used in an **Edm.Decimal**, this specifies the maximum number of decimal digits that an instance of can have, both to the left and to the right of the decimal point. Possible values for are 1, 2, or 3. This is optional.

-	`scale`: This is a positive integer that specifies the maximum number of decimal digits to the right of the decimal point that an instance of this type can have. The Scale value can range from 0 through the specified `precision` value. The default Scale is 0. This is optional for **Edm.Decimal** types.

-	`maxLength`: This is **mandatory** for **Edm.String** types. It specifies the maximum length that the instance can have. It can range from 0 to (2^31)-1.

-	`fixedLength`: This is **mandatory** for **Edm.String** types. The value must be a boolean that indicates whether the store requires a string to be fixed length or not.

-	`collation`: This is a string value that specifies the collating sequence (or sorting sequence) to be used for performing comparison and ordering operations over string values. This is *optional* for **Edm.String** types.

-	`unicode`: This is a boolean value. This value, when set to true, dictates the string type that an
	instance will store. By default, UNICODE characters are used, otherwise standard ASCII encoding is
	used. The default value for this property is true. This is *optional* for **Edm.String** types.

# Model Scaffolding <a name="scaffold"/>

Once your model is already defined in the `model.json` inside `src/main/api`, right click on it and select `APIkit > Generate Flows`

This will generate an `api.raml` in the same directory as your `model.json`, and it will scaffold all your OData API endpoints as flows in an `api.xml` file. From this point you can start implementing all the endpoints in that file.
