/*
 * This servlet updates the quantity of the cart product in the shopping cart.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.cartBO;
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
@WebServlet(name = "updateQuantityServ", urlPatterns = {"/updateQuantityServ"})
public class updateQuantityServ extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        RequestDispatcher rd = null;
        
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        cartBO cartOps = new cartBO();
        
        loginBean lbean = (loginBean)session.getAttribute("lbean");
        String name = request.getParameter("itemName");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        if(lbean == null) {
            //FORWARD TO LOGIN.
            response.sendRedirect("index.jsp?resultFlag=4");
        } else {
            int result = cartOps.updateQuantity(name, quantity, lbean.getId());
            if (result > 0) {
                rd = request.getRequestDispatcher("cartServ");
            } else {
                rd = request.getRequestDispatcher("cartServ?upValue=1");
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
