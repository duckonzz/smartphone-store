/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import account.accountDAO;
import account.accountDTO;
import account.accountErrors;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErrorSignUpServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "";
        try {
            String fullname = request.getParameter("txtFullName");
            String username = request.getParameter("txtUserName");
            String email = request.getParameter("txtMail");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("confirmPassword");

            accountErrors error = new accountErrors();
            boolean isValid
                    = error.checkFullNameLength(fullname)
                    & error.checkUserNameLength(username)
                    & error.checkUserAccountExisted(username)
                    & error.checkPasswordLength(password)
                    & error.checkEmail(email)
                    & error.checkConfirm(password, confirm);
            if (isValid) {
                accountDAO dao = new accountDAO();
                accountDTO acc = new accountDTO(username, password, email, fullname,0);
                dao.signUp(acc);
                url = "login.jsp";
            } else {
                url = "signUp.jsp";
                request.setAttribute("ERROR", error);
            }

        } catch (SQLException e) {
            log("RegisterServlet SQLException:" + e.getMessage());
        } catch (ClassNotFoundException e) {
            log("RegisterServlet ClassNotFoundException:" + e.getMessage());
        } catch (NamingException e) {
            log("RegisterServlet NamingException:" + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
        }
    }

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
        processRequest(request, response);
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
