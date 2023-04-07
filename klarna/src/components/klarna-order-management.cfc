<cfcomponent name="order Management">
	<cfscript>
		app = createObject("component","config");
		this.authCode=ToBase64("#app.userName#:#app.password#")
	</cfscript>

	<!------------------------START GET ORDER BY ORDER ID-------------------------->
	<cffunction name="getOrder" access="remote" returnFormat="plain">
		<cfargument name="orderID" type="any" required="false" />
		
		<cfhttp method="get" url="#app.endpoint.apiUrl#/ordermanagement/v1/orders/#arguments.orderID#" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="content-type" value="application/json">
		</cfhttp>

		<cfreturn #result.filecontent#>
	</cffunction>
	<!------------------------END GET ORDER BY ORDER ID-------------------------->


	<!------------------------START CAPTURE ORDER BY ORDER ID-------------------------->
	<cffunction name="createCaptureOrder" access="remote" returnFormat="plain">
		<cfargument name="payLoad" type="any" required="false" />
		<cfargument name="orderID" type="any" required="false" />

		<cfhttp method="post" url="#app.endpoint.apiUrl#/ordermanagement/v1/orders/#arguments.orderID#/captures" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="content-type" value="application/json">
			<cfhttpparam type="body" value="#arguments.payLoad#">
		</cfhttp>

		<cfreturn #result.filecontent#>
	</cffunction>
	<!------------------------END CAPTURE ORDER BY ORDER ID-------------------------->


	<!------------------------START ACKNOWLEDGE ORDER BY ORDER ID-------------------------->
	<cffunction name="acknowledgeOrder" access="remote" returnFormat="plain">
		<cfargument name="orderID" type="any" required="false" />
		<cfargument name="KlarnaIdempotencyKey" type="any" required="false" />

		<cfhttp method="post" url="#app.endpoint.apiUrl#/ordermanagement/v1/orders/#arguments.orderID#/authorization" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="Klarna-Idempotency-Key" value="#arguments.KlarnaIdempotencyKey#">
			<cfhttpparam type="header" name="content-type" value="application/json">
		</cfhttp>

		<cfreturn #result.filecontent#>
	</cffunction>
	<!------------------------END ACKNOWLEDGE ORDER BY ORDER ID-------------------------->


	<!------------------------START CANCEL ORDER BY ORDER ID-------------------------->
	<cffunction name="cancelOrder" access="remote" returnFormat="plain">
		<cfargument name="orderID" type="any" required="false" />
		<cfargument name="KlarnaIdempotencyKey" type="any" required="false" />

		<cfhttp method="post" url="#app.endpoint.apiUrl#/ordermanagement/v1/orders/#arguments.orderID#/cancel" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="Klarna-Idempotency-Key" value="#arguments.KlarnaIdempotencyKey#">
			<cfhttpparam type="header" name="content-type" value="application/json">
		</cfhttp>

		<cfreturn #result.filecontent#>
	</cffunction>
	<!------------------------END CANCEL ORDER BY ORDER ID-------------------------->


	<!------------------------START UPDATE ORDER AMOUNT BY ORDER ID-------------------------->
	<cffunction name="updateOrderAmount" access="remote" returnFormat="plain">
		<cfargument name="payLoad" type="any" required="false" />
		<cfargument name="orderID" type="any" required="false" />

		<cfhttp method="patch" url="#app.endpoint.apiUrl#/ordermanagement/v1/orders/#arguments.orderID#/authorization" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="content-type" value="application/json">
			<cfhttpparam type="body" value="#arguments.payLoad#">
		</cfhttp>

		<cfreturn #result.filecontent#>
	</cffunction>
	<!------------------------END UPDATE ORDER AMOUNT BY ORDER ID-------------------------->


	<!------------------------START REFUND ORDER BY ORDER ID-------------------------->
	<cffunction name="refundOrder" access="remote" returnFormat="plain">
		<cfargument name="payLoad" type="any" required="false" />
		<cfargument name="orderID" type="any" required="false" />
		<cfargument name="KlarnaIdempotencyKey" type="any" required="false" />

		<cfhttp method="post" url="#app.endpoint.apiUrl#/ordermanagement/v1/orders/#arguments.orderID#/refunds" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="content-type" value="application/json">
			<cfhttpparam type="header" name="Klarna-Idempotency-Key" value="#arguments.KlarnaIdempotencyKey#">
			<cfhttpparam type="body" value="#arguments.payLoad#">
		</cfhttp>

		<cfreturn #result.filecontent#>
	</cffunction>
	<!------------------------END REFUND ORDER BY ORDER ID-------------------------->
</cfcomponent>