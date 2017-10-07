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

        <link rel="stylesheet" href="/TastyBurger/css/style.css">

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="/TastyBurger/js/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="/TastyBurger/js/bootstrap.min.js"></script>

        <script src="/TastyBurger/js/main.js"></script> <!-- customised JavaScript -->
        
        <%  
            String resultFlagString = request.getParameter("resultFlag");
            if(resultFlagString != null && !"".equals(resultFlagString)) {
                    int resultFlag = Integer.parseInt(resultFlagString);
                    if(resultFlag == 1) {
                            out.println("<script>alert('First name cannot be empty and must contains only letters.');</script>");
                    } else if(resultFlag == 2) {
                            out.println("<script>alert('Last name cannot be empty and must contains only letters.');</script>");
                    } else if(resultFlag == 3) {
                            out.println("<script>alert('Address cannot be empty.');</script>");
                    } else if(resultFlag == 4) {
                            out.println("<script>alert('Suburb cannot be empty and must contains only letters.');</script>");
                    } else if(resultFlag == 5) {
                            out.println("<script>alert('First name cannot be empty and must contains 4 digit numbers.');</script>");
                    } else if(resultFlag == 6) {
                            out.println("<script>alert('Phone number cannot be empty and must contains only numbers.');</script>");
                    } else if(resultFlag == 7) {
                            out.println("<script>alert('Email cannot be empty.');</script>");
                    } else if(resultFlag == 8) {
                            out.println("<script>alert('Password cannot be empty.');</script>");
                    } else if(resultFlag == 9) {
                            out.println("<script>alert('Confrim Password cannot be empty.');</script>");
                    } else if(resultFlag == 10) {
                            out.println("<script>alert('Password and Confirm Password doesnot match.');</script>");
                    } else if(resultFlag == 11) {
                            out.println("<script>alert('Email is already exists.');</script>");
                    } 
            }
        %>
        
        <%  
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
        %>

    </head>
    <body>
        
        

        <nav class="navbar navbar-inverse">

            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="/TastyBurger/index.jsp"> <img class="logo-small" src="/TastyBurger/img/logo.png" alt="logo"></a>



                </div>


            </div>
        </nav>


        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title text-center">Customer Registration</h3>
            </div>
            <div class="panel-body">


                <form name="regForm" method="post" action="regServ">

                    <div class="form-group">
                        <label for="inputFirstName">First Name</label>
                        <input type="text" class="form-control" id="inputFirstName" name="inputFirstName" placeholder="First Name">
                    </div>

                    <div class="form-group">
                        <label for="inputLastName">Last Name</label>
                        <input type="text" class="form-control" id="inputLastName" name="inputLastName" placeholder="Last Name">
                    </div>

                    <div class="form-group">
                        <label for="inputAddress">Address</label>
                        <input type="text" class="form-control" id="inputAddress" name="inputAddress" placeholder="Street Address">
                    </div>

                    <div class="form-group">
                        <label for="inputSuburb">Suburb</label>
                        <input type="text" class="form-control" id="inputSuburb" name="inputSuburb" placeholder="Suburb name">
                    </div>

                    <div class="form-group">
                        <label for="inputPostcode">Postcode</label>
                        <input type="text" class="form-control" id="inputPostcode" name="inputPostcode" placeholder="Postcode">
                    </div>


                    <div class="form-group">
                        <label for="inputPhone">Phone</label>
                        <input type="tel" class="form-control" id="inputPhone" name="inputPhone" placeholder="Phone number">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" class="form-control" id="exampleInputEmail1" name="exampleInputEmail1" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="password" class="form-control" id="exampleInputPassword1" name="exampleInputPassword1" placeholder="Password">
                    </div>
                    
                    <div class="form-group">
                        <label for="exampleInputPassword1">Confirm Password</label>
                        <input type="password" class="form-control" id="exampleInputConfirmPassword1" name="exampleInputConfirmPassword1" placeholder="Password">
                    </div>

                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-default">Submit</button>
                    </div>
                </form>

            </div>
        </div>




        <div class="tastyburger-footer">
            <div class="container">
                <div class="col-md-12">
                    <p class="text-center"> &copy Copyright CQ University Software Development Project Team 2017</p>
                </div>
            </div>
        </div>



    </body>
</html>