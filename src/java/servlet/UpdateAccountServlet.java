/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import account.accountDAO;
import account.accountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            accountDAO dao = new accountDAO();
            String username = request.getParameter("txtUserName");
            String fullname = request.getParameter("txtFullName");
            String mail = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            boolean check = dao.UpdateAccount(username, fullname, mail, password);
            if (check) {
                accountDTO account = dao.checkLogin(username, password);
                session.setAttribute("account", account);
                String message = "Update Succesfully!!!";
                request.setAttribute("MESSAGE", message);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher("DispatchServlet?btAction=Profile").forward(request, response);
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {            
            request.setAttribute("account", new accountDAO().getOneUser(request.getParameter("username")));
                                                        
            request.getRequestDispatcher("profile.jsp").forward(request, response);
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
        processRequest(request, response);
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
