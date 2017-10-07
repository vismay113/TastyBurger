/*
 * This is the registration servlet for the users to get registered for the tasty burger application.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.customerBO;
import com.tastyBurger.bean.customerBean;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author VBlue
 */
@WebServlet(name = "regServ", urlPatterns = {"/regServ"})
public class regServ extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = null;
        
        customerBean cus = new customerBean();
        customerBO cusBO = new customerBO();
        
        cus.setFname(request.getParameter("inputFirstName"));
        cus.setLname(request.getParameter("inputLastName"));
        cus.setAddress(request.getParameter("inputAddress"));
        cus.setSuburb(request.getParameter("inputSuburb"));
        cus.setPostcode(request.getParameter("inputPostcode"));
        cus.setPhoneNumber(request.getParameter("inputPhone"));
        cus.setEmail(request.getParameter("exampleInputEmail1"));
        cus.setPassword(request.getParameter("exampleInputPassword1"));
        cus.setConfirmPassword(request.getParameter("exampleInputConfirmPassword1"));
        
        if(cus.getFname().isEmpty() || cus.getFname().matches(".*\\d.*") ) {
            response.sendRedirect("register.jsp?resultFlag=1");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getLname().isEmpty() || cus.getLname().matches(".*\\d.*") ) {
            response.sendRedirect("register.jsp?resultFlag=2");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getAddress().isEmpty()) {
            response.sendRedirect("register.jsp?resultFlag=3");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getSuburb().isEmpty()|| cus.getSuburb().matches(".*\\d.*") ) {
            response.sendRedirect("register.jsp?resultFlag=4");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getPostcode().isEmpty() || (cus.getPostcode().matches("[0-9]+") && cus.getPostcode().length() < 4)) {
            response.sendRedirect("register.jsp?resultFlag=5");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getPhoneNumber().isEmpty() || !cus.getPhoneNumber().matches(".*\\d.*") ) {
            response.sendRedirect("register.jsp?resultFlag=6");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getEmail().isEmpty()) {
            response.sendRedirect("register.jsp?resultFlag=7");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getPassword().isEmpty()) {
            response.sendRedirect("register.jsp?resultFlag=8");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(cus.getConfirmPassword().isEmpty()) {
            response.sendRedirect("register.jsp?resultFlag=9");
            //CHECK FOR OTHER VALIDATIONS.
	} else if(!cus.getConfirmPassword().equals(cus.getPassword())) {
            response.sendRedirect("register.jsp?resultFlag=10");
            //CHECK FOR OTHER VALIDATIONS.
	} else {
            HttpSession session = request.getSession();
            session.setAttribute("email", cus.getEmail());

            int addCus = cusBO.addCustomer(cus);

            if (addCus > 0 && addCus !=8) {
                rd = request.getRequestDispatcher("/mailServ");
            } else {
                rd = request.getRequestDispatcher("/register.jsp?resultFlag=11");
            }
            rd.forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
