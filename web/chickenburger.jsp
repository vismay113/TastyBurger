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
        
        <%@ page import="com.tastyBurger.bean.loginBean" %>
        
        <% String logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% Integer numberOfRows = (Integer)session.getAttribute("numberOfRows"); %>
        
        <%
            String addValue = request.getParameter("addValue");
            if(addValue != null && !"".equals(addValue)) {
                int addValue1 = Integer.parseInt(addValue);
                if(addValue1 == 1) {
                    out.println("<script>alert('Item added to cart Successfully.');</script>");
                } else if(addValue1 == 2) {
                    out.println("<script>alert('Something went wrong. Please try again later.');</script>");
                } else if (addValue1 == 3) {
                    out.println("<script>alert('Item is already added. Change quantity in the shopping cart.');</script>");
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
        
        <header>
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

                               
                        <li>
                  
                   <a href="/TastyBurger/register.jsp"><button type="button" class="btn btn-success btn-md register-btn">Register</button></a>
                      </li>
                        </ul>

                    </div>
                </div>
            </nav>

        </header>





        <div class="tastyburger-content">

            <div class="container">

                <div class="panel panel-default">
                    <div class="panel-heading text-center">Chicken Burgers </div>
                    <div class="panel-body"> 
                        <div class="row text-center">
                            
                            <form action="addToCartServ" method="post">
                            <div class="col-sm-6 col-md-4">
                                <div class="thumbnail">
                                    <img src="/TastyBurger/img/chicken/chickendouble.jpg" alt="chickendouble">
                                    <div class="caption">
                                        <h3>Chicken Double</h3>
                                         <h4>$5.00</h4>
                                         
                                        <p>Burger Buns, Double Chicken, Double Cheese, Lettuce, Tomato, Onion, Pickle, Trucker sauce</p>
                                        <input type="hidden" name="burgerName" value="Chicken Double" />
                                        <input type="hidden" name="burgerPrice" value="5" />
                                        <input type="hidden" name="pageName" value="chickenburger" />
                                        <br>
                                        <p><input type="submit" class="btn btn-primary" role="button" value="Add to Cart" /> </p>
                                    </div>
                                </div>
                            </div>
                            </form>
                            
                            <form action="addToCartServ" method="post">
                            <div class="col-sm-6 col-md-4">
                                <div class="thumbnail">
                                    <img src="/TastyBurger/img/chicken/chickenfire.jpg" alt="chickenfire">
                                    <div class="caption">
                                        <h3>Chicken Fire</h3>
                                        <h4>$4.00</h4>
                                        <p>Burger Buns, Fried Chicken, Lettuce, Ranch Sauce & Pickles</p>
                                        <input type="hidden" name="burgerName" value="Chicken Fire" />
                                        <input type="hidden" name="burgerPrice" value="4" />
                                        <input type="hidden" name="pageName" value="chickenburger" />
                                        <br>
                                        <p><input type="submit" class="btn btn-primary" role="button" value="Add to Cart" /> </p>
                                    </div>
                                </div>
                            </div>
                            </form>
                                
                            <form action="addToCartServ" method="post">
                            <div class="col-sm-6 col-md-4">
                                <div class="thumbnail">
                                    <img src="/TastyBurger/img/chicken/chickenhouse.jpg" alt="chickenhouse">
                                    <div class="caption">
                                        <h3>Chicken House</h3>
                                           <h4>$4.00</h4>
                                        <p>Burger multi-grain Buns, Lettuce, Tomato, Pickles, Red onion, Mayonnaise, Choice of tender marinated grilled or crispy chicken.</p>
                                        <input type="hidden" name="burgerName" value="Chicken House" />
                                        <input type="hidden" name="burgerPrice" value="4" />
                                        <input type="hidden" name="pageName" value="chickenburger" />
                                        <p><input type="submit" class="btn btn-primary" role="button" value="Add to Cart" /> </p>
                                    </div>
                                </div>
                            </div>
                            </form>
                        </div>



                    </div> <!-- panel body-->

                </div> <!-- panel -->
            </div> <!-- container -->

        </div> <!-- tasty burger-content -->

        <footer>
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