/*
 * This servlet will get the registration corfirmation code and mail it to the user.
 */
package com.tastyBurger.servlets;

import com.tastyBurger.BO.customerBO;
import com.tastyBurger.bean.loginBean;
import com.tastyBurger.BO.mailBO;
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
@WebServlet(name = "mailServ", urlPatterns = {"/mailServ"})
public class mailServ extends HttpServlet {

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
        HttpSession session = request.getSession();
	String email = request.getParameter("mailId");
	loginBean lbean = (loginBean) session.getAttribute("loginBean");
        
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
        
        customerBO cusBO = new customerBO();
        mailBO mail = new mailBO();
        
        RequestDispatcher rd = null;
        int j = 0;
        
        try {
            int code = cusBO.randomNumber();
            j = cusBO.setCode(code, email);
            
            if (j > 0) {
                mail.sendMail(email, code);
                
                rd = request.getRequestDispatcher("/admin/userlist.jsp?reactValue=2");
            } else {
                rd = request.getRequestDispatcher("/admin/userlist.jsp?reactValue=1");
            }
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }        
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
	String email = (String) session.getAttribute("email");
	loginBean lbean = (loginBean) session.getAttribute("loginBean");
        
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
        
        customerBO cusBO = new customerBO();
        mailBO mail = new mailBO();
        
        RequestDispatcher rd = null;
        int j = 0;
        
        try {
            int code = cusBO.randomNumber();
            j = cusBO.setCode(code, email);
            mail.sendMail(email, code);
            rd = request.getRequestDispatcher("thankyou.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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
