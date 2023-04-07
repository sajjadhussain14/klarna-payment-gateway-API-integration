    <cfoutput>	
<cfinclude template = "./includes/header.cfm">

    <div class="container-fluid ">
		<div class="loader d-none" id="loader"></div>
        <h2 class="text-center ">Order Management</h2>
        <hr />
        <div class="row">
            <div class="col-2 offset-4">Order No.</div>
            <div class="col-6 "><input type="text"  oninput="getOrderRequest(this.value)"/></div>
            <input type='hidden' id='currentOrderID' />
        </div>
        <hr />
        <br />
        <table class="table">
            <thead>
                <tr>
                    <th scope="col" >Order Number</th>
                    <th scope="col" >Status</th>
                    <th scope="col" >Order Amount</th>
                    <th scope="col" >Captured Amount</th>
                    <th scope="col" >Remaining Amount</th>
                    <th scope="col" >Refunded Amount</th>
                    <th scope="col" >Payment Method</th>
                    <th scope="col" >Currency</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td id="orderNo"></td>
                    <td id="orderSt"></td>
                    <td id="orderAmt"></td>
                    <td id="orderCapAmt"></td>
                    <td id="orderRemAmt"></td>
                    <td id="orderRefAmt"></td>
                    <td id="orderPayMethod"></td>
                    <td id="orderCur"></td>

                </tr>
            </tbody>
        </table>
        <p class=" text-center text-danger d-none" id="error-msg">  </p>
        <div class="row">
            <div class="col-8 border-end">
                <h5 class=" p-2">Capture Order </h5>
                <p>We can capture only orders which have status either <strong> Authorized</strong> or 
                <strong>partially Captured</strong>. The amount should be greater than <strong>0</strong>
                and <strong>less or equal</strong> to <strong>remaining Amount</strong>. 
                Can not capture orders having Status of <strong>Captrued</strong>, <strong>Cancelled</strong> and <strong>Expired</strong></p>
                <div class="row m-2">
                    <div class="col-4">Amount: </div>
                    <div class="col-8"><input type="text" id='capAmt'></div>
                </div>
                <div class="row m-2 ">
                    <div class="col-4">Description </div>
                    <div class="col-8">
                        <textarea id="capDesc" name="capDesc" rows="4" cols="50">
                        </textarea>
                    </div>
                </div>
                <div class="row m-2 ">
                    <div class="col-12 text-center">
                        <button type="button" class="btn btn-secondary" onclick="createCapOrderRequest()">Submit</button>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <h5 class="p-2">Order Status </h5>
                <div class="row">
                    <p> Change the order of status from here. </p>
                    <div class="col-4">Order Status: </div>
                    <div class="col-8">
                        <select class="form-select" name="order-status" id="order-status" onchange="updateOrderStatus(this.value)">
                            <option value="" selected>Please Select An Option</option>
                            <option value="acknowledge">Acknowledged</option>
                            <option value="cancel">Canceled</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <hr />
            <div class="row">
                <div class="col-8 border-end">
                    <h5 class=" p-2">Update Order </h5>
                    <p>
                        We can update order amount and order Lines. Mostly Klarna can reject in increase in order amount. 
                        For updation, the order must not be fully captured, canceled, or expired. 
                        <span class="text-info">For now I am just updating order amount. Once can later update orderlines as well by posting 
                        order lines data as well.</span>
                    </p>
                    <div class="row m-2">
                        <small class="col-12">Note: Sometimes the increase order amount <strong>(New order Amount > order amount) </strong> might be rejected. In that case, it is recommanded to place a new order.  </small>
                        <div class="col-4 mt-2">New Order Amount: </div>
                        <div class="col-8 mt-2">
                            <input type="text" id='newOAmt'>
                        </div>
                    </div>
                    <div class="row m-2 ">
                        <div class="col-12 text-center">
                            <button type="button" class="btn btn-secondary" onclick="updateOrderAmountRequest()">Submit</button>
                        </div>
                    </div>
            </div>
            <div class="col-4">
                <h5 class=" p-2">Refund Order </h5>
                <p>
                    We can refund but the order must be fully captured. 
                </p>
                <div class="row m-2">
                    <div class="col-4 mt-2">Refund Amount: </div>
                    <div class="col-8 mt-2">
                        <input type="text" id='refundAmt'>
                    </div>
                </div>
                <div class="row m-2 ">
                    <div class="col-12 text-center">
                        <button type="button" class="btn btn-secondary" onclick="refundOrderRequest()">Submit</button>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <br />
    </div>
<cfinclude template = "./includes/footer.cfm">
</cfoutput>
