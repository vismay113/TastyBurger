/*
 * This servlet will create the order successfully for the user.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.cartBO;
import com.tastyBurger.BO.orderBO;
import com.tastyBurger.bean.cartBean;
import com.tastyBurger.bean.loginBean;
import com.tastyBurger.bean.orderBean;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "orderServ", urlPatterns = {"/orderServ"})
public class orderServ extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        
        loginBean lbean = (loginBean)session.getAttribute("lbean");
        List<cartBean> cart = (List<cartBean>)session.getAttribute("cart");
        Integer total = (Integer)session.getAttribute("total");
        int numberOfRows;
        
        cartBean cart1 = cart.get(0);
        int cart_no = cart1.getCart_no();
        
        List<cartBean> finalOrder;
        orderBean order = new orderBean();
        orderBO orderOperations = new orderBO();
        cartBO cartOperations = new cartBO();
        
        order.setAmount(total);
        order.setDeliveryAddress(request.getParameter("contactInputAddress"));
        order.setDeliverySuburb(request.getParameter("contactInputSuburb"));
        order.setDeliveryPostcode(request.getParameter("contactInputPostcode"));
        order.setComment(request.getParameter("comment_text"));
        order.setCustomerId(lbean.getId());
        order.setCart_no(cart_no);
        
        int result = 0;
        try {
            result = orderOperations.addOrder(order);
        } catch (Exception ex) {
            Logger.getLogger(orderServ.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (result > 0) {
            finalOrder = cartOperations.getLatestCart(order.getCart_no());
            session.setAttribute("finalOrder", finalOrder);
            
            int totalNew = 0;
            for (cartBean cart2 : finalOrder) {
                totalNew = totalNew + (cart1.getPrice() * cart2.getQuantity());
            }
            session.setAttribute("totalNew", totalNew);
            
            numberOfRows = cartOperations.getNumberofRowsOfNew(lbean.getId());
            if (numberOfRows == 0) {
                session.setAttribute("numberOfRows", 0);
            } else {
                session.setAttribute("numberOfRows", numberOfRows);
            }
            
            rd = request.getRequestDispatcher("finalOrder.jsp");
        } else {
            rd = request.getRequestDispatcher("checkout.jsp?checkOut=1");
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
