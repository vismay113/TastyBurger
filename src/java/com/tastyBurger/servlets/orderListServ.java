/*
 * This servlet will get the order list according to status for the employees.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.orderBO;
import com.tastyBurger.bean.orderBean;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "orderListServ", urlPatterns = {"/orderListServ"})
public class orderListServ extends HttpServlet {

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
        
        int value = Integer.parseInt(request.getParameter("linkValue"));
        String status = null;
        if (value == 1) {
            status = "cooking";
        } else {
            status = "on delivery";
        }
        
        orderBO orderOps = new orderBO();
        
        List<orderBean> orders = orderOps.getOrderByStatus(status);
        session.setAttribute("orderByStatus", orders);
        
        if (status.equals("cooking")) {
            rd = request.getRequestDispatcher("/employee/orderlist.jsp");
        } else {
            rd = request.getRequestDispatcher("/employee/deliverylist.jsp");
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