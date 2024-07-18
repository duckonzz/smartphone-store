/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import product.productDAO;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)

public class UploadProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
//        String url = "admin.jsp";
//         finally {
//            out.close();
//        }
    }

    //            productDetailDTO pd = new productDetailDTO(size, color, des, stock);
    //            productImgDTO pm = new productImgDTO(fileName);
    //            productDTO p = new productDTO(productID, name, price, pd, pm);
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("UPLOAD", 1);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "";
        try {
            HttpSession session = request.getSession();
            productDAO dao = new productDAO();

            String productID = request.getParameter("txtProductID");

            if (!dao.checkProductID(productID)) {
                String productName = request.getParameter("txtName");
                String productSize = request.getParameter("txtSize");
                String productColor = request.getParameter("txtColor");
//                String imageName = "";
                double price = Double.parseDouble(request.getParameter("txtPrice"));
                int stock = Integer.parseInt(request.getParameter("txtStock"));
                String des = request.getParameter("txtDescription");
                Part part = request.getPart("proImg");
                String realPath = request.getServletContext().getRealPath("/images");
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
//                    if (imageName == null) {
//                        imageName = new File(part.getSubmittedFileName()).getName();
//                    }

                if (!Files.exists(Paths.get(realPath))) {
                    Files.createDirectory(Paths.get(realPath));
                }

                String path = realPath + "/" + fileName;

                part.write(path);

                String image = "images/" + fileName;

                boolean check = dao.upload(productID, productName, price, image, productSize, productColor, des, stock);
                if (check) {
                    url = "ProductAdminServlet";
                }
            } else {
                url = "admin.jsp";
                request.setAttribute("UPLOAD", 1);
//        request.getRequestDispatcher("admin.jsp").forward(request, response);
                session.setAttribute("ERROR", "This productID already existed!");
            }
//            } else {
//                request.setAttribute("UPLOAD", 1);

            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            log("Error at UploadProductServlet: " + e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
