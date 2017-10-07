<%@page import="com.tastyBurger.bean.customerBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
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
    
    <%@ page import="com.tastyBurger.bean.loginBean" %>
        
        <% Object logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% Integer numberOfRows = (Integer)session.getAttribute("numberOfRows");%>
        
        
        <% customerBean cus = (customerBean)session.getAttribute("cusInfo"); %>
        
        <%
            String addValue = request.getParameter("proValue");
            if(addValue != null && !"".equals(addValue)) {
                int addValue1 = Integer.parseInt(addValue);
                if(addValue1 == 1) {
                    out.println("<script>alert('Email already exist.');</script>");
                } else if(addValue1 == 2) {
                    out.println("<script>alert('Email cannot be blank.');</script>");
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
                        <c:choose>
                                <c:when test = "${logFlag == 'true'}">
                                    <li><a href="/TastyBurger/cartServ" class="text-center"><span class="  glyphicon glyphicon-shopping-cart"></span> Shopping Cart<span class="badge"><%=numberOfRows %></span></a></li>

                                    

                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle text-center" data-toggle="dropdown">Welcome <%=lbean.getName() %> <span class="caret"></span></a>
                                        <ul class="dropdown-menu dropdown-lr animated slideInRight" role="menu">
                                            <li class="col-lg-14 login-menu">

                                                <form id="ajax-login-form" name="loginForm" action="logoutServ" method="get" role="form" autocomplete="off">

                                                    <div style="padding-bottom: 1em;">
                                                                <a href="/TastyBurger/profileServ"><input type="button" name="profile" id="loggedProfile" tabindex="4" class="form-control btn btn-success" value="Profile"></a>
                                                    </div>

                                                            <div style="padding-bottom: 1em;">
                                                                <a href="/TastyBurger/pastOrderServ"><input type="button" name="pastOrders" id="userPastOrders" tabindex="4" class="form-control btn btn-success" value="Past Orders" /></a>
                                                            </div>

                                                            <div style="padding-bottom: 1em;">
                                                                <input type="submit" name="logout" id="logout" tabindex="4" class="form-control btn btn-success" value="Log Out">
                                                            </div>
                                                    <input type="hidden" class="hide" name="token" id="token" value="a465a2791ae0bae853cf4bf485dbe1b6">

                                                </form>

                                            </li> <!-- -->

                                        </ul>

                                    </li>

                                </c:when>
                                <c:when test="${logFlag == 'firstLogin'}">
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle text-center" data-toggle="dropdown">First Log In <span class="caret"></span></a>
                                        <ul class="dropdown-menu dropdown-lr animated slideInRight" role="menu">
                                            <li class="col-lg-14 login-menu">
                                                <div class="text-center"><h3><b>First Log In</b></h3></div>

                                                <form id="ajax-firstlogin-form" action="codeServ" method="post" role="form" autocomplete="off">

                                                    <%  
                                                        String resultFlagString = request.getParameter("resultFlag");
                                                        if(resultFlagString != null && !"".equals(resultFlagString)) {
                                                                int resultFlag = Integer.parseInt(resultFlagString);
                                                                if(resultFlag == 1) {
                                                                        out.println("<script>alert('Code is not entered.');</script>");
                                                                } else if(resultFlag == 2) {
                                                                        out.println("<script>alert('Code doesnot match');</script>");
                                                                } else if(resultFlag == 3) {
                                                                        out.println("<script>alert('Please try later.');</script>");
                                                                } else if(resultFlag == -3) {
                                                                        out.println("<script>alert('Please Log In First.');</script>");
                                                                }
                                                        }
                                                    %>
                                                    <div class="form-group">
                                                        <label for="inputConfirmCode">Confirmation Code</label>
                                                        <input type="text" name="inputConfirmCode" class="form-control" tabindex="5" id="inputConfirmCode" placeholder="Enter Confirmation Code" value="" autocomplete="off">

                                                    </div>

                                                    <div class="form-group">
                                                        <div class="row">

                                                            <div class="col-xs-6 pull-right">
                                                                <input type="submit" name="first-login-submit" id="first-login-submit" tabindex="6" class="form-control btn btn-success" value="First Log In">
                                                            </div>
                                                        </div>

                                                    </div>


                                                </form>

                                            </li> <!-- -->

                                        </ul>

                                    </li>
                                </c:when>
                                <c:otherwise>

                                    <li class="dropdown">
                                    <a href="#" class="dropdown-toggle text-center" data-toggle="dropdown">Log In <span class="caret"></span></a>
                                    <ul class="dropdown-menu dropdown-lr animated slideInRight" role="menu">
                                        <li class="col-lg-14 login-menu">

                                            <form id="ajax-login-form" name="loginForm" action="loginServ" method="post" role="form" autocomplete="off">

                                                <%  
                                                    String resultFlagString1 = request.getParameter("resultFlag");
                                                    if(resultFlagString1 != null && !"".equals(resultFlagString1)) {
                                                            int resultFlag = Integer.parseInt(resultFlagString1);
                                                            if(resultFlag == 1) {
                                                                    out.println("<script>alert('UserId/Password Blank.');</script>");
                                                            } else if(resultFlag == 2) {
                                                                    out.println("<script>alert('Userid/Password Wrong.');</script>");
                                                            } else if(resultFlag == 3) {
                                                                    out.println("<script>alert('Please try later.');</script>");
                                                            } else if(resultFlag == -3) {
                                                                    out.println("<script>alert('Please Log In First.');</script>");
                                                            }
                                                    }
                                                %>

                                                <div class="form-group">
                                                    <label for="inputEmail">Email address</label>
                                                    <input type="email" name="inputEmail" class="form-control" tabindex="1" id="inputEmail" placeholder="Email" value="" autocomplete="off">
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputPassword">Password</label>
                                                    <input type="password" name="inputPassword" class="form-control" tabindex="2" id="inputPassword" placeholder="Password" autocomplete="off">
                                                </div>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-7">
                                                            <input type="checkbox" tabindex="3" name="remember" id="remember">
                                                            <label for="remember" class="rememberme"> Remember Me</label>
                                                        </div>
                                                        <div class="col-xs-5 pull-right">
                                                            <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-success" value="Log In">
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="text-center">
                                                                <a href="http://phpoll.com/recover" tabindex="5" class="forgot-password">Forgot Password?</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <input type="hidden" class="hide" name="token" id="token" value="a465a2791ae0bae853cf4bf485dbe1b6">

                                            </form>

                                        </li> <!-- -->

                                    </ul>

                                </li>

                                </c:otherwise>
                            </c:choose>

                          
                        </ul>



                    </div>
                </header>
            </div>
        </nav>



   <div class="container" style="padding: 2em;">
      
 
 
       
       
       
       <h3> Customer Profile </h3>
                      
      <div class="container">
              


          <div style="text-align: right; padding-right: 3em;">
          </div>
                  

          
                    <form style="padding-right: 2em;" name="updateInfo" method="post" action="updateInfoServ">

                        <div class="form-group">

                            <input type="text" class="form-control" id="contactInputFirstName" name="contactInputFirstName" placeholder="First Name" value="<%= cus.getFname() %>">
                        </div>
                        
                         <div class="form-group">

                            <input type="text" class="form-control" id="contactInputLastName" name="contactInputLastName" placeholder="Last Name" value="<%= cus.getLname() %>">
                        </div>

                        <div class="form-group">

                            <input type="email" class="form-control" id="contactInputEmail1" name="contactInputEmail1" placeholder="Email" value="<%= cus.getEmail() %>">
                        </div>
                        
                         <div class="form-group">

                             <input type="text" class="form-control" id="contactInputPhone" name="contactInputPhone" placeholder="Phone" value="<%= cus.getPhoneNumber() %>">
                        </div>
                        
                        <div class="form-group">

                            <input type="text" class="form-control" id="contactAddress" name="contactAddress" placeholder="Address" value="<%= cus.getAddress() %>">
                        </div>
                        
                        <div class="form-group">

                            <input type="text" class="form-control" id="contactSuburb" name="contactSuburb" placeholder="Suburb" value="<%= cus.getSuburb() %>">
                        </div>
                        
                        <div class="form-group">

                            <input type="text" class="form-control" id="contactPostcode" name="contactPostcode" placeholder="postcode" value="<%= cus.getPostcode() %>">
                        </div>                        
                        
                        <div>

                            <textarea class="form-control" rows="2" placeholder="Other message (maximum 100 words)" maxlength="100"></textarea>

                        </div>
                        <br>
                        <div class="text-center" >
            
                           <button type="submit" class="btn btn-default btn-md register-btn">Update</button>
                          
                        </div>
                    </form>


           

           

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
