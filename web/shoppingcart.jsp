<%-- 
    Document   : shoppingcart
    Created on : 05/09/2017, 9:34:56 PM
    Author     : comuser
--%>

<%@page import="java.util.List"%>
<%@ page import="com.tastyBurger.bean.loginBean" %>
<%@ page import="com.tastyBurger.BO.cartBO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %> 
<c:set var="view" value="/shoppingcart" scope="session"/>

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
        
        <% String logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% Integer numberOfRows = (Integer)session.getAttribute("numberOfRows"); %>
        
        <%
            List<cartBean> cart = (List<cartBean>)session.getAttribute("cart");
            Integer total = (Integer)session.getAttribute("total");
            Integer totalQ = (Integer)session.getAttribute("totalQ");
        %>
        
        <%
            String addValue = request.getParameter("upValue");
            if(addValue != null && !"".equals(addValue)) {
                int addValue1 = Integer.parseInt(addValue);
                if(addValue1 == 1) {
                    out.println("<script>alert('Something went wrong. Please try again later.');</script>");
                } else if(addValue1 == 2) {
                    out.println("<script>alert('No item to create order.');</script>");
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


            <div style="padding-bottom: 2em;">

                <ul class="nav nav-tabs nav-justified" >
                    <li><a href="/TastyBurger/index.jsp" style="color:black; text-decoration: underline;">Continue shopping</a></li>
                    <li><a href="/TastyBurger/checkout.jsp" style="color:black; text-decoration: underline;">Proceed to checkout <span class="glyphicon glyphicon-circle-arrow-right"></span></a></li>

                </ul>
            </div>

             <div class="panel panel-default">
                    <div class="panel-heading text-center">Shopping Cart </div>
                    <div class="panel-body"> 
          
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Item name</th>
                        <th>Price</th>
                        <th>Quantity</th>


                    </tr>
                </thead>
                <tbody>
                    <% for (cartBean c: cart) { %>
                    <tr>
                        <td><%= c.getName() %></td>
                        <td><%= c.getPrice() * c.getQuantity() %></td>
                        <td> 

                            <form class="navbar-form" action="updateQuantityServ" method="post">
                                <div class="form-group">
                                    <input type="hidden" name="itemName" value="<%= c.getName() %>" />
                                    <input type="text" class="form-control" value="<%= c.getQuantity() %>" name="quantity" style="text-align:right;">
                                </div>
                                <button type="submit" name="submit" class="btn btn-default">Update</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    

                    <tr style="font-weight: bold;">
                        <td>Total</td>
                        <td>$<%= total %></td>
                        <td style="padding-left: 12.5em;"><%= totalQ %></td>
                    </tr>

                </tbody>
            </table>
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