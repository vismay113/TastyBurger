/*
 * This servlet will get all the past orders for the user. For now it will only shows the delivered orders.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.orderBO;
import com.tastyBurger.bean.cartBean;
import com.tastyBurger.bean.loginBean;
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
@WebServlet(name = "pastOrderServ", urlPatterns = {"/pastOrderServ"})
public class pastOrderServ extends HttpServlet {

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
        
        orderBO orderOps = new orderBO();
        
        loginBean lbean = (loginBean)session.getAttribute("lbean");
        
        List<List<cartBean>> orders = orderOps.getAllOrdersForCustomer(lbean.getId());
        List<Integer> amounts = orderOps.getAmout(lbean.getId());
        
        session.setAttribute("amounts", amounts);
        session.setAttribute("pastOrders", orders);
        
        rd = request.getRequestDispatcher("orderhistorydetail.jsp");
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
