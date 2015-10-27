%dw 1.0
%output application/java

// APIkit Odata Service puts an inbound property that contains the table's name 
%var remoteEntityName = inboundProperties['odata.remoteEntityName']

// APIkit Odata Service puts an inbound property that contains the fields of your entity. It's a list of string (List<String>)
%var entityFields = inboundProperties['odata.fields']

%var originalPayload = flowVars['originalPayload']

// This entity doesn't have an auto-generated PK so PK's value is in original payload.
%var id = originalPayload.CustomerID
---
"SELECT " ++ (entityFields joinBy ", ") ++ " FROM $remoteEntityName where CustomerID = '$id'"
