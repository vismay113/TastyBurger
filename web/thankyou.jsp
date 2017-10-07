
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <link rel="icon" href="/TastyBurger/img/hamburger.ico">
        <title>Tasty Burger</title>

        <!-- Bootstrap -->
        <link href="/TastyBurger/css/bootstrap.min.css" rel="stylesheet">

        <!-- Optional theme -->
        <link href="/TastyBurger/css/bootstrap-theme.min.css" rel="stylesheet">

        <!-- Font-awesome -->
        <link rel="stylesheet" href="/TastyBurger/font-awesome/css/font-awesome.min.css">

        <link rel="stylesheet" type="text/css" href="/TastyBurger/css/bootstrap-social.css">

        <link rel="stylesheet" type="text/css" href="/TastyBurger/css/style.css">

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="/TastyBurger/js/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="/TastyBurger/js/bootstrap.min.js"></script>

        <script src="/TastyBurger/js/main.js"></script> <!-- customised JavaScript -->
        
        <%  
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
        %>

    </head>
    <body>

        <nav class="navbar navbar-inverse">

            <div class="container">
                <div class="navbar-header ">
                    <a class="navbar-brand" href="/TastyBurger/index.jsp"> <img class="logo-small" src="/TastyBurger/img/logo.png" alt="logo"></a>


                    <button type="button" 
                            data-toggle="collapse" class="navbar-toggle collapsed" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <header>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                        <ul class="nav navbar-nav navbar-left text-center"> 

                            <li><a href="/TastyBurger/index.jsp" class="text-center">Home</a></li>
                            <li><a href="/TastyBurger/aboutus.jsp" class="text-center">About Us</a></li>
                            <li><a href="/TastyBurger/contactus.jsp" class="text-center">Contact Us</a></li>



                        </ul>

                        <ul class="nav navbar-nav navbar-right text-center ">






                            <li>

                                <a href="/TastyBurger/register.jsp"><button type="button" class="btn btn-success btn-md register-btn">Register</button></a>
                            </li>

                        </ul>



                    </div>
                </header>
            </div>

        </nav>

        <div class="text-center">
            <h3> Thank you for registering</h3>

            <h4> Confirmation Code has been sent to your registered email </h4>

            <h4> Click the button below to go to Home Page </h4>

            <br>
            <div class="form-group text-center">
                <a href="/TastyBurger/index.jsp"> <button type="button" class="btn btn-default">Home</button></a>
            </div>

        </div>





        <footer>
            <div class="tastyburger-footer">
                <div class="container">
                    <div class="col-md-12">

                        <p class="text-center"> &copy Copyright CQ University Software Development Project Team 2017   </p>
                    </div>

                </div>

            </div>

        </footer>

    </body>
</html>
