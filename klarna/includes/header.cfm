<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Klarna Integration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://www.celerant.com/wp-content/uploads/2019/02/cropped-Celerant_Favicon_512x512-32x32.png" sizes="32x32">

    <!------------- Start do not remove. These are for Klarna------------->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://x.klarnacdn.net/kp/lib/v1/api.js" ></script>
    
    <!------------- end do not remove. These are for Klarna------------->
    <link rel="stylesheet" href="./src/css/klarna.css">
</head>

<body>

    <!------------- add this after body in Klarna test mode ------------->
    <script
    async
    src="https://na-library.playground.klarnaservices.com/lib.js"
    data-client-id="9bf1ad05-1ead-52f0-af23-857f203719a0"
    ></script>
    <!------------- add this after body in Klarna test mode ------------->

    <cfoutput>
        <div class="container-fluid ">
            <header class="row">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="http://127.0.0.1:8500/klarna/">Home</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="##navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                            <div class="navbar-nav">
                                <a class="nav-link" href="/klarna/checkout.cfm">Checkout</a>
                                <a class="nav-link" href="/klarna/order-management.cfm">Order Management</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </header>
    </cfoutput>
