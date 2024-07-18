/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

/**
 *
 * @author Admin
 */
public class productDTO{

    private String productID;
    private String name;
    private double price;
    private productDetailDTO detail;
    private productImgDTO img;

    public productDTO() {
    }
    
    public productDTO(String productID, String name, double price, productDetailDTO detail, productImgDTO img) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.detail = detail;
        this.img = img;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public productDetailDTO getDetail() {
        return detail;
    }

    public void setDetail(productDetailDTO detail) {
        this.detail = detail;
    }

    public productImgDTO getImg() {
        return img;
    }

    public void setImg(productImgDTO img) {
        this.img = img;
    }

    @Override
    public String toString() {
        return "productDTO{" + "productID=" + productID + ", name=" + name + ", price=" + price + ", detail=" + detail + ", img=" + img + '}';
    }
}
