%dw 1.0
%output application/json
// This DataWeave transform whatever you stored in your payload into the format we expect
---
{
	entries: payload
}