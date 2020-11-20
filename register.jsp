<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312" %>

<html>
    <head>
        <meta charset="gb2312">
        <title>账号注册</title>
        <style type="text/css">
            h2 {text-align: center;}
        </style>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <h2>账号注册</h2>
        <form name="user_info" action="register_result.jsp" method=POST>
            <table>
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" name="password1"></td>
                </tr>
                <tr>
                    <td>再次输入密码：</td>
                    <td><input type="password" name="password2"></td>
                </tr>
            </table>
            <div class=center>
                <input type="submit" value="提交">
                <input type="reset" value="重置">
            </div>
        </form>
    </body>
</html>
