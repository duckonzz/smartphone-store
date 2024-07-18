/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package order;

import product.productDTO;

/**
 *
 * @author Admin
 */
public class orderDetailDTO {

    private String productID;
    private int orderID;
    private int quantity;
    private double price;

    public orderDetailDTO() {
    }

    public orderDetailDTO(String productID, int quantity, double price) {
        this.productID = productID;
        this.quantity = quantity;
        this.price = price;
    }

    public orderDetailDTO(String productID, int orderID, int quantity, double price) {
        this.productID = productID;
        this.orderID = orderID;
        this.quantity = quantity;
        this.price = price;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

}
