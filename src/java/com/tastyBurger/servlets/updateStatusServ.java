/*
 * This servlet will change the status of the orders in the order table.
 * this status can only be updated by the employees.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.orderBO;
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
@WebServlet(name = "updateStatusServ", urlPatterns = {"/updateStatusServ"})
public class updateStatusServ extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher rd = null;
        
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        String status = request.getParameter("updateStatus");
        int order_id = Integer.parseInt(request.getParameter("order_id"));
        
        orderBO orderOps = new orderBO();
        
        int result = orderOps.updateStatus(order_id, status);
        if (status.equals("on delivery")) {
            if (result > 0) {
                rd = request.getRequestDispatcher("orderListServ?linkValue=1");
            } else {
                rd = request.getRequestDispatcher("/employee/orderlist.jsp?checkValue=1");
            }
        } else {
            if (result > 0) {
            rd = request.getRequestDispatcher("orderListServ?linkValue=2");
        } else {
            rd = request.getRequestDispatcher("/employee/deliverylist.jsp?checkValue=1");
        }
        }
        rd.forward(request, response);
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
