/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import account.accountDTO;
import cart.cartDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import order.orderDAO;
import order.orderDTO;
import order.orderDetailDTO;

public class CheckOutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "viewCart.jsp";
        try {
            HttpSession session = request.getSession();
            orderDAO oDAO = new orderDAO();
            //List<orderDTO> listOrders = new ArrayList<>();

            double total = 0;
            List<orderDetailDTO> list = new ArrayList<>();
            List<cartDTO> listCart = new ArrayList<>();

            accountDTO loginUser = (accountDTO)session.getAttribute("account");
            
            String username = loginUser.getUsername();
            


            String phone = request.getParameter("phone");
            Date date = new Date(System.currentTimeMillis());

            String address = request.getParameter("address") + ", Dis " + request.getParameter("district") + ", " + request.getParameter("city") + " City";

            total = (Double) (session.getAttribute("TOTAL"));
            list = (List<orderDetailDTO>) session.getAttribute("ORDER_LIST");

            orderDTO orderUser = new orderDTO(username, date, total, phone, address, "Ordered");
            boolean check = oDAO.insertOrderUser(orderUser);
            int orderId = oDAO.getOrderId(username);
//            listOrders = oDAO.getAllListOrder("");
//            session.setAttribute("LIST_ORDERS", listOrders);

            if (check) {

                for (orderDetailDTO order : list) {
                    oDAO.insertOrderDetail(order, orderId, username);
                }
                listCart = (List<cartDTO>) session.getAttribute("CART");
               
                url = "ViewCartServlet";
            }

//            else ( if ko insert dc thi tao MESSAGE o day )
        } catch (Exception e) {
            log("Error at CheckOutServlet " + e.toString());
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
