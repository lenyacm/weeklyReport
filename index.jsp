<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
    
<head>
    <meta charset="gb2312">
    <title>MIR ʵ���ҹ������ȵ�¼��ҳ</title>
    <style type="text/css">
        body {text-align:center;}
        h2 {text-align:center;}
        table {margin:auto; border-collapse: collapse;}
    </style>
</head>
<body>
    <h2>MIR ʵ���ҵ�¼</h2>
    <form name="login" action="login.jsp" method=POST>
        <table>
            <tr>
                <td>����: </td>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <td>����: </td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                <input type="submit" name="Submit" value="�ύ">
                <input type="reset" name="Reset" value="����">
                </td>
            </tr>
        </table>
        <div style="text-align: right;">
            <a href="register.jsp">�˺�ע��</a>
        </div>
    </form>
</body>