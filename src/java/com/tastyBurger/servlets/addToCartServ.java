/*
 * This servlet is responsible for adding item in to the shoping cart.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.cartBO;
import com.tastyBurger.bean.cartBean;
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
@WebServlet(name = "addToCartServ", urlPatterns = {"/addToCartServ"})
public class addToCartServ extends HttpServlet {

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
        
        loginBean lbean = (loginBean)session.getAttribute("lbean");
        if(lbean == null) {
            //FORWARD TO LOGIN.
            response.sendRedirect("index.jsp?resultFlag=4");
        } else {
            RequestDispatcher rd = null;
            
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
        
            cartBean cart_item = new cartBean();
            cartBO cartOperations = new cartBO();
            
            String pageName = request.getParameter("pageName");
            int MaxRows = cartOperations.getNumberofMaxRows(lbean.getId());
            System.out.println("max rows : "+MaxRows);
            
            cart_item.setCart_no(MaxRows + 1);
            cart_item.setName(request.getParameter("burgerName"));
            cart_item.setPrice(Integer.parseInt(request.getParameter("burgerPrice")));
            cart_item.setQuantity(1);
            cart_item.setCustomer_id(lbean.getId());

            String name = cartOperations.getItemName(cart_item.getCustomer_id(), cart_item.getName());
            if (name == null) {
                int result = cartOperations.addToCart(cart_item);

                if (result > 0) {
                    int numberOfRows = cartOperations.getNumberofRowsOfNew(cart_item.getCustomer_id());
                    if (numberOfRows == 0) {
                        session.setAttribute("numberOfRows", 0);
                    } else {
                        session.setAttribute("numberOfRows", numberOfRows);
                    }
                    session.setAttribute("successful", "s");

                    rd = request.getRequestDispatcher(pageName+".jsp?addValue=1");
                } else {
                    int numberOfRows = cartOperations.getNumberofRowsOfNew(cart_item.getCustomer_id());
                    if (numberOfRows == 0) {
                        session.setAttribute("numberOfRows", 0);
                    } else {
                        session.setAttribute("numberOfRows", numberOfRows);
                    }
                    session.setAttribute("successful", "us");

                    rd = request.getRequestDispatcher(pageName+".jsp?addValue=2");
                }
            } else {
                rd = request.getRequestDispatcher(pageName+".jsp?addValue=3");
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
