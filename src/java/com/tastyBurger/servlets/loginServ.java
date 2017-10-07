/*
 * This is the login servlet which will get the login id and password from the user to authenticate user to provide appropriate responce.
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
@WebServlet(name = "loginServ", urlPatterns = {"/loginServ"})
public class loginServ extends HttpServlet {

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
        String email = request.getParameter("inputEmail");
        String password = request.getParameter("inputPassword");
        loginBean lbean;
        int numberOfRows;
        
        customerBO cusBO = new customerBO();
        cartBO cartOperations = new cartBO();
        RequestDispatcher rd = null;
        
        HttpSession session = request.getSession();
        
        if(email==null || "".equals(email) || password==null || "".equals(password)) {
            response.sendRedirect("index.jsp?resultFlag=1");
            //CHECK FOR OTHER VALIDATIONS.
	} else {
            int flag = cusBO.login(email, password);
            
            switch (flag) {
                case 1:
                    session.setAttribute("logFlag", "false");
                    
                    rd = request.getRequestDispatcher("index.jsp?resultFlag=1");
                    break;
                case 2:
                    session.setAttribute("email", email);
                    session.setAttribute("logFlag", "firstLogin");
                    
                    rd = request.getRequestDispatcher("index.jsp");
                    break;
                case 3:
                    lbean = cusBO.getLbean(email);
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
                case 4:
                    lbean = cusBO.getLbean(email);
                    numberOfRows = cartOperations.getNumberofRowsOfNew(lbean.getId());
                    if (numberOfRows == 0) {
                        session.setAttribute("numberOfRows", 0);
                    } else {
                        session.setAttribute("numberOfRows", numberOfRows);
                    }
                    session.setAttribute("logFlag", "true");
                    session.setAttribute("lbean", lbean);
                    
                    rd = request.getRequestDispatcher("/employee/index.jsp");
                    break;
                case 5:
                    lbean = cusBO.getLbean(email);
                    numberOfRows = cartOperations.getNumberofRowsOfNew(lbean.getId());
                    if (numberOfRows == 0) {
                        session.setAttribute("numberOfRows", 0);
                    } else {
                        session.setAttribute("numberOfRows", numberOfRows);
                    }
                    session.setAttribute("logFlag", "true");
                    session.setAttribute("lbean", lbean);
                    
                    rd = request.getRequestDispatcher("/admin/admin.jsp");
                    break;
                case 6:
                    session.setAttribute("logFlag", "false");
                    rd = request.getRequestDispatcher("index.jsp?resultFlag=2");
                    break;
                default:
                    session.setAttribute("logFlag", "false");
                    rd = request.getRequestDispatcher("index.jsp?resultFlag=3");
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
