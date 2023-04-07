<cfcomponent name="config">
	<cfscript>
		//APP Settings
		this.username = application.userName;
		this.password = application.password;
		apiBaseUrlProduction=''
		apiBaseUrldev=''
		region='North America'

		if(region=='Europe')
		{
			apiBaseUrlProduction='https://api.klarna.com' 
			apiBaseUrldev='https://api.playground.klarna.com'
		}
		else if(region=='Oceania')
		{
			apiBaseUrlProduction='https://api-oc.klarna.com'
			apiBaseUrldev='https://api-oc.playground.klarna.com'
		}
		else
		{
			apiBaseUrlProduction='https://api-na.klarna.com'
			apiBaseUrldev='https://api-na.playground.klarna.com'
		}

		// SET ENVIRONMENT 
        environment='development'
		this.endpoint = {};
		// set endpint URLS
        this.endpoint.apiUrl = environment=='development' ?  apiBaseUrldev :  apiBaseUrlProduction
		this.endpoint.confirmUrl = #application.baseUrl#&"/confirm.cfm";
        this.endpoint.returnUrl = #application.baseUrl#&"/retun.cfm";
		this.endpoint.notificationUrl = #application.baseUrl#&"/notify.cfm"; 
		this.endpoint.pushUrl = #application.baseUrl#; 
        this.endpoint.cancelUrl = #application.baseUrl#&"/cancel.cfm"; 
	</cfscript>
</cfcomponent>