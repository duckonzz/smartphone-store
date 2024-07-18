<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                background-image: url("img/bg-login.jpg");
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
            }

            /* Login form styles */
            .login {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 350px;
                padding: 25px;
                background-color: rgba(255, 255, 255, 0.5);
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            }

            .login h1 {
                text-align: center;
                margin-bottom: 20px;
            }

            .info, info i{
                display: flex;
                align-items: center;
            }

            .login input[type="text"],
            .login input[type="password"] {
                width: 90%;
                padding: 10px;
                margin: 0 0px 10px 20px;
                border: none;
                background-color: rgba(255, 255, 255, 0);
                border-bottom: 1px solid rgb(123, 122, 122);
            }

            .login input[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #4caf50;
                color: #fff;
                font-size: 18px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }

            .loginGG {
                display: block;
                text-align: center;
                background-color: #dd4b39;
                color: white;
                padding: 10px;
                border-radius: 4px;
                text-decoration: none;
                margin-top: 10px;
                font-size: 18px;
            }

            .link a {
                text-align: center;
                margin: 10px 0;
                color: #373737;
                text-decoration: none;
                font-size: 0.9em;
            } 

            .link{
                display: flex;
                justify-content: space-between;
            }

            .id{
                display: flex;
            }

            .g-recaptcha{
                justify-content: center;
                display: flex;
            }

            .errorRecaptcha, p{
                color: red;
                justify-content: center;
                display: flex;
            }
        </style>
    </head>
    <body>
        <div class="login">
            <h1>Login</h1>
            <form action="DispatchServlet" method="POST">
                <div class="info">
                    <i class="fa fa-user"></i>
                    <input type="text" name="txtUserName" placeholder="User Name"/></br>
                </div>
                <div class="info">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="txtPassword" placeholder="Password"></br>
                </div>      
                    <h3 style="color: red">${sessionScope.Message}</h3>
                <input type="submit" name="btAction" value="Login"/>
                <input style="background: red" type="submit" name="btAction" value="Sign Up">
            </form>                   
        </div>      
        <script src="https://kit.fontawesome.com/11861eee9a.js" crossorigin="anonymous"></script>        
    </body>
</html>
