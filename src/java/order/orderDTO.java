/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package order;

import account.accountDTO;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class orderDTO {

    private String username;
    private Date date;
    private double total;
    private String phone;
    private String address;
    private String status;
    private orderDetailDTO detail;

    public orderDTO(String username, Date date, double total, String phone, String address, String status) {
        this.username = username;
        this.date = date;
        this.total = total;
        this.phone = phone;
        this.address = address;
        this.status = status;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public orderDetailDTO getDetail() {
        return detail;
    }

    public void setDetail(orderDetailDTO detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return "orderDTO{" + "username=" + username + ", date=" + date + ", total=" + total + ", phone=" + phone + ", address=" + address + ", status=" + status + ", detail=" + detail + '}';
    }
}
