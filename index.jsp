<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
    
<head>
    <meta charset="gb2312">
    <title>MIR 实验室工作进度登录网页</title>
    <style type="text/css">
        body {text-align:center;}
        h2 {text-align:center;}
        table {margin:auto; border-collapse: collapse;}
    </style>
</head>
<body>
    <h2>MIR 实验室登录</h2>
    <form name="login" action="login.jsp" method=POST>
        <table>
            <tr>
                <td>姓名: </td>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <td>密码: </td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                <input type="submit" name="Submit" value="提交">
                <input type="reset" name="Reset" value="重置">
                </td>
            </tr>
        </table>
        <div style="text-align: right;">
            <a href="register.jsp">账号注册</a>
        </div>
    </form>
</body>