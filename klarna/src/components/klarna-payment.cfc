<cfcomponent name="payment">
	<cfscript>
		app = createObject("component","config");
		this.authCode=ToBase64("#app.userName#:#app.password#")
	</cfscript>

	<!------------------------START CREATE ORDER BY ORDER ID-------------------------->
	<cffunction name="createOrder" access="remote" returnFormat="plain">
	  <cfargument name="authorizationToken" type="any" required="false" />

		<cfhttp method="post" url="#app.endpoint.apiUrl#/payments/v1/authorizations/#arguments.authorizationToken#/order" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="content-type" value="application/json">
			<cfhttpparam type="body" value="#serializeJSON(session.orderData)#">
		</cfhttp>

		<cfset newOrder=result.filecontent />
		<cfset session.klarnaOrder.completedOrder=deserializeJSON(newOrder) />
		<cfreturn #serializeJSON(result.filecontent)#>
	</cffunction>
<!------------------------END CREATE ORDER BY ORDER ID-------------------------->
</cfcomponent>