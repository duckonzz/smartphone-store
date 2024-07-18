<%-- 
--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Product Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
        <style>
            input[type="hidden"]{
                display: none;   
            }
            .nav {
                background-color:  gray; /* Màu xám */
            }
            .nav-link {
                color: white; /* Màu xám */
            }
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }
            .text{
                margin-top: 2%;
                font-family: Arial, Helvetica, sans-serif;
            }
            .detail{
                display: flex;
                justify-content: space-between;
                padding: 10px;
            }
            .container {
                display: flex;
                justify-content: space-between;
                padding: 5px;
                width: 60%;

            }
            .product-images {
                flex: 1;
                padding-right: 20px;
                width: 50%;
            }
            .product-details {
                flex: 1;
                padding: 20px;
                margin: 30px auto;
                width: 50%;
                border: 20px solid #f1f1f1;
                width: 40%;
                display: block;
                margin: 50px auto;
                width: 50%;
                border: 3px solid #f1f1f1;
            }

            input{
                border-radius: 15px;
                width: 90%
            }
            p{
                margin-left: 200px;
                margin-right: 200px;
            }

            .main-image {
                width: 600px;
                height: 400px;
                margin-bottom: 20px;
            }
            .thumbnail-images {
                width: 60%;

            }
            .thumbnail-images img {
                width: 30%;
                height: 200px;


            }
            .product-info {
                margin-bottom: 20px;
                margin-top: 10px;
                text-align: center;
                size: 16;
                padding: 10px;
                border-radius:0;
            }

            .add-to-cart {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
            }
            .add-to-cart:hover {
                background-color: #0056b3;
            }
            .form-container .btn {
                background-color: #003333;
                color: white;
                padding: 14px;
                border: 5px;
                cursor: pointer;
                width: 30%;
                margin-top: 20px;
                opacity: 0.8;
                margin-left: 160px;

            }

            .form-container .btn:hover, .open-button:hover {
                opacity: 1; 
            }
            .bt-add {
                background-color: #4CAF50;
                border: none;
                color: white;
                padding: 15px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 5px;
            }  

        </style>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <h2 class="text" style="text-align: center">Detail Product</h2>
            <!-- Product Detail -->
        <c:set var="stopLoop" value="true" />
        <c:forEach var="product" items="${requestScope.LIST_PRODUCTS}">

            <c:if test="${stopLoop}">

                <div class="detail">
                    <div class="container">
                        <div class="product-images">
                            <img class="main-image" src="${requestScope.LIST_IMAGE1}" alt="Main Image">
                            <div class="thumbnail-images">
                                
                                <c:if test="${requestScope.LIST_IMAGE2 != null}"><img src="${requestScope.LIST_IMAGE2}" alt="Thumbnail Image 1"></c:if>
                                <c:if test="${requestScope.LIST_IMAGE3 != null}"><img src="${requestScope.LIST_IMAGE3}" alt="Thumbnail Image 2"></c:if>
                                <c:if test="${requestScope.LIST_IMAGE4 != null}"><img src="${requestScope.LIST_IMAGE4}" alt="Thumbnail Image 3"></c:if>
                                </div>


                            </div>
                        </div>
                        <div class="product-details">
                            <form action="DispatchServlet">
                                <h1 style="text-align: center">Product Detail</h1>

                                <input type="hidden"  name="ProductID"  required value="${product.productID}">

                            <h4 style="margin: 3px">Product Name</h4>
                            <input type="text"  name="txtProductName" disabled required value="${product.name}">

                            <h4 style="margin: 3px">Size</h4>
                            <input type="text"  name="txtSize" disabled required value="${product.detail.size}">

                            <h4 style="margin: 3px">Color</h4>
                            <input type="text"  name="txtColor" disabled required value="${product.detail.color}">

                            <h4 style="margin: 3px">Price</h4>
                            <input type="number"  name="txtPrice" disabled required value="${product.price}">

                            <h4 style="margin: 3px">Quantity</h4>
                            <input type="number"  name="quantity"  min="1" value="${param.quantity}">
                            <c:if test="${not empty param.quantity}">
                                <c:set var="test" value="${param.quantity}"/>
                            </c:if>

                            <br>
                            <button class="bt-add" type="submit" value="Add" name="btAction"> 
                                Add to cart
                            </button>
                        </form>
                    </div>
                </div>
                <div class="product-info">
                    <h3>Description:</h3>
                    <p style="padding: 10px">
                        <c:set var="description" value="${fn:replace(product.detail.description, ';', '<br/>')}" />
                        ${description}
                    </p>
                </div>
            </c:if>     
            <c:set var="stopLoop" value="false" />

        </c:forEach>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>