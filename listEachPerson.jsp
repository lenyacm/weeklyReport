<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*"%>
<%@ include file="function.jsp" %>

<%!
	String count = null;
    String name = new String();
    String title = new String();
%>

<%
	try{
		count = new String(request.getParameter("count").toString().getBytes("ISO-8859-1"), "gbk");
    	name = session.getAttribute("name"+count).toString();
	}catch(NullPointerException se){
		name = session.getAttribute("name").toString();
	}
    title = "MIR 实验室工作进度：" + name + "的全部登录资料";
%>

<html>
    <head>
        <meta charset="gb2312">
        <title><%=title%></title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <%-- <center>[<a href=index.jsp>回到主选单</a>]</center> --%>
        <%
            out.println("[<a href=form.jsp class=\"center\">回到本周工作进度</a>]");
        %>

        <%!
            String[] color = new String[9];
        %>

        <%
            color[0] = "#ffffdd";
            color[1] = "#ffeeee";
            color[2] = "#eeffee";
            color[3] = "#e0e0f9";
            color[4] = "#eeeeff";
            color[5] = "#ffe9d0";
            color[6] = "#ffffdd";
            color[7] = "#eeeeff";
            color[8] = "#e0e0f9";
        %>

        <p>
        <table>
        <caption><strong><%=name%>的所有登录资料</strong></caption>
        <tr>
        <th>姓名
        <th>本周完成事项
        <th>下周预定完成事项：<br>【<span class="red">预定完成日期</span>】工作描述
        <th>综合说明
        <th> 登录日期

        <%
        	String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
       	 	String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName = progress";

        	String userName = "sa";
        	String userPwd = "123456";

        	Connection dbConn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName(driverName);
                dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
            	stmt = dbConn.createStatement();
            	
            	String sql = "SELECT * FROM work WHERE name = '" + name + "' ORDER BY entryDate DESC";
            	rs = stmt.executeQuery(sql);

                int j = 0;
                while (rs.next()) { //do while?
                        out.println("<tr>");
                        out.println("<td style=\"background-color: " + color[j] + ";\"><strong><b>" + name + "</b></strong> </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintField(rs, "finished", 0) + "&nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintDateTask(rs, "thisDate", "thisTask") + "&nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + (rs.getString("summary")==null?"":rs.getString("summary")) + "&nbsp;</td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + rs.getString("entryDate") + "<br>" + new String(rs.getString("entryTime").getBytes("ISO-8859-1"), "gbk") + "&nbsp;</td>");
                    j += 1;
                    if (j == color.length) {
                        j = 0;
                    }
                }

                rs.close();
                stmt.close();
                dbConn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (stmt != null) stmt.close();
                } catch (SQLException se2) {
                }
                try {
                    if (dbConn != null) dbConn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
        </table>
    </body>
</html>