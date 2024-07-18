/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.productDAO;
import product.productDTO;

public class UpdateProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            String productID = request.getParameter("txtProductID");
            double price = Double.parseDouble(request.getParameter("txtPrice"));
            int stock = Integer.parseInt(request.getParameter("txtStock"));
            productDAO dao = new productDAO();
            dao.updateProduct(productID, price, stock);
            request.getRequestDispatcher("DispatchServlet?btAction=Product").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            out.close();          
        }
    }
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {            
            request.setAttribute("UPDATE", new productDAO().getOne(request.getParameter("productID")));
            String productID = request.getParameter("productID");   
            productDAO dao = new productDAO();
            
            List<productDTO> products = dao.getAllProduct4Image(productID);
            
            String img = "";
            int ctt = 1;
            for (productDTO pro : products) {
                 img = pro.getImg().getImg();
                request.setAttribute("IMAGE"+ctt,img);
                ctt++;
            }
            request.getRequestDispatcher("DispatchServlet?btAction=Admin").forward(request, response);
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
