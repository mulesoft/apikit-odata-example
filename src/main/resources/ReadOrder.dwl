%dw 1.0
%output application/java
// This DataWeave generates a MySQL Select Query from your metadata for a particular entity

// APIkit Odata Service puts an inbound property that contains the table's name 
%var remoteEntityName = inboundProperties['odata.remoteEntityName']

// APIkit Odata Service puts an inbound property that contains the fields of your entity. It's a list of string (List<String>)
%var entityFields = inboundProperties['odata.fields']

// APIkit Odata Service puts your oData filters into 'http.query.params' inbound property
%var filters = inboundProperties['http.query.params']

// Generate the fields you need in the query. 
// It checks for a select function in case you need less filters that you're actually exposing. 
// If there is no select present, it just returns your fields defined in your metadata
%var generateSqlFields = (select) -> ( ( ( ( ( ( ( select splitBy "," ) -- ( keys splitBy "," ) ) ++ keys splitBy "," ) unless select == null otherwise entityFields ) )  ) map "`$`" ) joinBy ", "

// APIkit Odata Service puts an inbound property that contains the keys of your entity
%var keys = inboundProperties['odata.keyNames']

// APIkit puts a flowVar containing the id
%var orderId = flowVars['OrderID']
%var ShipName = flowVars['ShipName']
---
"SELECT " ++ generateSqlFields(filters.select) ++ " FROM $remoteEntityName WHERE OrderID = '$orderId' and ShipName = '$ShipName'"
 