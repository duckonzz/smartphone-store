

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <title>Shopping Page</title>
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

            body{
                background-color: #3e3e3f;
            }

            .row{
                margin: 5px 10px;
                display: flex; 
                justify-content: center;

            }

            .col-md-4{
                width: 345.24px;
                margin: 10px;
                background-color: #323232;
                border-radius: 24px;
                padding: 0;
                /*display: flex; flex-direction: column;*/
            }

            img{
                height: 95%; 
            }
            .img{
                background-color: none;
                height: 250px;           
                padding-top: 10px;
            }

            input[type="text"]{
                color: white;
                background: none;
                padding: 5px 20px;
                margin: 10px;
                border: none;
                text-align: center;
                font-size: 1.3rem;
            }
            input[type="submit"], input[type="number"], a{
                margin-bottom: 20px;
                background: #222324;
                color: white;
                border-radius: 8px;
                padding: 10px 20px;
                border: none;
            }
            input[type="number"]{
                width: 70px;    
            }

            input[type="hidden"]{
                display: none;   
            }

            .link{
                display: flex;
                width: 100%;
                justify-content: center;
            }

            a{
                text-decoration: none;
                margin: 0px 10px;
            }
            p{
                text-align: center;
                color: greenyellow;
            }
            .nav {
                background-color:  gray; /* Màu xám */
            }
            .nav-link {
                color: white; /* Màu xám */
            }

        </style>
    </head>
    <body>
        <nav class="navbar">
            <div class="navbar-brand">Welcome ${sessionScope.account.fullname}</div>
            <div class="navbar-icons">

                <form action="DispatchServlet" method="POST">
                    <input type="hidden" name="auth" value="user">
                    <input type="hidden" name="page" value="1">
                    <input type="text" name="txtSearch" value="${sessionScope.SEARCH}" placeholder="Search Product">
                    <input type="submit" name="btAction" value="Search">
                    <a href="DispatchServlet?btAction=Cart"><i class="fa-solid fa-cart-shopping" style="color: white"></i></a>
                </form>

                <c:if test="${sessionScope.account == null}">
                    <a href="DispatchServlet?btAction=LoginPage" style="background: none; margin-top: 5px;"><i class="fas fa-user"></i></a>
                    </c:if>

                <form action="DispatchServlet" method="POST"> 
                    <c:if test="${sessionScope.account != null}">
                        <a href="DispatchServlet?btAction=Update+Profile&username=${sessionScope.account.username}" style="background: none; margin-top: 5px; display: inline-block"><i class="fas fa-user"></i></a>
                        <a href="DispatchServlet?btAction=Logout" style="background: none;"><i class="fa-solid fa-right-from-bracket" style="color: white"></i></a>
                        </c:if>
                </form>

                <form action="DispatchServlet" method="POST">  
                    <c:if test="${sessionScope.LOGIN_USER != null}">
                        <a href="DispatchServlet?btAction=ViewCart"><i class="fas fa-cart-shopping"></i></a>
                        <a href="DispatchServlet?btAction=Logout"><i class="fa-solid fa-right-from-bracket"></i></a>
                        </c:if>
                </form>
            </div>
        </nav>
        <ul class="nav justify-content-center">
            <li class="nav-item">
                <a class="nav-link" href="DispatchServlet?btAction=ProductUser">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="DispatchServlet?btAction=Search&txtSearch=Iphone">Apple</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="DispatchServlet?btAction=Search&txtSearch=SamSung">SamSung</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="DispatchServlet?btAction=Search&txtSearch=OPPO">OPPO</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="DispatchServlet?btAction=Search&txtSearch=Xiaomi">Xiaomi</a>
            </li>
        </ul>            
        <img src="images/background.jpg" style="width: 100%; height: 450px;" alt="Background Image">
        <div class="container text-center">
            <div class="row">
                <c:forEach var="product" items="${requestScope.LIST_PRODUCTS}">
                    <div class="col-md-4">
                        <form action="DispatchServlet" method="post">
                            <div class="img">
                                <input name="image" type="hidden" readonly value="${product.img.img}"> <br>
                                <img src="${product.img.img}">
                            </div>
                            <input name="productName" type="text" style="background-color:#323232;margin-top: 15px;" disabled value="${product.name}"><br>
                            <div class="form-group d-flex" >
                                <input name="price" type="text" disabled style="background-color:#323232" class="form-control mr-1" value="${product.price}">
                                <input style="background-color:red" name="size" type="text" disabled class="form-control" value="${product.detail.size}">
                            </div>
                            <input name="productColor" type="text" style="background-color:green;margin-top: 15px;border-radius: 10px" disabled value="${product.detail.color}"><br>
                            <input name="ProductID" type="hidden" value="${product.productID}"><br>
                            <input name="quantity" type="number" min="1" value="1"><br>
                            <input type="submit" name="btAction" value="Add">
                            <input type="submit" name="btAction" value="ViewMore">
                        </form>
                    </div>                        
                </c:forEach>

                <nav aria-label="Page navigation example" style="display: flex; justify-content: center">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="ProductUserServlet?index=${i-1}"><<</a></li>
                            <c:forEach var="i" begin="1" end="${numberPage}" step="1">                           
                            <li class="page-item"><a class="page-link" href="ProductUserServlet?index=${i}">${i}</a></li>
                            </c:forEach>
                        <li class="page-item"><a class="page-link" href="ProductUserServlet?index=${i+1}">>></a></li>
                    </ul>
                </nav>                    
            </div>
        </div>

        <c:if test="${requestScope.MESSAGE != null}">
            <p>${requestScope.MESSAGE}</p>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/11861eee9a.js" crossorigin="anonymous"></script>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
