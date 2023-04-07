<cfoutput>	
    <cfinclude template = "./includes/header.cfm">

    <h1 class="text-center">Your Orcer has been placed successfully</h1>
    <cfif isdefined("session.klarnaOrder.COMPLETEDORDER.order_id")>
        <h5 class="text-center p-2"> Klarna Order ID is: #session.klarnaOrder.COMPLETEDORDER.order_id#</h5>
    </cfif>
    <br />
    <p> 
        Display below info in thank you page and clear sessions   
        <strong> session.klarnaOrder and session.orderData</strong> 
    </p>
    <cfdump var = "#session.klarnaOrder#" >

    <cfinclude template = "./includes/footer.cfm">
</cfoutput>
