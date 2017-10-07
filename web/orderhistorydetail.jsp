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
        
        <%@ page import="com.tastyBurger.bean.loginBean" %>
        <%@ page import="com.tastyBurger.bean.cartBean" %>
        
        <% Object logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% 
            Integer numberOfRows = (Integer)session.getAttribute("numberOfRows");
            List<List<cartBean>> orders = (List<List<cartBean>>)session.getAttribute("pastOrders");
            List<Integer> amounts = (List<Integer>)session.getAttribute("amounts");
            
            if (orders.isEmpty()) {
                out.println("<script>alert('You have no past orders to show.');</script>");
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
                            <li><a href="/TastyBurger/cartServ" class="text-center"><span class="  glyphicon glyphicon-shopping-cart"></span> Shopping Cart<span class="badge"><%= numberOfRows %></span></a></li>


                            <li class="dropdown">
                                <a href="/TastyBurger/logoutServ" class="dropdown-toggle text-center" >Log Out <span class="glyphicon glyphicon-log-out"></span></a>

                            </li>


                        </ul>



                    </div>
                </header>
            </div>
        </nav>



        <div class="container" style="padding: 2em;">



            <h3> Order Details </h3>

            <div style="text-align: right">
                <a href="/TastyBurger/index.jsp"><h5 > Continue Shopping </h5></a>


            </div>
            <% for (int i = 0; i < orders.size(); i++) { %>
            <h4> Order Status: <span>Paid & Delivered. </span></h4>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Item name</th>
                        <th>quantity</th>
                        <th>price</th>





                    </tr>
                </thead>
                <tbody>
                    
                    <% for (cartBean c: orders.get(i)) { %>
                    <tr>
                        <td>

                            <%= c.getName() %>

                        </td>

                        <td>

                            <%= c.getQuantity() %>

                        </td>

                        <td>

                            <%= c.getPrice() * c.getQuantity() %>

                        </td>
                    </tr>
                    <% } %>
                    
                    <tr style="font-weight: bold;">
                        <td>



                        </td>

                        <td>

                            Total

                        </td>

                        <td>

                            <%= amounts.get(i) %>

                        </td>
                    </tr>
                

                </tbody>
            </table>
            <% } %>
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

