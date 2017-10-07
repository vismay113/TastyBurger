<%@page import="com.tastyBurger.bean.cartBean"%>
<%@page import="java.util.List"%>
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

        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <script src="https://www.paypalobjects.com/api/checkout.js"></script>
        
        <script>
        paypal.Button.render({

            env: 'production', // Or 'sandbox',

            commit: true, // Show a 'Pay Now' button

            payment: function() {
                // Set up the payment here
            },

            onAuthorize: function(data, actions) {
                // Execute the payment here
           }

        }, '#paypal-button');
    </script>
    
    <script>
        function unsuccessful() {
            alert ("Payment Unsuccessful. Please try again letter");
        }
    </script>
    
        <%@ page import="com.tastyBurger.bean.loginBean" %>
        
        <% Object logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% 
            Integer numberOfRows = (Integer)session.getAttribute("numberOfRows");
            Integer total = (Integer)session.getAttribute("total");
        %>
        
        <%
            String checkOut = request.getParameter("checkOut");
            if(checkOut != null && !"".equals(checkOut)) {
                int checkOut1 = Integer.parseInt(checkOut);
                if(checkOut1 == 1) {
                    out.println("<script>alert('Something went wrong. Please try again later.');</script>");
                } 
            }
        %>
        
        <%
            List<cartBean> cart = (List<cartBean>)session.getAttribute("cart");
            if (cart.isEmpty()) {
                response.sendRedirect("shoppingcart.jsp?upValue=2");
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
                <div class="navbar-header ">
                    <a class="navbar-brand" href="index.jsp"> <img class="logo-small" src="/TastyBurger/img/logo.png" alt="logo"></a>


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


                            <li class="dropdown">
                                <a class="dropdown-toggle text-center" data-toggle="dropdown" href="#">Menu
                                    <span class="caret"></span></a>
                                <span class="sr-only">Toggle Dropdown</span>
                                <ul class="dropdown-menu">
                                    <li><a href="/TastyBurger/beefburger.jsp" class="text-center">Beef Burger</a></li>
                                    <li><a href="/TastyBurger/chickenburger.jsp" class="text-center">Chicken Burger</a></li>
                                    <li><a href="/TastyBurger/fishburger.jsp" class="text-center">Fish Burger</a></li>
                                    <li><a href="/TastyBurger/vegetarian.jsp" class="text-center">Vegetarian</a></li>
                                    <li><a href="/TastyBurger/drink.jsp" class="text-center">Drink</a></li>
                                    <li><a href="/TastyBurger/chips.jsp" class="text-center">Chips</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="/TastyBurger/cartServ" class="text-center">Shopping Cart</a></li>
                                </ul>
                            </li>

                        </ul>

                        <ul class="nav navbar-nav navbar-right text-center">
                        <li><a href="/TastyBurger/profileServ" class="text-center">Profile</a></li>
                            <li><a href="/TastyBurger/cartServ" class="text-center"><span class="  glyphicon glyphicon-shopping-cart"></span> Shopping Cart<span class="badge"><%=numberOfRows %></span></a></li>






                            <li class="dropdown">
                                <a href="/TastyBurger/logoutServ" class="dropdown-toggle text-center" >Log Out <span class="glyphicon glyphicon-log-out"></span></a>
                              
                            </li>

                          
                        </ul>



                    </div>
                </header>
            </div>
        </nav>



   <div class="container" style="padding: 2em;">
      
 
 
       
       
       
       <h3> Checkout </h3>
                        <p> In order to purchase the items in your shopping cart, please confirm or update the following information:</p> 
      <div class="container">
              



                <div class="col-md-6">
                  

          
                    <form style="padding-right: 2em;" name="order" method="post" action="orderServ">

                        <div class="form-group">

                            <input type="text" class="form-control" id="contactInputAddress" name="contactInputAddress" placeholder="Address">
                        </div>
                        
                         <div class="form-group">

                             <input type="text" class="form-control" id="contactInputSuburb" name="contactInputSuburb" placeholder="Suburb">
                        </div>

                        <div class="form-group">

                            <input type="text" class="form-control" id="contactInputPostcode" name="contactInputPostcode" placeholder="Post Code">
                        </div>
                        
                        <div>

                            <textarea class="form-control" rows="2" placeholder="Other message (maximum 100 words)" maxlength="100" name="comment_text"></textarea>

                        </div>
                        <br>
                        <div class="text-center" >
                           <button type="submit" class="btn btn-primary btn-md register-btn">Purchase Successful</button><br /><br /><br />
                           <button type="button" onclick="unsuccessful()" class="btn btn-primary btn-md register-btn">Purchase Unsuccessful</button>
                        </div>
                    </form>


                </div>

                <div class="col-md-6" >
                    <p> Delivery within 1 hours (for local area)</p>
                    <p> $3.00 delivery charge is applied to all purchase orders </p>
                    <p> For direct pick-up at the local store, the delivery change is $0.00 </P>
                    
                   <table class="table">
    <thead>
      <tr>
        <th></th>
        <th></th>

      </tr>
    </thead>
    <tbody>
  
      <tr>
        <td>Subtotal</td>
        <td><%= total %></td>
   
      </tr>
      <tr>
        <td>Delivery charge</td>
        <td>$3</td>
      
      </tr>
           <tr>
        <td style="font-weight: bold;">Total</td>
        <td style="font-weight: bold;"><%= (total+3) %></td>
      
      </tr>
    </tbody>
  </table>
                    
                 <div id="paypal-button"></div>
                </div>

            </div>
</div>

   
        

        <footer style="margin-top:-4em;">
            <div class="tastyburger-footer">
                <div class="container">
                    <div class="col-md-12">
                        <p class="text-center"> &copy Copyright CQ University Software Development Project Team 2017</p>
                    </div>
                </div>
            </div>

        </footer>

    </body>
</html>
