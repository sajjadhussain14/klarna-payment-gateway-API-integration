<cfinclude template = "./includes/header.cfm">

<!----- Start Klarna Mandatory Placeholder ---->
	<div id="klarna-payments-container"></div>
<!----- end Klarna Mandatory Placeholder ---->

<cfscript>
	auth = createObject("component","src.components.authenticate");
	app = createObject("component","src.components.config");
	orderData={}

	orderData={
		"purchase_country":"US",
		"purchase_currency":"USD",
		"locale":"en-US",
			"auto_capture"=false,
		"billing_address":{
			"given_name":"Test",
			"family_name":"Person-us",
			"email":"customer@email.us",
			"street_address":"Amsterdam Ave",
			"postal_code":"10024",
			"city":"New York",
			"region":"NY",
			"phone":"3106683312",
			"country":"US"
		},
		"shipping_address":{
			"given_name":"Test",
			"family_name":"Person-us",
			"email":"customer@email.us",
			"street_address":"Amsterdam Ave",
			"postal_code":"10024",
			"city":"New York	",
			"region":"NY",
			"phone":"3106683312",
			"country":"US"
		},
		"order_amount":24000,
		"order_tax_amount":0,
		"order_lines":[
			{
				"type":"physical",
				"name":"Adidas Copa Mundial FG",
				"quantity":2,
				"unit_price":12000,
				"tax_rate":0,
				"total_amount":24000,
				"total_discount_amount":0,
				"total_tax_amount":0,
				"product_url":"https://www.thesoccercorner.com/cproduct/127/adidascopamundialfg",
				"image_url":"https://www.thesoccercorner.com/prodimages/2-default-s.jpg"
			}
		],
		"merchant_urls": {
			"confirmation": "https://www.celerant.com/",
			"notification": "https://www.celerant.com/" // optional
		},

		"customer": {
			"date_of_birth": "10-07-1970"
		}
	}

	session.klarnaOrder={orderData:{},completedOrder:{}}
	session.orderData=orderData
	session.klarnaOrder.orderData=orderData
</cfscript>

<cfoutput>
<cfif IsDefined("orderData.order_lines") && ArrayLen(orderData.order_lines) gt 0>
	<cfset	paymentSessionRecord=auth.createPaymentSession(serializeJSON(orderData)) />
	<cfset	paymentSessionRecord=deserializeJSON(paymentSessionRecord) />
	<script>
	//********* INITIAL KLARNA ******//
		$(function () {
			initKlarna("#paymentSessionRecord.client_token#")
		});
	</script>
</cfif>

	<div id="klarna_container"></div>
        <div class="row mt-2 vh-100 content-holder">
            <div class="col-lg-8 col-md-8 col-sm-12">
                <div class="row bg-secondary text-light p-2">
                    <div class="col-lg-2 col-md-2 col-sm-2 ">
                        Iamge
                    </div>
                    <div class="col-lg-4 col-md-2 col-sm-2">
                        Description
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        Price
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        QTY
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        Total
                    </div>
                </div>
                <hr />
				<cfif IsDefined("orderData.order_lines") && ArrayLen(orderData.order_lines) gt 0>
					<cfloop from="1" to="#arraylen(orderData.order_lines)#" index="x">
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2">
								<img src="https://source.unsplash.com/70x70/?shoes">
							</div>
							<div class="col-lg-4 col-md-2 col-sm-2">
								#orderData.order_lines[x].name#
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2">
								#orderData.order_lines[x].unit_price#
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2">
								#orderData.order_lines[x].quantity#
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2">
								#orderData.order_lines[x].total_amount#
							</div>
						</div>
						<hr />
					</cfloop>
				</cfif>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12 boder">
                <h2>Order Summary</h2>
                <div class="row">
                    <div class="col-6"> Total Price</div>
                    <div class="col-6">$#orderData.order_amount#</div>
                    <hr />
                    <div class="col-6">Discount</div>
                    <div class="col-6">$0</div>
                    <hr />
                    <div class="col-6">Tax</div>
                    <div class="col-6">#orderData.order_tax_amount#</div>
                    <hr />
                    <div class="col-6">Subtotal</div>
                    <div class="col-6">$#orderData.order_amount#</div>
					<cfset test='' />
                    <button class="btn btn-primary mt-2" onclick="displayKlarnaScreen()">Checkout with Klarna</button>
            </div>
        </div>
    </div>
</cfoutput>
<cfinclude template = "./includes/footer.cfm">