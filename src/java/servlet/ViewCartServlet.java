/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import account.accountDTO;
import cart.cartDAO;
import cart.cartDTO;
import java.io.IOException;
import java.io.PrintWriter;
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

public class ViewCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "ProductUserServlet";
        try {
            HttpSession session = request.getSession();
            accountDTO user = (accountDTO) session.getAttribute("account");
            cartDAO cDAO = new cartDAO();
            orderDAO oDAO = new orderDAO();
            int quantity = 0;

            String username = user.getUsername();

            List<cartDTO> userCarts = cDAO.viewCartDetail(username);
            List<orderDetailDTO> list = new ArrayList<>();
            List<orderDTO> listOrders = new ArrayList<>();

            double total = 0;

            for (cartDTO cart : userCarts) {
                String productId = cart.getProductID();
                double price = cart.getPrice();
                quantity = cart.getQuantity();
                if (total == 0) {
                    total = (price * quantity);
                } else {
                    total += (price * quantity);

                }
                list.add(new orderDetailDTO(productId, quantity, price));
            }

            session.setAttribute("TOTAL", total);
            session.setAttribute("ORDER_LIST", list);

            if (userCarts != null) {
                session.setAttribute("CART", userCarts);
                url = "viewCart.jsp";
            } else {
                url = "ProductUserServlet";
            }

            listOrders = oDAO.getAllListOrder(username);

            if (listOrders != null) {
                session.setAttribute("LIST_ORDERS", listOrders);
                url = "viewCart.jsp";
            } else {
                url = "ProductUserServlet";
            }

        } catch (Exception e) {
            log("Error at ViewCartServlet: " + e.toString());
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
