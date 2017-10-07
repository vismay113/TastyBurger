/*
 * This servlet is responsible to authenticate the user when they login for the first time.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.cartBO;
import com.tastyBurger.BO.customerBO;
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
@WebServlet(name = "codeServ", urlPatterns = {"/codeServ"})
public class codeServ extends HttpServlet {

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
        customerBO cus = new customerBO();
        cartBO cartOperations = new cartBO();
        
        loginBean lbean;
        int numberOfRows;
        
        String email = (String)session.getAttribute("email");
        String code = request.getParameter("inputConfirmCode");
        
        RequestDispatcher rd = null;
        
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        if (code == null) {
            session.setAttribute("logFlag", "firstLogin");
            response.sendRedirect("index2.jsp?resultFlag=1");
        } else {
            int result = cus.firstLogin(email, code);
        
            switch (result) {
                case 0:
                    lbean = cus.getLbean(email);
                    numberOfRows = cartOperations.getNumberofRowsOfNew(lbean.getId());
                    if (numberOfRows == 0) {
                        session.setAttribute("numberOfRows", 0);
                    } else {
                        session.setAttribute("numberOfRows", numberOfRows);
                    }                    
                    session.setAttribute("logFlag", "true");
                    session.setAttribute("lbean", lbean);
                    
                    rd = request.getRequestDispatcher("index.jsp");
                    break;
                case 1:
                    session.setAttribute("logFlag", "firstLogin");
                    session.setAttribute("email", email);
                    rd = request.getRequestDispatcher("index.jsp?resultFlag=");
                    break;
                default:
                    session.setAttribute("logFlag", "firstLogin");
                    session.setAttribute("email", email);
                    rd = request.getRequestDispatcher("index.jsp?resultFlag=2");
                    break;
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
