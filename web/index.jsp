
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %> 

<%-- Set session-scoped variable to track the view user is coming from.
     This is used by the language mechanism in the Controller so that
     users view the same page when switching between English and Czech. --%>
<c:set var='view' value='/index' scope='session' />

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
        
        <%@ page import="com.tastyBurger.bean.loginBean" %>
        
        <% Object logFlag = (String)session.getAttribute("logFlag"); %>
        <% loginBean lbean = (loginBean) session.getAttribute("lbean"); %>
        
        <% Integer numberOfRows = (Integer)session.getAttribute("numberOfRows");%>
        
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

                                </ul>
                            </li>

                        </ul>

                        <ul class="nav navbar-nav navbar-right text-center ">

                            
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
                </header>
            </div>

        </nav>





        <div class="tastyburger-slider">
            <div class="container">

                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="2"></li>

                    </ol>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox" >
                        <div class="item active">
                            <img src="/TastyBurger/img/slide1.jpg" alt="Lorem ipsum dolor si amet">
                            <!--
                             <div class="carousel-caption">
                               ...
                             </div>
                            -->

                        </div>
                        <div class="item">
                            <img src="/TastyBurger/img/slide2.jpg" alt="Lorem ipsum dolor si amet2">
                            <!--
                             <div class="carousel-caption">
                               ...
                             </div>
                            -->
                        </div>
                        <div class="item">
                            <img src="/TastyBurger/img/slide3.jpg" alt="Lorem ipsum dolor si amet3">
                            <!--
                             <div class="carousel-caption">
                               ...
                             </div>
                            -->
                        </div>




                    </div>

                    <!-- Controls -->
                    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>

        </div>

        <div class="tastyburger-content">

            <div class="container">

                <div class="panel panel-default">
                    <div class="panel-heading text-center">Categories </div>
                    <div class="panel-body"> 
                        <div class="col-md-12">

                            <div class="row">
                                <div class="col-sm-6 col-md-4">
                                    <div class="thumbnail">
                                        <a href="/TastyBurger/beefburger.jsp">
                                            <img src="/TastyBurger/img/burger_beef.jpg" alt="burger_beef">
                                        </a>

                                        <div class="caption">


                                            <a href="/TastyBurger/beefburger.jsp" class="btn btn-primary btn-group-justified" role="button">Beef Burger</a> 
                                        </div>
                                    </div>
                                </div>



                                <div class="col-sm-6 col-md-4">
                                    <div class="thumbnail">
                                        <a href="/TastyBurger/chickenburger.jsp">
                                            <img src="/TastyBurger/img/burger_chicken.jpg" alt="burger_chicken">
                                        </a>

                                        <div class="caption">


                                            <a href="/TastyBurger/chickenburger.jsp" class="btn btn-primary btn-group-justified" role="button">Chicken Burger</a> 
                                        </div>
                                    </div>
                                </div>



                                <div class="col-sm-6 col-md-4">
                                    <div class="thumbnail">
                                        <a href="/TastyBurger/fishburger.jsp">
                                            <img src="/TastyBurger/img/burger_fish.jpg" alt="burger_fish">
                                        </a>

                                        <div class="caption">


                                            <a href="/TastyBurger/fishburger.jsp" class="btn btn-primary btn-group-justified" role="button">Fish Burger</a> 
                                        </div>
                                    </div>
                                </div>


                                <div class="col-sm-6 col-md-4">
                                    <div class="thumbnail">
                                        <a href="/TastyBurger/vegetarian.jsp">
                                            <img src="/TastyBurger/img/vegetarian_burger.jpg" alt="vegetarian_burger">
                                        </a>

                                        <div class="caption">


                                            <a href="/TastyBurger/vegetarian.jsp" class="btn btn-primary btn-group-justified" role="button">Vegetarian Burger</a> 
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-6 col-md-4">
                                    <div class="thumbnail">
                                        <a href="/TastyBurger/drink.jsp">
                                            <img src="/TastyBurger/img/drink.jpg" alt="drink">
                                        </a>

                                        <div class="caption">


                                            <a href="/TastyBurger/drink.jsp" class="btn btn-primary btn-group-justified" role="button">Drink</a> 
                                        </div>
                                    </div>
                                </div>



                                <div class="col-sm-6 col-md-4">
                                    <div class="thumbnail">
                                        <a href="/TastyBurger/chips.jsp">
                                            <img src="/TastyBurger/img/chips.jpg" alt="chips">
                                        </a>

                                        <div class="caption">


                                            <a href="/TastyBurger/chips.jsp" class="btn btn-primary btn-group-justified" role="button">Chips</a> 
                                        </div>
                                    </div>
                                </div>
                            </div>



                        </div>


                    </div> <!-- panel body-->

                </div> <!-- panel -->
            </div> <!-- container -->

        </div> <!-- tasty burger-content -->

        <footer>
            <div class="tastyburger-footer">
                <div class="container">
                    <div class="col-md-12">
                      
                        <p class="text-center"> Share us with friends on   </p>

                        <div class="text-center">
                            <a href="http://www.twitter.com" class="btn btn-social-icon btn-twitter">
                                <span class="fa fa-twitter"></span>
                            </a>

                            <a href="http://www.facebook.com" class="btn btn-social-icon btn-facebook">
                                <span class="fa fa-facebook"></span>
                            </a>

                            <a href="http://www.instagram.com" class="btn btn-social-icon btn-instagram">
                                <span class="fa fa-instagram"></span>
                            </a>

                            <a href="http://www.flickr.com" class="btn btn-social-icon btn-flickr">
                                <span class="fa fa-flickr"></span>
                            </a>

                        </div>
                        <br>
  <p class="text-center"> &copy Copyright CQ University Software Development Project Team 2017   </p>
                    </div>

                </div>

            </div>

        </footer>

    </body>
</html>
