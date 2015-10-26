%dw 1.0
%output application/java
// This DataWeave generates a MySQL Update Query from your metadata for a particular entity

// APIkit Odata Service puts a inbound property that contains the table's name 
%var remoteEntityName = inboundProperties['odata.remoteEntityName']

// APIkit puts a flowVar containing the id
%var id = flowVars['id']

// APIkit Odata Service puts a inbound property that contains the keys of your entity
%var keys = inboundProperties['odata.keyNames']

// Transform your payload (myKey1: myValue1, myKey2: myValue2) into something like myKey1 = 'myValue1', myKey2 = 'myValue2'
%var sqlValues = (payload mapObject ((value, key) -> '$key': "`$key` = '$value'")) joinBy ", "

// APIkit puts a flowVar containing the id
%var orderId = flowVars['OrderID']
%var ShipName = flowVars['ShipName']
---
"UPDATE $remoteEntityName SET $sqlValues WHERE OrderID = '$orderId' and ShipName = '$ShipName'"


