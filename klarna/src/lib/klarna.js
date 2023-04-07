// Klarna Integration
// Version : 1.0.2
// author: Sajjad Hussain

// INITIALIZE KLARNA
const initKlarna = (token) => {
  Klarna.Payments.init({
    client_token: token,
  });
};

// DISPLAY KLARNA PAYMENT SCREEN
const displayKlarnaScreen = () => {
  Klarna.Payments.loadPaymentReview(
    {
      container: "#klarna_container",
    },
    function (res) {
      // loadPaymentReview~callback
      // ...
    }
  );

  Klarna.Payments.authorize(
    {
      auto_finalize: false,
    },
    function (res) {
      let authorizationToken = "";
      if (res.approved == true) {
        authorizationToken = res.authorization_token;
        createOrderRequest(authorizationToken);
      } else {
        console.log("Your Payment was Failed " + res);
      }
    }
  );
};

// CREATE NEW ORDER REQUEST
const createOrderRequest = (authorizationToken) => {
  let settings = {
    async: true,
    crossDomain: true,
    url: "src/components/klarna-payment.cfc?method=createOrder",
    method: "POST",
    data: {
      authorizationToken: authorizationToken,
    },
  };
  console.log(settings.url);
  $.ajax(settings).done(function (response) {
    window.location.replace("/klarna/confirm.cfm");
  });
};

// GET AN ORDER BY ORDER ID REQUEST
const getOrderRequest = (orderID) => {
  orderID = orderID.replace(/\s+/g, "");
  let settings = {
    async: true,
    crossDomain: true,
    url: "src/components/klarna-order-management.cfc?method=getOrder",
    method: "POST",
    data: {
      orderID: orderID,
    },
  };

  $.ajax(settings).done(function (order) {
    try {
      order = JSON.parse(order);
    } catch (err) {
      order = {};
    }
    window.scrollTo(0, 0);

    try {
      document.getElementById("loader").classList.remove("d-none");
    } catch (err) {}

    displayOrder(order);

    displayResponseError(order);
  });
};

// DISPLAY ORDER DETAILS
const displayOrder = (order) => {
  if (order.order_id && order.order_id != "") {
    document.getElementById("orderNo").innerHTML = order.order_id;
    document.getElementById("orderSt").innerHTML = order.status;
    document.getElementById("orderAmt").innerHTML = order.order_amount;
    document.getElementById("orderCapAmt").innerHTML = order.captured_amount;
    document.getElementById("orderRemAmt").innerHTML =
      order.remaining_authorized_amount;
    document.getElementById("orderRefAmt").innerHTML = order.refunded_amount;
    document.getElementById("orderPayMethod").innerHTML =
      order.initial_payment_method.type;
    document.getElementById("orderCur").innerHTML = order.purchase_currency;
    document.getElementById("currentOrderID").value = order.order_id;
  } else {
    document.getElementById("orderNo").innerHTML = "";
    document.getElementById("orderSt").innerHTML = "";
    document.getElementById("orderAmt").innerHTML = "";
    document.getElementById("orderCapAmt").innerHTML = "";
    document.getElementById("orderRemAmt").innerHTML = "";
    document.getElementById("orderRefAmt").innerHTML = "";
    document.getElementById("orderPayMethod").innerHTML = "";
    document.getElementById("orderCur").innerHTML = "";
    document.getElementById("currentOrderID").value = "";
  }
  try {
    setTimeout(() => {
      document.getElementById("loader").classList.add("d-none");
    }, 500);
  } catch (err) {}
};

// CREATE CAPTURE ORDER REQUEST
const createCapOrderRequest = () => {
  let cAmount = 0;
  let cDesc = "";
  let orderID = "";

  cAmount = document.getElementById("capAmt").value;
  cDesc = document.getElementById("capDesc").value;
  orderID = document.getElementById("currentOrderID").value;

  if (!cDesc) cDesc = "";

  if (!orderID || orderID.trim() == "" || orderID == null) {
    alert("Please get an Order First and then capture");
    return;
  }
  try {
    cAmount = parseInt(cAmount);
  } catch (err) {}

  if (cAmount > 0) {
    let payLoad = {};

    payLoad = { captured_amount: cAmount, description: cDesc };
    try {
      document.getElementById("loader").classList.remove("d-none");
    } catch (err) {}

    let settings = {
      async: true,
      crossDomain: true,
      url: "src/components/klarna-order-management.cfc?method=createCaptureOrder",
      method: "POST",
      data: {
        payLoad: JSON.stringify(payLoad),
        orderID: orderID,
      },
    };
    $.ajax(settings).done(function (response) {
      console.log(response);
      getOrderRequest(orderID);
      displayResponseError(response);
    });
  } else {
    alert("Please enter a valid Capture Amount");
  }
};

// update Order Status
const updateOrderStatus = (action) => {
  if (action == "acknowledge") {
    acknowledgeOrderRequest();
  } else if (action == "cancel") {
    cancelOrderRequest();
  }
};

// CREATE ACKNOWLEDGE ORDER REQUEST
const acknowledgeOrderRequest = () => {
  orderID = document.getElementById("currentOrderID").value;

  if (!orderID || orderID.trim() == "" || orderID == null) {
    alert("Please get an Order First and then Acknowledge");
    return;
  }
  try {
    document.getElementById("loader").classList.remove("d-none");
  } catch (err) {}

  let KlarnaIdempotencyKey =
    Date.now().toString(36) + Math.random().toString(36).substring(2);

  let settings = {
    async: true,
    crossDomain: true,
    url: "src/components/klarna-order-management.cfc?method=acknowledgeOrder",
    method: "POST",
    data: {
      orderID: orderID,
      KlarnaIdempotencyKey: KlarnaIdempotencyKey,
    },
  };
  $.ajax(settings).done(function (response) {
    console.log(response);
    getOrderRequest(orderID);
    displayResponseError(response);
  });
};

// CANCEL ORDER REQUEST
const cancelOrderRequest = () => {
  orderID = document.getElementById("currentOrderID").value;

  if (!orderID || orderID.trim() == "" || orderID == null) {
    alert("Please get an Order First and then Acknowledge");
    return;
  }
  try {
    document.getElementById("loader").classList.remove("d-none");
  } catch (err) {}

  let KlarnaIdempotencyKey =
    Date.now().toString(36) + Math.random().toString(36).substring(2);

  let settings = {
    async: true,
    crossDomain: true,
    url: "src/components/klarna-order-management.cfc?method=cancelOrder",
    method: "POST",
    data: {
      orderID: orderID,
      KlarnaIdempotencyKey: KlarnaIdempotencyKey,
    },
  };
  $.ajax(settings).done(function (response) {
    console.log(response);
    getOrderRequest(orderID);
    displayResponseError(response);
  });
};

// UPDATE ORDER AMOUNT
const updateOrderAmountRequest = () => {
  let newOAmount = 0;
  let orderID = "";

  newOAmount = document.getElementById("newOAmt").value;
  orderID = document.getElementById("currentOrderID").value;

  if (!orderID || orderID.trim() == "" || orderID == null) {
    alert("Please get an Order First and then Update");
    return;
  }
  try {
    newOAmount = parseInt(newOAmount);
  } catch (err) {}

  if (newOAmount > 0) {
    let payLoad = {};

    payLoad = { order_amount: newOAmount };
    try {
      document.getElementById("loader").classList.remove("d-none");
    } catch (err) {}

    let settings = {
      async: true,
      crossDomain: true,
      url: "src/components/klarna-order-management.cfc?method=updateOrderAmount",
      method: "POST",
      data: {
        payLoad: JSON.stringify(payLoad),
        orderID: orderID,
      },
    };
    $.ajax(settings).done(function (response) {
      console.log(response);
      getOrderRequest(orderID);
      displayResponseError(response);
    });
  } else {
    alert("Please enter a valid New order Amount");
  }
};

// REFUND ORDER
const refundOrderRequest = () => {
  let refAmount = 0;
  let orderID = "";
  refAmount = document.getElementById("refundAmt").value;
  orderID = document.getElementById("currentOrderID").value;

  if (!orderID || orderID.trim() == "" || orderID == null) {
    alert("Please get an Order First and then Refund");
    return;
  }
  try {
    refAmount = parseInt(refAmount);
  } catch (err) {}

  if (refAmount > 0) {
    let payLoad = {};

    payLoad = { refunded_amount: refAmount };
    try {
      document.getElementById("loader").classList.remove("d-none");
    } catch (err) {}

    let KlarnaIdempotencyKey =
      Date.now().toString(36) + Math.random().toString(36).substring(2);

    let settings = {
      async: true,
      crossDomain: true,
      url: "src/components/klarna-order-management.cfc?method=refundOrder",
      method: "POST",
      data: {
        payLoad: JSON.stringify(payLoad),
        orderID: orderID,
        KlarnaIdempotencyKey: KlarnaIdempotencyKey,
      },
    };
    $.ajax(settings)
      .done(function (response) {
        console.log(response);

        try {
          document.getElementById("loader").classList.remove("d-none");

          document.getElementById("loader").classList.add("d-none");
        } catch (err) {}

        getOrderRequest(orderID);
        displayResponseError(response);
      })
      .fail(function (data) {});
  } else {
    alert("Please enter a valid Refund Amount");
  }
};

const displayResponseError = (response) => {
  try {
    response = JSON.parse(response);
  } catch (err) {}
  if (response.error_code && response.error_messages) {
    try {
      document.getElementById("error-msg").classList.remove("d-none");
    } catch (err) {}
    document.getElementById("error-msg").innerHTML = response.error_messages[0];

    setTimeout(() => {
      try {
        document.getElementById("error-msg").classList.add("d-none");
      } catch (err) {}
    }, 5000);
  }
};
