<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*"%>
<%@ include file="function.jsp"%>

<html>
    <head>
        <meta charset="gb2312">
        <title>MIR 实验室工作进度：每个人的最后一笔资料</title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        [<a class=center href=javascript:history.go(-1)>返回</a>]
        
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
        <caption>MIR 实验室工作进度：每个人的最後一笔资料</caption>
        <tr>
        <th>姓名</th>
        <th>本周完成事项</th>
        <th>下周预定完成事项：<br/>【<span class="red">预定完成日期</span>】工作描述</th>
        <th>综合说明</th>
        <th> 登录日期
        </tr>

        <%!
            String[] students = getMirStudentsName();
            int j = 0;

            String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName = progress";

            String userName = "sa";
            String userPwd = "123456";

            Connection dbConn = null;
            Statement stmt = null;
            ResultSet rs = null;
        %>

        <%
            try {
                
            	Class.forName(driverName);
                dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
            	stmt = dbConn.createStatement();
            	
            	int num = 0;
            	String sql = "SELECT COUNT(DISTINCT name) FROM work";
            	rs = stmt.executeQuery(sql);
            	if(rs.next()){
            		num = rs.getInt(1);
            	}

                for (int row = 0; row < num; ++row) {
                    String name = students[row];
                    sql = "SELECT * FROM work WHERE name = '" + name + "' ORDER BY entryDate DESC";
                    rs = stmt.executeQuery(sql);

                    if (rs.next()) {
                        out.println("<tr>");
                        out.println("<td style=\"background-color: " + color[j] + ";\"><a href=\"listEachPerson.jsp?count="+row+"\">" + name +"</a> </td>");
                        session.setAttribute("name" + row,name);
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintField(rs, "finished", 0) + " &nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintDateTask(rs, "thisDate", "thisTask") + " &nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + (rs.getString("summary")==null?"":rs.getString("summary")) + " &nbsp;</td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + rs.getString("entryDate") + "<br>" + rs.getString("entryTime") + " &nbsp;</td>");
                        out.println("</tr>");
                    } else {
                        out.println("<tr>");
                        out.println("<td style=\"background-color: " + color[j] + ";\"><a href=\"listEachPerson.jsp?count="+row+"\">" + name + "</a> </td>");
                        session.setAttribute("name" + row,name);
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("</tr>");
                    }
                    
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