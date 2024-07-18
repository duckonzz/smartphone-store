/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package account;

public class accountDTO {

    private String username;
    private String password;
    private String mail;
    private String fullname;
    private int roleID;

    public accountDTO() {
    }

    public accountDTO(String username, String password, String mail, String fullname, int roleID) {
        this.username = username;
        this.password = password;
        this.mail = mail;
        this.fullname = fullname;
        this.roleID = roleID;
    }

    public accountDTO(String username, String password, String mail, String fullname) {
        this.username = username;
        this.password = password;
        this.mail = mail;
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public boolean isAdmin(int RoleID) {
        if (RoleID == 1) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public String toString() {
        return "accountDTO{" + "username=" + username + ", password=" + password + ", mail=" + mail + ", fullname=" + fullname + ", roleID=" + roleID + '}';
    }
    
}
