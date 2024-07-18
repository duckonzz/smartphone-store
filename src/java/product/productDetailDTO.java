/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

public class productDetailDTO {

    private String ID;
    private String size;
    private String color;
    private String description;
    private int stock;

    public productDetailDTO() {
    }

    public productDetailDTO(String size, String color, String description, int stock) {
        this.size = size;
        this.color = color;
        this.description = description;
        this.stock = stock;
    }

    public productDetailDTO(String ID, String size, String color, String description, int stock) {
        this.ID = ID;
        this.size = size;
        this.color = color;
        this.description = description;
        this.stock = stock;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

}
