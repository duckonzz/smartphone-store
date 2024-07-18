/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package account;

import java.sql.SQLException;
import javax.naming.NamingException;

public class accountErrors {

    private String usernamelengtherror;
    private String fullnamelengtherror;
    private String passwordlengtherror;
    private String confirmnotmatcherror;
    private String usernameexistederror;
    private String mailexistederror;
    

    public boolean checkUserNameLength(String username) {
        if (username.trim().length() < 3 || username.trim().length() > 20) {
            usernamelengtherror = "User Name must be between 6-20 chars!";
            return false;
        }
        return true;
    }

    public boolean checkPasswordLength(String password) {
        if (password.trim().length() < 3 || password.trim().length() > 20) {
            passwordlengtherror = "Password must be between 4-20 chars!";
            return false;
        }
        return true;
    }

    public boolean checkFullNameLength(String fullname) {
        if (fullname.trim().length() < 4 || fullname.trim().length() > 40) {
            fullnamelengtherror = "Full Name must be between 2-40 chars!";
            return false;
        }
        return true;
    }

    public boolean checkConfirm(String password, String confirm) {
        if (!password.trim().equals(confirm.trim())) {
            confirmnotmatcherror = "Password and Confirm must be matched!";
            return false;
        }
        return true;
    }

    public boolean checkUserAccountExisted(String username) throws SQLException, ClassNotFoundException, NamingException {
        accountDAO dao = new accountDAO();
        boolean result = dao.isExist(username);
        if(result){
            usernameexistederror = "User Name was already existed!";
        }
        return !result;
    }
    
    public boolean checkEmail(String email) throws SQLException, ClassNotFoundException, NamingException {
        accountDAO dao = new accountDAO();
        boolean result = dao.isExistemail(email);
        if(result){
            mailexistederror = "Email already exists!";
        }
        return !result;
    }

    public String getMailexistederror() {
        return mailexistederror;
    }

    public void setMailexistederror(String mailexistederror) {
        this.mailexistederror = mailexistederror;
    }
    
    

    public String getUsernamelengtherror() {
        return usernamelengtherror;
    }

    public void setUsernamelengtherror(String usernamelengtherror) {
        this.usernamelengtherror = usernamelengtherror;
    }

    public String getFullnamelengtherror() {
        return fullnamelengtherror;
    }

    public void setFullnamelengtherror(String fullnamelengtherror) {
        this.fullnamelengtherror = fullnamelengtherror;
    }

    public String getPasswordlengtherror() {
        return passwordlengtherror;
    }

    public void setPasswordlengtherror(String passwordlengtherror) {
        this.passwordlengtherror = passwordlengtherror;
    }

    public String getConfirmnotmatcherror() {
        return confirmnotmatcherror;
    }

    public void setConfirmnotmatcherror(String confirmnotmatcherror) {
        this.confirmnotmatcherror = confirmnotmatcherror;
    }

    public String getUsernameexistederror() {
        return usernameexistederror;
    }

    public void setUsernameexistederror(String usernameexistederror) {
        this.usernameexistederror = usernameexistederror;
    }

}
