/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package order;

import cart.cartDAO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.util;

public class orderDAO {

    public List<orderDTO> getAllListOrder(String username) throws ClassNotFoundException, SQLException {
        List<orderDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            String sql = "SELECT * FROM orderuser WHERE username = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, username);
            rs = stm.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("date");
                double total = rs.getDouble("total");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String status = rs.getString("status");
                list.add(new orderDTO(username, date, total, phone, address, status));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
    
    public List<orderDTO> searchOrderByUsername(String username) throws ClassNotFoundException, SQLException {
        List<orderDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            String sql = "SELECT * FROM orderuser WHERE username = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, username);
            rs = stm.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("date");
                double total = rs.getDouble("total");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String status = rs.getString("status");
                list.add(new orderDTO(username, date, total, phone, address, status));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
    
    
    public List<orderDTO> getAllListOrder() throws ClassNotFoundException, SQLException {
        List<orderDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            String sql = "SELECT * FROM orderuser";
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                String username = rs.getString("username");
                Date date = rs.getDate("date");
                double total = rs.getDouble("total");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String status = rs.getString("status");
                list.add(new orderDTO(username, date, total, phone, address, status));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public boolean removeOrderUser(String username) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "DELETE FROM orderuser WHERE username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                int affectedRows = stm.executeUpdate();
                return affectedRows > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean insertOrderUser(orderDTO orderUser) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean check = false;

        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO [orderuser] ([username], [date], [total], [phone], [address], [status]) VALUES (?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderUser.getUsername());
                stm.setDate(2, orderUser.getDate());
                stm.setDouble(3, orderUser.getTotal());
                stm.setString(4, orderUser.getPhone());
                stm.setString(5, orderUser.getAddress());
                stm.setString(6, orderUser.getStatus());
                int affectedRows = stm.executeUpdate();
                if (affectedRows > 0) {
                    check = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }

    public boolean insertOrderDetail(orderDetailDTO orderDetail, int orderId, String username) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        cartDAO cDAO = new cartDAO();
        orderDAO oDAO = new orderDAO();
        try {
            con = util.makeConnection();
            if (con != null) {

                String sql = "INSERT INTO [orderdetail] ([productID], [orderID], [price], [quantity]) VALUES (?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderDetail.getProductID());
                stm.setInt(2, orderId);
                stm.setDouble(3, orderDetail.getPrice());
                stm.setInt(4, orderDetail.getQuantity());

                int affectedRows = stm.executeUpdate();

                if (affectedRows > 0) {
                    cDAO.removeCart(username);
                } else {
                    oDAO.removeOrderUser(username);
                }
                return affectedRows > 0;

            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public int getOrderId(String username) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int orderId = -1;
        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "SELECT TOP 1 orderID FROM orderuser WHERE username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    orderId = rs.getInt("orderID");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return orderId;

    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Date currentDate = new Date(System.currentTimeMillis());

        orderDAO dao = new orderDAO();
        int orderId = dao.getOrderId("user1");
        orderDTO orderUser = new orderDTO("user1", currentDate, 931 * 2, "0985578411", "17 Yersin", "Ordered");
        orderDetailDTO orderDetail = new orderDetailDTO("PROD1A", 40, 2, 1980);
        orderDetailDTO orderDetail1 = new orderDetailDTO("PROD1D", 40, 3, 111);

        List<orderDTO> list = new ArrayList<>();
        list = dao.getAllListOrder("user1");
        for (orderDTO ord : list) {
            System.out.println(ord);
        }

    }
}
