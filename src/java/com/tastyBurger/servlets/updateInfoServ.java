/*
 * This servlet is created to update the profile information for the accounts.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.customerBO;
import com.tastyBurger.bean.customerBean;
import com.tastyBurger.bean.loginBean;
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
@WebServlet(name = "updateInfoServ", urlPatterns = {"/updateInfoServ"})
public class updateInfoServ extends HttpServlet {

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
        customerBean cus = new customerBean();
        customerBO cusBO = new customerBO();
        
        HttpSession session = request.getSession();
        loginBean lbean = (loginBean)session.getAttribute("lbean");
        if(lbean == null) {
            //FORWARD TO LOGIN.
            response.sendRedirect("index.jsp?resultFlag=4");
            return;
        }
        RequestDispatcher rd = null;
        
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        cus.setFname(request.getParameter("contactInputFirstName"));
        cus.setLname(request.getParameter("contactInputLastName"));
        cus.setEmail(request.getParameter("contactInputEmail1"));
        cus.setPhoneNumber(request.getParameter("contactInputPhone"));
        cus.setAddress(request.getParameter("contactAddress"));
        cus.setSuburb(request.getParameter("contactSuburb"));
        cus.setPostcode(request.getParameter("contactPostcode"));
        
        if (cus.getEmail().isEmpty()) {
            response.sendRedirect("profile.jsp?proValue=2");
            return;
        }
        
        if (lbean.getLoginEmail().equals(cus.getEmail())) {
            int update = cusBO.updateProfileInfoForOld(cus, lbean.getId());
        
            if (update > 0) {
                session.setAttribute("wrong", update);
                rd = request.getRequestDispatcher("profileServ");
            } else {
                session.setAttribute("wrong", update);
                rd = request.getRequestDispatcher("profileServ");
            }
        } else {
            int update = cusBO.updateProfileInfo(cus, lbean.getId());
        
            if (update > 0 && update != 8 ) {
                session.setAttribute("wrong", update);
                rd = request.getRequestDispatcher("profileServ");
            } else {
                session.setAttribute("wrong", update);
                rd = request.getRequestDispatcher("profileServ");
            }
        }
        
        
        rd.forward(request, response);
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
