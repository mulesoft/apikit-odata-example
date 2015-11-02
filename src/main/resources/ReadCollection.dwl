%dw 1.0
%output application/java
// This DataWeave generates a MySQL Select Query from your metadata

// APIkit Odata Service puts an inbound property that contains the fields of your entity. It's a list of string (List<String>)
%var entityFields = inboundProperties['odata.fields']

// APIkit Odata Service puts your oData filters into 'http.query.params' inbound property
%var filters = inboundProperties['http.query.params']

// APIkit Odata Service puts an inbound property that contains the keys of your entity
%var keys = inboundProperties['odata.keyNames']

// Generate the fields you need in the query. 
// It checks for a select function in case you need less filters that you're actually exposing. 
// If there is no select present, it just returns your fields defined in your metadata
%var generateSqlFields = (select) -> ( ( ( ( ( ( ( select splitBy "," ) -- ( keys splitBy "," ) ) ++ ( keys splitBy "," ) ) unless select == null otherwise entityFields ) )  ) map "`$`" ) joinBy ", "

// APIkit Odata Service puts a inbound property that contains the table's name 
%var remoteEntityName = inboundProperties['odata.remoteEntityName']

// Transform oDataFilters into MySQL Filters
%var odataFilterToSQLFilter = (odataFilter) -> 
	  
	 odataFilter replace "eq null" with "is null" 
	 replace "ne null" with "is not null" 
	 replace " eq " with " = " 
	 replace " ne " with " != " 
	 replace " gt " with " > " 
	 replace " lt " with " < " 
	 replace " ge " with " >= " 
	 replace " le " with " <= " 
	 replace " and " with " AND " 
	 replace " or " with " OR " 

// This function transforms your orderby oData filters into MySQL Order by format. 
// Transforms something like orderby=myField, ASC into ORDER BY myField, ASC
// If no orderby is present, it just returns an empty string
%var toSQLOrderBy = (orderby) -> (" ORDER BY " ++ (orderby replace "=" with " ")) unless orderby == null otherwise ""

// This function transforms your skip and top oData filters into MySQL LIMIT format. 
%var toSQLSkipAndTop = (top, skip) -> (" LIMIT $top OFFSET $skip" unless top == null otherwise " LIMIT 2147483647 OFFSET $skip" ) unless skip == null otherwise (" LIMIT $top" unless top == null otherwise "")

// Generate the where part of your query.
%var toSQLWhere = (odataFilter) -> (" WHERE " ++ odataFilterToSQLFilter(odataFilter)) unless odataFilter == null otherwise ""
---
"SELECT " ++ generateSqlFields(filters.select) ++ " FROM $remoteEntityName"
 ++ ( 
 	(toSQLWhere(filters.filter)) ++
 	(toSQLOrderBy(filters.orderby)) ++
 	(toSQLSkipAndTop(filters.top, filters.skip))
 ) 
 


