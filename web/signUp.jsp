<%-- 
--%>

<%@page import="account.accountErrors"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Mail Page</title>
        <style>
            body {
                background-color: yellow;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-image: url("img/bg-signup.jpg");
            }

            .signup {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 350px;
                height: 450px;
                padding: 20px;
                border-radius: 10px;
            }

            h1{
                text-align: center;
                color: white;
            }
            input {
                padding: 5px 20px;
                margin: 5px;
                width: 90%;
                height: 30px;
                margin: 5px 0;
                border: none;
                border-radius: 20px;
                background-color: rgba(255, 255, 255, 0.4);
                color: white;
            }

            input[type="submit"]{
                margin-top: 20px;
                height: 45px;
                width: 100%;
                align-items: center;
                background-color: rgba(71, 113, 149, 0.8);
            }
            ::placeholder { 
                color: white;
            }
            p{
                color: #dd4b39;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%
            accountErrors errors = (accountErrors) request.getAttribute("ERROR");
            String userNameLengthError = null;
            String passwordLengthError = null;
            String fullnameLengthError = null;
            String userNameExistedError = null;
            String confirmNotMatchError = null;
            String mailexistederror = null;
            if (errors != null) {
                userNameLengthError = errors.getUsernamelengtherror();
                passwordLengthError = errors.getPasswordlengtherror();
                fullnameLengthError = errors.getFullnamelengtherror();
                userNameExistedError = errors.getUsernameexistederror();
                confirmNotMatchError = errors.getConfirmnotmatcherror();
                mailexistederror = errors.getMailexistederror();
            }
        %>
        <form action="DispatchServlet" method="post">
            <div class="signup">
                <h1>Sign Up</h1>

                <input type="text" name="txtFullName" value="${param.txtFullName}" placeholder="Full Name" >
                <%
                    if (fullnameLengthError != null) {
                %>
                <font color="red"><%=fullnameLengthError%></font>
                <%}%>
                </br>

                <input type="text" name="txtUserName" value="${param.txtUserName}"  placeholder="User Name" >
                <%
                    if (userNameLengthError != null) {
                %>
                <font color="red"><%=userNameLengthError%></font><br>
                <%}%>

                <%
                    if (userNameExistedError != null) {
                %>
                <font color="red"><%=userNameExistedError%></font>
                <%}%>
                </br>

                <input type="text" name="txtMail" placeholder="Email" value="${param.txtMail}">
                <%
                    if (mailexistederror != null) {
                %>
                <font color="red"><%=mailexistederror%></font>
                <%}%>
                </br>
                
                <input type="password" name="txtPassword" placeholder="Password" >
                <%
                    if (passwordLengthError != null) {
                %>
                <font color="red"><%=passwordLengthError%></font>
                <%}%>
                </br>
                <input type="password" name="confirmPassword" placeholder="Repeat your password">
                <%
                    if (confirmNotMatchError != null) {
                %>
                <font color="red"><%=confirmNotMatchError%></font>
                <%}%>
                </br>               
                <input type="submit" name="btAction" value="SignUp"/>            
            </div>
        </form>
    </body>
</html>