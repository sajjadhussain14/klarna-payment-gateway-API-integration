<cfcomponent name="Authentication">
 	<!---- GET CONFIGURATION SETTINGS ----->
	<cfscript>
		this.token=''
		this.authCode=''
		app = createObject("component","config");
		this.authCode=ToBase64("#app.userName#:#app.password#")
	</cfscript>
 	
	<!---- START PAYMENT SESSION ----->
	<cffunction name="createPaymentSession" access="remote">
		<cfargument name="orderData" type="any" required="yes">
		<cfscript>
			paymentSessionRecs={}
		</cfscript>
		<cfhttp method="post" url="#app.endpoint.apiUrl#/payments/v1/sessions" result="result">
			<cfhttpparam type="header" name="Authorization" value="Basic #this.authCode#">
			<cfhttpparam type="header" name="content-type" value="application/json">
			<cfhttpparam type="body" value="#arguments.orderData#">
		</cfhttp>
		<cfset paymentSessionRecs= result.filecontent />
		<cfreturn paymentSessionRecs>
	</cffunction>
 	<!---- END PAYMENT SESSION ----->

	<!-----
		<cffunction name="getToken" access="remote">

			<cfhttp method="post" url="#app.endpoint.apiUrl#" result="result">
				<cfhttpparam type="header" name="Authorization" value="Basic VUcxMDA0MzhfNWExODM1ZGJkOWI2OjludE5ZdDZTa1BkRkM5ZEc=" />
				<cfhttpparam type="header" name="content-type" value="application/json">
			</cfhttp>

			<cfset this.token= result.filecontent />

			<cfdump var="#this.token#" />
			<!---<cfset this.token='36bb897a-c657-4398-88f7-27acee38f7c8' />   set static token for now --->
			<cfreturn this.token>
		</cffunction>
	--->
</cfcomponent>