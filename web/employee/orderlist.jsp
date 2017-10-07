<%@page import="com.tastyBurger.bean.orderBean"%>
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
        
        <% Object logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% 
            Integer numberOfRows = (Integer)session.getAttribute("numberOfRows");
            List<orderBean> orders = (List<orderBean>)session.getAttribute("orderByStatus");
        %>
        
        <%
            String addValue = request.getParameter("checkValue");
            if(addValue != null && !"".equals(addValue)) {
                int addValue1 = Integer.parseInt(addValue);
                if(addValue1 == 1) {
                    out.println("<script>alert('Something went wrong. Please try again later.');</script>");
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
                    <a class="navbar-brand" href="/employee/index.jsp"> <img class="logo-small" src="/TastyBurger/img/logo.png" alt="logo"></a>


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


 

<ul class="breadcrumb">
  <li><a href="/TastyBurger/employee/index.jsp">Employee Home</a></li>
  <li><a href="/TastyBurger/orderListServ?linkValue=1">Order List</a></li>
 

</ul>

            <h3> Customer Order List </h3>
            <form name="updateStatus" action="updateStatusServ" method="get">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Status</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Total Amount</th>
                        <th>Delivery Address</th>
                        <th>Delivery Suburb</th>
                        <th>Delivery Postcode</th>
                        <th>Message</th>
                        <th></th>
                        <th></th>


                    </tr>
                </thead>
                <tbody>
                    <% for (orderBean o: orders) { %>
                    <tr>
                        <td>
                            <input type="hidden" name="order_id" value="<%= o.getId() %>" /> 
                            <%= o.getId() %>
        
                        </td>
                        <td>
                            <div class="form-group">
                                <select class="form-control" name="updateStatus" id="sel1" style="width: 9em;">
                                    <option value="cooking"><%= o.getStatus() %></option>
                                    <option value="on delivery">On Delivery</option>

                                </select>
                            </div>                    
                        </td>
                        <td><%= o.getFname() %></td>
                        <td>
                           <%= o.getLname() %>
                        </td>
                        
                        <td>
                            <%= o.getAmount() %>
                        </td>
                        
                        <td>
                           <%= o.getDeliveryAddress() %>
                        </td>
                        
                         <td>
                          <%= o.getDeliverySuburb() %>
                        </td>
                        
                         <td>
                         <%= o.getDeliveryPostcode() %>
                        </td>
                        
                         <td>
                           <% 
                               String message = o.getComment();
                               if (message.equals(null)) {
                                   message = "No Extra Comments";
                               }
                           %>
                           <%= message %>
                        </td>
                        <td>
                                <input type="submit" class="btn btn-primary" role="button" value="Update Status" />
                        </td>
                            <td>
                                <a href="/TastyBurger/orderDetailServ?cus_id=<%= o.getCustomerId() %>&cart_no=<%= o.getCart_no() %>">detail</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            </form>

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