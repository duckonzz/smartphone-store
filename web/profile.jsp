<%-- 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Info</title>
        <style>
            .container {
                width: 50%;
                margin: 0 auto;
                margin-top: 50px;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #ccc; /* Container background color */
            }

            h1 {
                text-align: center;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                background-color: white;
                color: black; 
            }

            input[type="text"]:read-only {
                /*                background-color: red;*/
                color: black;
            }

            input[type="submit"],
            input[type="button"] {
                margin-top: 20px;
                padding: 11px 20px;
                border: none;
                border-radius: 4px;
                background-color: #007bff; /* Button background color */
                color: white; /* Button text color */
                cursor: pointer;
            }

            input[type="submit"]:hover,
            input[type="button"]:hover {
                background-color: #0056b3; /* Hover background color */
            }

            body {
                background-color: #323232; /* Body background color */
                color: black; /* Body text color */
            }

            .button {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

        </style>

    </head>
    <body>
        <div class="container">
            <h1>User Information</h1>         
            <form action="DispatchServlet" method="post">
                User Name:<input type="text" name="txtUserName" readonly value="${sessionScope.account.username}"><br>
                Full Name:<input type="text" name="txtFullName" value="${sessionScope.account.fullname}"><br>
                Email :<input type="text" name="txtEmail" value="${sessionScope.account.mail}"><br>
                Password :<input type="password" name="txtPassword" value="${sessionScope.account.password}"><br>

                <div style="text-align: center">
                    <input type="submit" name="btAction" value="Update Profile">
                    <a href="DispatchServlet?btAction=ProductUser"  class="button">Back To Home</a>
                </div>

                <h1 style="color: green">${requestScope.MESSAGE}</h1>
            </form>

        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>