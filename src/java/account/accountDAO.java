/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import product.productDTO;
import product.productDetailDTO;
import product.productImgDTO;
import util.util;

public class accountDAO {

    public accountDTO checkLogin(String username, String password) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            String query = "SELECT * FROM account WHERE username=? AND password=?";
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if (rs.next()) {
                accountDTO account = new accountDTO(rs.getString("username"), rs.getString("password"), rs.getString("mail"), rs.getString("fullname"), rs.getInt("roleID"));
                return account;
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
    
    public boolean isExistemail(String mail) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "SELECT * FROM account WHERE mail=?";
                stm = con.prepareStatement(query);
                stm.setString(1, mail);
                rs = stm.executeQuery();
                return rs.next();
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
    
    

    public boolean signUp(accountDTO t) throws SQLException {
        boolean isSuccess = false;
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            String sql = "INSERT INTO [account] ([username], [fullname], [mail], [password], [roleID]) VALUES (?,?,?,?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, t.getUsername());
            stm.setString(2, t.getFullname());
            stm.setString(3, t.getMail());
            stm.setString(4, t.getPassword());
            stm.setInt(5, t.getRoleID());
            stm.executeUpdate();
            isSuccess = true;
        } catch (Exception e) {
            isSuccess = false;
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return isSuccess;
    }

    public List<accountDTO> getAllUser() {
        List<accountDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            String query = "SELECT * FROM account WHERE roleID = 0";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                String username = rs.getString("username");
                String fullname = rs.getString("fullname");
                String mail = rs.getString("mail");
                String password = rs.getString("password");
                list.add(new accountDTO(username, password, mail, fullname));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public accountDTO getOneUser(String searchUserName) throws ClassNotFoundException, SQLException {
        accountDTO acc = new accountDTO();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM account WHERE roleID = 0 AND username like ?";
        try {
            con = util.makeConnection();

            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + searchUserName + "%");
            rs = stm.executeQuery();
            if (rs.next()) {
                String username = rs.getString("username");
                String fullname = rs.getString("fullname");
                String mail = rs.getString("mail");
                String password = rs.getString("password");
                acc = new accountDTO(username, password, mail, fullname, 0);
                return acc;
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

    public boolean deleteAccount(String username) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "DELETE FROM account WHERE username=?";
                stm = con.prepareStatement(query);
                stm.setString(1, username);
                int affectedRows = stm.executeUpdate();
                return affectedRows > 0;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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

    public List<accountDTO> SearchUserByFullName(String fullname) throws SQLException, ClassNotFoundException {
        List<accountDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            String sql = "SELECT * FROM account WHERE fullname like ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + fullname + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                accountDTO dto = new accountDTO(rs.getString("username"), rs.getString("password"), rs.getString("mail"), rs.getString("fullname"));
                list.add(dto);
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

    public boolean UpdateAccount(String username, String fullname, String mail, String password) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "UPDATE account SET fullname=?,mail=?,password=? \n"
                        + "WHERE username=?";
                stm = con.prepareStatement(query);
                stm.setString(1, fullname);
                stm.setString(2, mail);
                stm.setString(3, password);
                stm.setString(4, username);
                int affectedRows = stm.executeUpdate();
                return affectedRows > 0;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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

    public boolean isExist(String username) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = util.makeConnection();
            if (con != null) {
                String query = "SELECT * FROM account WHERE username=?";
                stm = con.prepareStatement(query);
                stm.setString(1, username);
                rs = stm.executeQuery();
                return rs.next();
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
    

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        accountDAO dao = new accountDAO();
//        System.out.println();
//        List<accountDTO> list = dao.SearchUserByFullName("minh");
//        for (accountDTO t : list) {
//            System.out.println(t.toString());
//        }
//            accountDTO dto = dao.checkLogin("admin", "1234");
//            System.out.println(dto);
//        
//        for (accountDTO t : list){
//            System.out.println(t.toString());
//        accountDTO dto = new accountDTO("user3", "123", "user3@gmail.com", "DangTo", 0);
//        dao.signUp(dto);
//        
 
            List<accountDTO> a = dao.SearchUserByFullName("");
            for(accountDTO s : a){
                System.out.println(s);
            }

    }
}
