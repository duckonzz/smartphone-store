<%-- 
--%>

<%@page import="order.orderDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <title>Cart Page</title>
        <style>
            .wrapper{
                background-color: #3e3e3f;
            }

            .container{
                padding: 14px 0;
                background-color: #3e3e3f;
            }

            .row{
                padding: 20px;
                background-color: #eee;
                border: 1px solid ;
                border-radius: 5px;
            }

            .cart{
                background-color: #eee;
            }

            .link{
                width: 96%;
                margin: 20px;
                display: flex;
                justify-content: space-between;
            }

            .link a{
                color: black;
                font-size: 20px;
                font-weight: bold; 
            }

            .items {
                display: flex;
                justify-content: space-between;
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

            .right input[type="number"] {
                text-align: center;
            }

            .right input[type="submit"] {
                border: none;
                cursor: pointer;
            }


            .checkout{
                border-radius: 10px;
                box-sizing: border-box;
                background-color: #323232;
                height: 90vh;
            }

            .tittle{
                color: white;
                margin: 20px;
            }

            .tittle h4{
                margin-top: 40px;
            }

            .tittle h6{
                margin: 20px 0;
            }

            .checkout input{
                width: 93%;
                margin: 15px;
                padding: 10px;
                border-radius: 10px;
            }

            .address{
                display: flex;
            }

            .total{
                margin: 25px;
                display: flex;
                color: white;
                justify-content: space-between;
            }

            .checkout input[type="submit"]{
                font-weight: bold;
                font-size: 1.5rem;
            }

            p{
                text-align: center;
            }

            h{
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

        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="container">
                <div class="row">
                    <div class="col-md-7 cart">
                        <div class="link">
                            <a style="background-color:#eee" href="DispatchServlet?btAction=Shopping">Continue Shopping</a>                           
                        </div>
                        <hr>
                        <c:set var="total" value="0"></c:set>
                        <c:set var="count" value="0"></c:set>
                        <c:if test="${sessionScope.CART != null}">
                            <c:forEach var="product" varStatus="counter" items="${sessionScope.CART}">
                                <form action="DispatchServlet" method="POST">
                                    <div class="items">
                                        <div class="left">

                                            <img src="${product.productImg}">

                                            <input type="hidden" name="productID" value="${product.productID}" />

                                            <p>${product.productName}</p>
                                        </div>
                                        <div class="right">
                                            <input type="number" min="1" name="quantity" value="${product.quantity}" />
                                            <input type="hidden" name="total" value="${product.quantity * product.price}" />
                                            <input type="hidden" name="price" value="${product.price}" />
                                            <input type="number" disabled="" name="show total" value="${product.price*product.quantity}" />
                                            <input type="submit" name="btAction" value="Edit" />
                                            <input type="submit" name="btAction" value="Remove" />
                                        </div>
                                    </div>
                                </form>
                                <c:set var="total" value="${total+(product.quantity * product.price)}"></c:set>
                                <c:set var="count" value="${counter.count}"></c:set>
                            </c:forEach>
                            <hr>
                            <c:if test="${count >0}">
                                <p>You have ${count} items in your cart</p>
                            </c:if>
                            <hr>
                        </c:if>

                        <c:if test="${not empty sessionScope.LIST_ORDERS}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Order's Date</th>
                                        <th>Total</th>
                                        <th>Address</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <c:forEach var="order" items="${sessionScope.LIST_ORDERS}">
                                    <tbody> 

                                    <form action="DispatchServlet" method="POST">
                                        <td>${order.date}</td>
                                        <td>${order.total}</td>
                                        <td>${order.address}</td>
                                        <td>${order.status}</td>
                                    </form>
                                    </tbody>
                                </c:forEach>

                            </table>
                        </c:if>

                        <c:if test="${count == 0 }">
                            <p>Your cart is empty.</p>
                        </c:if>

                        <c:if test="${requestScope.MESSAGE != null }">
                            <p style="color: green;">${requestScope.MESSAGE}</p>
                        </c:if>

                    </div>
                    <div class="col-md-5 checkout">
                        <div class="tittle">
                            <h4>Order Detail</h4>
                            <h6>Delivery Address</h6>
                        </div>
                        <form action="DispatchServlet" method="POST">
                            <input type="text" name="fullName" value="${sessionScope.account.fullname}">
                            <input type="text" name="phone" required="" placeholder="Phone">

                            <div class="address">
                                <input type="text" name="city" required="" placeholder="City">
                                <input type="text" name="district" required="" placeholder="District">
                            </div>
                            <input type="text" name="address" required="" placeholder="Address">
                            <div class="total">
                                <h4>Total</h4>
                                <h4>${total}</h4>
                            </div>
                            <input type="hidden" name="username" value="${sessionScope.account.username}">
                            <input type="submit" name="btAction" value="Checkout">
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <script src="https://kit.fontawesome.com/11861eee9a.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
