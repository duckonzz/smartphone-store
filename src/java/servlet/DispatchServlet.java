/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatchServlet extends HttpServlet {

    private final String AdminPage = "admin.jsp";

    private final String LoginPage = "login.jsp";
    private final String LoginServlet = "LoginServlet";

    private final String LogOutServlet = "LogOutServlet";

    private final String SignUpPage = "signUp.jsp";
    private final String ErrorSignUpServlet = "ErrorSignUpServlet";

    private final String AccountAdminServlet = "AccountAdminServlet";
    private final String DeleteUserServlet = "DeleteUserServlet";

    private final String SearchAccountAdminServlet = "SearchAccountAdminServlet";
    private final String SearchProductAdminServlet = "SearchProductAdminServlet";
    private final String SearchOrderAdminServlet = "SearchOrderAdminServlet";

    private final String ProductAdminServlet = "ProductAdminServlet";

    private final String UpdateProductServlet = "UpdateProductServlet";

    private final String UploadProductServlet = "UploadProductServlet";

    private final String ViewOrderAdminServlet = "ViewOrderAdminServlet";

    private final String ProductUserServlet = "ProductUserServlet";

    private final String UpdateAccountServlet = "UpdateAccountServlet";
    private final String UpdateAccountPage = "profile.jsp";

    private final String SearchProductServlet = "SearchProductServlet";

    private final String AddToCartServlet = "AddToCartServlet";

    private final String ViewCartServlet = "ViewCartServlet";

    private final String CheckOutServlet = "CheckOutServlet";

    private final String RemoveCartServlet = "RemoveCartServlet";

    private final String EditCartServlet = "EditCartServlet";

    private final String ViewMorePage = "ViewMore.jsp";
    private final String ViewMoreServlet = "ViewMoreServlet";

    private final String HomePage = "Home.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String btValue = request.getParameter("btAction");
            String url = ProductUserServlet;
            if (btValue == null) {

            } else if (btValue.equals("Login")) {
                url = LoginServlet;
            } else if (btValue.equals("LoginPage")) {
                url = LoginPage;
            } else if (btValue.equals("SignUp")) {
                url = ErrorSignUpServlet;
            } else if (btValue.equals("Sign Up")) {
                url = SignUpPage;
            } else if (btValue.equals("Account")) {
                url = AccountAdminServlet;
            } else if (btValue.equals("Search User")) {
                url = SearchAccountAdminServlet;
            } else if (btValue.equals("Delete")) {
                url = DeleteUserServlet;
            } else if (btValue.equals("Product")) {
                url = ProductAdminServlet;
            } else if (btValue.equals("Search Product")) {
                url = SearchProductAdminServlet;
            } else if (btValue.equals("Search Order")) {
                url = SearchOrderAdminServlet;
            } else if (btValue.equals("Update")) {
                url = UpdateProductServlet;
            } else if (btValue.equals("ViewOrder")) {
                url = ViewOrderAdminServlet;
            } else if (btValue.equals("Upload")) {
                url = UploadProductServlet;
            } else if (btValue.equals("Logout")) {
                url = LogOutServlet;
            } else if (btValue.equals("ProductUser")) {
                url = ProductUserServlet;
            } else if (btValue.equals("ViewMore")) {
                url = ViewMoreServlet;
            } else if (btValue.equals("Home")) {
                url = HomePage;
            } else if (btValue.equals("ViewMorePage")) {
                url = ViewMorePage;
            } else if (btValue.equals("Search")) {
                url = SearchProductServlet;
            } else if (btValue.equals("Add")) {
                url = AddToCartServlet;
            } else if (btValue.equals("Admin")) {
                url = AdminPage;
            } else if (btValue.equals("Update Profile")) {
                url = UpdateAccountServlet;
            } else if (btValue.equals("Profile")) {
                url = UpdateAccountPage;
            } else if (btValue.equals("Cart")) {
                url = ViewCartServlet;
            } else if (btValue.equals("Checkout")) {
                url = CheckOutServlet;
            } else if (btValue.equals("Remove")) {
                url = RemoveCartServlet;
            } else if (btValue.equals("Edit")) {
                url = EditCartServlet;
            }
            request.getRequestDispatcher(url).forward(request, response);
        } finally {
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
