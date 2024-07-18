/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import util.util;

public class productDAO {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        productDAO dao = new productDAO();
//        System.out.println(dao.updateProduct("PROD1A", 9999, 9999));
//        List<productDTO> list = dao.getAllProducts(4, 16);
//
//        for (productDTO tt : list) {
//            System.out.println(tt.getName());
//        }
//        System.out.println(dao.getOne("PROD1A"));
//        System.out.println(dao.upload("PROD999", "Iphone 99", 999, "images/samsung-galaxy-s24-vang-1.jpg", "1TB", "Black", "No des", 10));
//        System.out.println(dao.getAllProduct4Image("PROD1A"));
//        System.out.println(dao.countProduct());
//        System.out.println(dao.countProductSearch("iphone"));
//        System.out.println(dao.upload("PROTEST111", "TEST IPHONE", 111, "testphoto", "256 ", "test color", "test uplod", 1));
        System.out.println(dao.checkProductID("PROD1A"));
        
    }

    public List<productDTO> getAllProducts(int index, int pageSize) throws ClassNotFoundException, SQLException {
        List<productDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String check = "";
        try {
            int a = (index - 1) * pageSize;
            con = util.makeConnection();
            String sql = "SELECT p.*, pd.size, pd.color, pd.description, pd.stock, pimg.img FROM product p join productdetail pd on p.productID = pd.productID  join productimg pimg on pd.productID = pimg.productID ORDER BY p.productID OFFSET " + a + "ROWS FETCH NEXT " + pageSize + "ROWS ONLY";
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (!check.equals(rs.getString("productID"))) {
                    productImgDTO pimg = new productImgDTO(rs.getString("img"));
                    productDetailDTO pd = new productDetailDTO(rs.getString("size"), rs.getString("color"), rs.getString("description"), rs.getInt("stock"));
                    productDTO p = new productDTO(rs.getString("productID"), rs.getString("name"), rs.getDouble("price"), pd, pimg);
                    check = rs.getString("productID");
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public List<productDTO> getAllProduct4Image(String ProductID) throws ClassNotFoundException, SQLException {
        List<productDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String check = ProductID;
        String sql = "SELECT  p.*, pd.size, pd.color, pd.description, pd.stock, pimg.img \n"
                + "FROM product p \n"
                + "join productdetail pd on p.productID = pd.productID \n"
                + "join productimg pimg on pd.productID = pimg.productID";
        try {
            con = util.makeConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (check.equals(rs.getString("productID"))) {
                    String productId = rs.getString("productID");
                    productImgDTO pimg = new productImgDTO(rs.getString("img"));
                    productDetailDTO pd = new productDetailDTO(rs.getString("size"), rs.getString("color"), rs.getString("description"), rs.getInt("stock"));
                    productDTO dto = new productDTO(rs.getString("productID"), rs.getString("name"), rs.getDouble("price"), pd, pimg);
                    list.add(dto);
                    check = productId;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public productDTO getOne(String id) throws ClassNotFoundException, SQLException {
        productDTO p = new productDTO();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String sql = "SELECT  p.*, pd.size, pd.color, pd.description, pd.stock, pimg.img FROM product p inner join productdetail pd on p.productID = pd.productID join productimg pimg on pd.productID = pimg.productID \n"
                + "WHERE p.productID = ?";
        try {
            con = util.makeConnection();

            stm = con.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                productImgDTO pimg = new productImgDTO(rs.getString("img"));
                productDetailDTO pd = new productDetailDTO(rs.getString("size"), rs.getString("color"), rs.getString("description"), rs.getInt("stock"));
                p = new productDTO(rs.getString("productID"), rs.getString("name"), rs.getDouble("price"), pd, pimg);
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public boolean checkProductID(String productID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String sql = "SELECT productID FROM product WHERE productID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, productID);
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

    public boolean updateProductStock(String productID, int stock) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "UPDATE productdetail \n"
                        + "SET stock =?\n"
                        + "WHERE productID=?";
                stm = con.prepareStatement(query);
                stm.setInt(1, stock);
                stm.setString(2, productID);
                //so hang bi anh huong
                int affectiveRows = stm.executeUpdate();
                return affectiveRows > 0;
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

    public boolean updateProductPrice(String productID, double price) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "UPDATE product \n"
                        + "SET price =?\n"
                        + "WHERE productID=?\n";
                stm = con.prepareStatement(query);
                stm.setDouble(1, price);
                stm.setString(2, productID);
                //so hang bi anh huong
                int affectiveRows = stm.executeUpdate();
                return affectiveRows > 0;
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

    public boolean updateProduct(String productID, double price, int stock) throws ClassNotFoundException, SQLException {
        updateProductPrice(productID, price);
        updateProductStock(productID, stock);
        return true;
    }

    public boolean uploadProductImg(String ID, String img) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "INSERT INTO productimg VALUES(?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, ID);
                stm.setString(2, img);
                //so hang bi anh huong
                int affectiveRows = stm.executeUpdate();
                return affectiveRows > 0;
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

    public boolean uploadProductDetail(String ID, String size, String color, String des, int stock) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "INSERT INTO productdetail VALUES (?,?,?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, ID);
                stm.setString(2, size);
                stm.setString(3, color);
                stm.setString(4, des);
                stm.setInt(5, stock);
                //so hang bi anh huong
                int affectiveRows = stm.executeUpdate();
                return affectiveRows > 0;
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

    public boolean uploadProduct(String id, String name, double price)
            throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "INSERT INTO product VALUES(?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, id);
                stm.setString(2, name);
                stm.setDouble(3, price);
                //so hang bi anh huong
                int affectiveRows = stm.executeUpdate();
                return affectiveRows > 0;

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

    public boolean upload(String id, String name, double price, String photo, String size, String color, String des, int stock) throws ClassNotFoundException, SQLException {
        uploadProduct(id, name, price);
        uploadProductDetail(id, size, color, des, stock);
        uploadProductImg(id, photo);
        return true;
    }

    public List<productDTO> SearchProduct(String name) throws SQLException, ClassNotFoundException {
        List<productDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String check = "";
        try {
            con = util.makeConnection();
            String sql = "SELECT  p.*, pd.size, pd.color, pd.description, pd.stock, pimg.img \n"
                    + "FROM product p \n"
                    + "JOIN productdetail pd ON p.productID = pd.productID \n"
                    + "JOIN productimg pimg ON pd.productID = pimg.productID "
                    + "WHERE p.name like ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String productId = rs.getString("productID");
                if (check.equals(productId)) {
////                    
                } else {
////                    products.add(new productDTO(productId, name, price, img));
////                    check = productId;
                    productImgDTO pimg = new productImgDTO(rs.getString("img"));
                    productDetailDTO pd = new productDetailDTO(rs.getString("productID"), rs.getString("size"), rs.getString("color"), rs.getString("description"), rs.getInt("stock"));
                    productDTO dto = new productDTO(rs.getString("productID"), rs.getString("name"), rs.getDouble("price"), pd, pimg);
                    list.add(dto);
                    check = productId;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public int countProductSearch(String name) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String check = "";
        int count = 0;
        try {
            con = util.makeConnection();
            String sql = "SELECT p.productID\n"
                    + "FROM product p \n"
                    + "JOIN productdetail pd ON p.productID = pd.productID \n"
                    + "JOIN productimg pimg ON pd.productID = pimg.productID \n"
                    + "WHERE p.name like ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return count;
    }

    public int countProduct() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String check = "";
        int count = 0;
        try {
            con = util.makeConnection();
            String sql = "SELECT p.productID\n"
                    + "FROM product p \n"
                    + "JOIN productdetail pd ON p.productID = pd.productID \n"
                    + "JOIN productimg pimg ON pd.productID = pimg.productID \n";
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                ++count;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return count;
    }
    
     public int getStock(String productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int stock = 0;
        
        try {
            con = util.makeConnection();
            if(con != null){
                String sql = "SELECT stock FROM productdetail WHERE productID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, productId);
                rs = stm.executeQuery();
                if(rs.next()){
                    stock = rs.getInt("stock");
                }
            }
        }finally{
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
        return stock;
    }

}
