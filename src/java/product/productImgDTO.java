/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

public class productImgDTO {

    private String ID;
    private String img;

    public productImgDTO(String img) {
        this.img = img;
    }
    
    public productImgDTO(String ID, String img) {
        this.ID = ID;
        this.img = img;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

}
