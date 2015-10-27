%dw 1.0
%output application/java
// This DataWeave generates a MySQL Delete Query from your metadata

// APIkit Odata Service puts an inbound property that contains the table's name 
%var remoteEntityName = inboundProperties['odata.remoteEntityName']

// APIkit Odata Service puts an inbound property that contains the keys of your entity
%var keys = inboundProperties['odata.keyNames']

// APIkit puts a flowVar containing the id
%var orderId = flowVars['OrderID']
%var ShipName = flowVars['ShipName']
---
"DELETE FROM $remoteEntityName WHERE OrderID = '$orderId' and ShipName = '$ShipName'" 
 


