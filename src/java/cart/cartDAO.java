/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.util;

public class cartDAO {

    private static final String EDIT_QUANTITY_CART = "UPDATE cart "
            + "SET cart.quantity = ? "
            + "FROM cart WHERE productID like ?";

    private static final String VIEW_PRODUCT_DETAIL = "SELECT c.productID, p.name, c.quantity, p.price "
            + "FROM cart c join product p on c.productID = p.productID join productdetail pd on pd.productID = p.productID WHERE username = ?";

    private static final String VIEW_PRODUCT_IMAGE = "SELECT TOP 1 pimg.img "
            + "FROM cart c join product p on c.productID = p.productID join productimg pimg on pimg.productID = p.productID "
            + "WHERE c.username = ? AND c.productID = ?";

    public boolean checkProductID(String productID, String username) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "SELECT productID FROM cart WHERE productID =? AND username=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, productID);
                stm.setString(2, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
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
        return false;
    }

    public boolean editCart(int quantity, String productID) throws SQLException {
        Connection con = null;
        PreparedStatement stm1 = null;
        boolean check = false;
        int checkQ = 0;
        try {
            con = util.makeConnection();
            if (con != null) {
                if (quantity != 0) {
                    stm1 = con.prepareStatement(EDIT_QUANTITY_CART);
                    stm1.setInt(1, quantity);
                    stm1.setString(2, productID);
                    checkQ = stm1.executeUpdate();
                }
                if (checkQ > 0) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm1 != null) {
                stm1.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }

    public List<cartDTO> viewCartDetail(String username) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<cartDTO> cart = new ArrayList<>();
        try {
            con = util.makeConnection();
            if (con != null) {
                stm = con.prepareStatement(VIEW_PRODUCT_DETAIL);
                stm.setString(1, username);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String productImg = viewImage(username, productID);
                    cart.add(new cartDTO(username, productID, productName, productImg, price, quantity));
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
        return cart;
    }

    public String viewImage(String username, String productID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = util.makeConnection();
            if (con != null) {
                stm = con.prepareStatement(VIEW_PRODUCT_IMAGE);
                stm.setString(1, username);
                stm.setString(2, productID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String productImg = rs.getString("img");
                    return productImg;
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
        return null;
    }

    public void addToCart(String username, String productID, int quantity) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO cart VALUES (?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, productID);
                stm.setInt(3, quantity);
                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public Map<String, Integer> getCartItemsWithQuantity(String username) {
        Map<String, Integer> items = new HashMap<>();
        try (Connection con = util.makeConnection()) {
            String query = "SELECT productID, quantity FROM cart WHERE username = ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, username);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                String productID = result.getString("productID");
                int quantity = result.getInt("quantity");
                items.put(productID, quantity);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return items;
    }

//    public List<cartDTO> getAllCartItems() {
//        List<cartDTO> cartItems = new ArrayList<>();
//        try (Connection con = util.makeConnection()) {
//            String sql = "SELECT * FROM cart";
//            PreparedStatement statement = con.prepareStatement(sql);
//            ResultSet result = statement.executeQuery();
//
//            while (result.next()) {
//                String username = result.getString("username");
//                String productID = result.getString("productID");
//                int quantity = result.getInt("quantity");
//                cartDTO cartItem = new cartDTO(username, productID, quantity);
//                cartItems.add(cartItem);
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//        return cartItems;
//    }
    public boolean removeCart(String username) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "DELETE FROM cart WHERE username = ?";
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

    public boolean removeFromCart(String username, String productID) {
        boolean check = false;
        try {
            Connection con = util.makeConnection();
            String query = "DELETE FROM cart WHERE username = ? AND productID = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, productID);
            int affectedRows = stm.executeUpdate();
            if (affectedRows > 0) {
                check = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check;
    }

    public void updateCartQuantity(String username, String productID, int newQuantity) {
        try {
            Connection con = util.makeConnection();
            String query = "UPDATE cart SET quantity = ? WHERE username = ? AND productID = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, newQuantity);
            stm.setString(2, username);
            stm.setString(3, productID);
            stm.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        cartDAO dao = new cartDAO();
//        dao.addToCart("user4", "PROD1A", 2);
        System.out.println(dao.checkProductID("PROD10A", "user2"));
    }
}
