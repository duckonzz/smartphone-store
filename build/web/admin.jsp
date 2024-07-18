<%-- 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .navbar {
                background-color: black;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 5px 60px;
            }

            .navbar-brand {
                font-size: 24px;
                font-weight: bold;
                color: white;
            }

            .navbar-icons {
                display: flex;
                gap: 10px;
                font-size: 20px;
                color: white
            }

            .navbar-icons i {
                cursor: pointer;
            }

            .form{
                margin-top: 20px;
            }

            .search{
                display: flex;
                flex-direction: column;
                margin: 0 auto;
            }

            .form{
                display: flex;
                justify-content: center;
            }

            .form input[type="submit"]{
                padding: 10px 20px;
                border-radius: 20px;
                align-items: center;
                background-color: rgba(71, 113, 149, 0.8);
                margin: 0 20px 30px 10px;
            }

            .form input[type="text"]{
                padding: 10px 20px;
                border: 1px solid #ccc;
                border-radius: 20px;
            }

            th{
                color: white;
                background-color: rgb(90, 91, 91);
            }

            th, td{
                text-align: center;
                padding: 15px;
            }

            td{

                border-bottom: 1px solid rgb(185, 184, 184);
            }

            input{
                text-align: center;
                border: none;
            }

            .link a{
                text-decoration: none;
                margin: 10px;
                background: #222324;
                color: white;
                border-radius: 8px;
                padding: 5px 12px;
                border: none;
            }

            .link{
                display: flex;
                width: 100%;
                justify-content: center;
            }

            img{
                width: 70px;
                height: auto;
            }
            .items {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 10px;
            }

            .left {
                display: flex;
                align-items: center;
            }

            .left img {
                width: 70px;
                height: auto;
                margin: 5px;
                border-radius: 10px;
            }

            .right {
                display: flex;
                align-items: center;
            }

            .left p, .right p{
                margin: 0 10px;
            }

            .items input{
                background: none;
                border: none;
            }

            .right input[type="text"] {
                width: 30px;
            }

            .right input[type="submit"] {
                border: none;
                cursor: pointer;
            }
            .uploadForm {
                max-width: 400px;
                margin: 0 auto;
            }

            .uploadForm input[type="text"],
            .uploadForm input[type="file"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .uploadForm input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                display: flex;
                justify-content: center;
            }

            .uploadForm input[type="submit"]:hover {
                background-color: #45a049;
            }

            .uploadForm hr {
                border: none;
                height: 1px;
                background-color: black;
                margin: 10px 0;
            }

            .uploadForm p {
                color: red;
            }           
            /*            body {
                            font-family: 'Eczar', serif;
                            background-color: whitesmoke ;
            
                        }*/
            * {
                box-sizing: border-box;
            }

            /* Button used to open the contact form - fixed at the bottom of the page */
            .open-button {
                background-color: white;
                color: black;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                opacity: 0.8;
                bottom: 23px;
                right: 28px;
            }

            /* The popup form - hidden by default */
            .form-popup {
                display: block;
                /*                position: fixed;*/
                margin-left: 20%;
                margin-right: 20%; 
                /*width: 50%;*/
                border: 3px solid #f1f1f1;
                /*                background-color: whitesmoke ;*/

            }

            /* Add styles to the form container */
            .form-container {
                max-width: 100%;
                padding: 10px;
                background-color: white;
                border: 1px solid gray;
                border-radius: 12px;
            }

            /* Full-width input fields */
            .form-container input[type=text], .form-container input[type=password] {
                width: 100%;
                padding: 10px;
                border: none;
                background: #f1f1f1;
            }

            /* When the inputs get focus, do something */
            .form-container input[type=text]:focus, .form-container input[type=password]:focus {
                background-color: white;
                outline: none;
            }

            /* Set a style for the submit/login button */
            .form-container .btn {
                background-color: #003333;
                color: white;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                width: 100%;
                margin-bottom:10px;
                margin-top: 10px;
                opacity: 0.8;
            }

            /* Add a red background color to the cancel button */
            .form-container .cancel {
                background-color: black;
            }

            /* Add some hover effects to buttons */
            .form-container .btn:hover, .open-button:hover {
                opacity: 1;

            }
            input{
                border-radius: 5px;

            }
        </style>
    </head>
    <body>
        <nav class="navbar">
            <div class="navbar-brand">Welcome ${sessionScope.account.fullname}</div>
            <div class="navbar-icons">
                <a href="DispatchServlet?btAction=Logout"><i class="fa-solid fa-right-from-bracket"></i></a>
            </div>
        </nav>

        <div class="display">
            <div class="search">
                <div class="form">
                    <form action="DispatchServlet">    
                        <c:if test="${requestScope.AccountList!= null}">
                            <input type="text" name="txtSearchUser" value="${sessionScope.LastSearchAccount}" placeholder="Search User">                       
                            <input type="submit" name="btAction" value="Search User">
                        </c:if>
                        <c:if test="${requestScope.ProductList!= null}">
                            <input type="text" name="txtSearchProduct" value="${sessionScope.LastSearchProduct}" placeholder="Search Product">                       
                            <input type="submit" name="btAction" value="Search Product">
                        </c:if>
                        <c:if test="${requestScope.OrderList!= null}">
                            <input type="text" name="txtSearchOrder" placeholder="Search Order">                       
                            <input type="submit" name="btAction" value="Search Order">
                        </c:if>

                        <input type="submit" name="btAction" value="Account">
                        <input type="submit" name="btAction" value="Product">
                        <input type="submit" name="btAction" value="ViewOrder">
                        <input type="submit" name="btAction" value="Upload">
                    </form>                  
                </div>

                <c:if test="${requestScope.AccountList!= null}">
                    <table>
                        <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Full Name</th>
                                <th>Mail</th>
                                <th>Password</th>
                                <th>Delete</th>
                            </tr>
                        </thead>                 
                        <tbody>     
                            <c:forEach var="account" items="${requestScope.AccountList}">
                            <form action="DispatchServlet">
                                <tr>                      
                                    <td>
                                        <input type="text" name="txtUserName" value="${account.username}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtFullName" value="${account.fullname}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtEmail" value="${account.mail}" readonly=""/>
                                    </td>
                                    <td>${account.password}</td>
                                    <td>
                                        <a href="DispatchServlet?btAction=Delete&username=${account.username}">Delete</a>
                                    </td>                                   
                                </tr>
                            </form>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${requestScope.ProductList != null}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Size</th>
                                <th>Color</th>
                                <th>Description</th>
                                <th>Stock</th>
                                <th>Update</th>
                            </tr>
                        </thead>

                        <tbody>     
                            <c:forEach var="product" items="${requestScope.ProductList}">
                            <form action="DispatchServlet" method="get">
                                <tr>                      
                                    <td>
                                        ${product.productID}
                                    </td>
                                    <td>
                                        ${product.name}
                                    </td>
                                    <td>
                                        <img src="${product.img.img}">         
                                    </td>
                                    <td>
                                        ${product.price}
                                    </td>
                                    <td>
                                        ${product.detail.size}
                                    </td>
                                    <td>
                                        ${product.detail.color}
                                    </td>
                                    <td>
                                        ${product.detail.description}
                                    </td>
                                    <td>
                                        ${product.detail.stock}
                                    </td>
                                    <td>
                                        <a href="DispatchServlet?btAction=Update&productID=${product.productID}">Update</a>
                                    </td>                                   
                                </tr>
                            </form>                                  
                        </c:forEach>
                        </tbody>
                    </table>
                    <nav aria-label="Page navigation example" style="display: flex; justify-content: center">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="#"><<</a></li>
                                <c:forEach var="i" begin="1" end="${numberPage}" step="1">                           
                                <li class="page-item"><a class="page-link" href="ProductAdminServlet?index=${i}">${i}</a></li>
                                </c:forEach>
                            <li class="page-item"><a class="page-link" href="#">>></a></li>
                        </ul>
                    </nav>
                </c:if>

                <c:if test="${requestScope.OrderList!= null}">
                    <table>
                        <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Phone</th>
                                <th>Address</th>               
                                <th>Date</th>
                                <th>Total</th>
                                <th>Status</th>                                               
                            </tr>
                        </thead>                 
                        <tbody>     
                            <c:forEach var="order" items="${requestScope.OrderList}">
                            <form action="DispatchServlet">
                                <tr>                      
                                    <td>
                                        <input type="text" name="txtUserName" value="${order.username}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtPhone" value="${order.phone}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtAddress" value="${order.address}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtDate" value="${order.date}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtTotal" value="${order.total}" readonly=""/>
                                    </td>
                                    <td>
                                        <input type="text" name="txtStatus" value="${order.status}" readonly=""/>
                                    </td>                                    
                                </tr>
                            </form>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
            
            <c:if test="${requestScope.UPDATE!= null}">  
                <div class="form-popup" id="updateForm">
                    <form action="DispatchServlet" method="post" class="form-container" it>
                        <h1 style="text-align: center">Update Product</h1>

                        <h5 style="margin: 5px">Product ID</h5> 
                        <input type="text"  name="txtProductID" readonly="" value="${UPDATE.productID}">

                        <h5 style="margin: 5px">Name</h5>
                        <input type="text"  name="txtName" readonly="" value="${UPDATE.name}">

                        <h5 style="margin: 5px">Size</h5> 
                        <input type="text" name="txtSize" readonly="" value="${UPDATE.detail.size}">

                        <h5 style="margin: 5px">Color</h5> 
                        <input type="text" name="txtColor" readonly="" value="${UPDATE.detail.color}">

                        <h5 style="margin: 5px">Image</h5>
                        <div class="product-images">
                            <img src="${requestScope.IMAGE1}" alt="Main Image">                         
                            <img src="${requestScope.IMAGE2}" alt="Thumbnail Image 1">
                            <img src="${requestScope.IMAGE3}" alt="Thumbnail Image 2">
                            <img src="${requestScope.IMAGE4}" alt="Thumbnail Image 3">
                        </div>

                        <h5 style="margin: 5px;">Price</h5>
                        <input type="number" placeholder="Enter Price" name="txtPrice" required value="${UPDATE.price}" min="0">

                        <h5 style="margin: 5px">Stock</h5> 
                        <input type="number" placeholder="Enter Price" name="txtStock" required value="${UPDATE.detail.stock}" min="0">

                        <h5 style="margin: 5px">Description</h5>
                        <input type="text"  name="txtDescription" required value='${UPDATE.detail.description}'>

                        <button type="submit" name="btAction" value="Update" class="btn">Update</button>
                        <button type="button" class="btn cancel"><a href="DispatchServlet?btAction=Product" style="text-decoration: none; color: white">Back</a></button>
                    </form>
                </div>
            </c:if>

            <c:if test="${requestScope.UPLOAD != null}">               
                <div class="form-popup" id="updateForm">
                    <form action="UploadProductServlet" method="post" enctype="multipart/form-data" class="form-container" it>
                        <h1 style="text-align: center">Upload Product</h1>

                        <h5 style="margin: 5px">ID</h5> 
                        <input type="text"  name="txtProductID" required="">
                        
                        <p style="color: red;">${sessionScope.ERROR}</p>
                        
                            

                        <h5 style="margin: 5px">Name</h5>
                        <input type="text"  name="txtName" required="">

                        <h5 style="margin: 5px">Size</h5> 
                        <input type="text" name="txtSize" required="">

                        <h5 style="margin: 5px">Color</h5> 
                        <input type="text" name="txtColor" required="">

                        <h5 style="margin: 5px">Image</h5>
                        <input type="file" style="border-radius:0" placeholder="Product Image" name="proImg" > 

                        <h5 style="margin: 5px">Price</h5>
                        <input type="number" placeholder="Enter Price" name="txtPrice" required="" min="1">

                        <h5 style="margin: 5px">Stock</h5> 
                        <input type="number" placeholder="Enter Price" name="txtStock" required="" min="1">

                        <h5 style="margin: 5px">Description</h5>
                        <input type="text" name="txtDescription" required="">

                        <button type="submit" name="btAction" value="Upload" class="btn" >Upload</button>
                        <button type="button"class="btn cancel" ><a style="text-decoration: none; color: white" href="DispatchServlet?btAction=Product">Back</a></button>
                    </form>
                    </div>
                </c:if>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://kit.fontawesome.com/11861eee9a.js" crossorigin="anonymous"></script>
    </body>
</html>