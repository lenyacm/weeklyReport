<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.util.Date,java.sql.*,java.text.*"%>
<%@ include file="function.jsp"%>

<html>

<%!
    String name = null;
    String title = new String();
%>

<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
	session.setAttribute("name",name);
    title = name + "工作进度登记表";
%>

<head>
<meta charset="gb2312">
<title><%=title%></title>
<link rel="stylesheet" type="text/css" href="type.css">
</head>
<body>

<%!
    int insertNewData=1;

    String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName = progress";

    String userName = "sa";
    String userPwd = "123456";

    Connection dbConn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String date;
%>

<%
    try {
        Class.forName(driverName);
        dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
    	stmt = dbConn.createStatement();

        String sql = "SELECT * FROM work WHERE name = '" + name + "'ORDER BY entryDate DESC";
        rs = stmt.executeQuery(sql);

        java.util.Date dNow = new java.util.Date();
        SimpleDateFormat fty = new SimpleDateFormat("yyyy-MM-dd");

        if (rs.next()) {
            if (isSameDate(String.valueOf(fty.format(dNow)),String.valueOf(rs.getString("entryDate")))) {
            	date = String.valueOf(rs.getString("entryDate"));
                insertNewData = 0;
            }else{
            	insertNewData = 1;
            }
        }else{
        	insertNewData = 1;
        }

        if (insertNewData == 1) {
            //插入新资料
            sql = "INSERT INTO work (name, entryDate, entryTime, summary, ";
            sql += "finished0, finished1, finished2, finished3, finished4, ";
            sql += "thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, ";
            sql += "thisDate0, thisDate1, thisDate2, thisDate3, thisDate4)  VALUES('";
            sql += name + "', '";
            sql += getDate() + "', '" + getTime() + "', '";
            sql += new String(request.getParameter("summary").getBytes("ISO-8859-1"), "gbk") + "', '";
            sql += new String(request.getParameter("finished0").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished1").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished2").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished3").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished4").toString().getBytes("ISO-8859-1"), "gbk") + "', '";
            sql += new String(request.getParameter("thisTask0").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask1").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask2").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask3").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask4").toString().getBytes("ISO-8859-1"), "gbk") + "', '";
            sql += new String(request.getParameter("thisDate0").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate1").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate2").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate3").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate4").toString().getBytes("ISO-8859-1"), "gbk") + "')";
        } else {
            //更新资料
            sql = "UPDATE work SET ";
            sql += "finished0='" + new String(request.getParameter("finished0").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished1='" + new String(request.getParameter("finished1").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished2='" + new String(request.getParameter("finished2").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished3='" + new String(request.getParameter("finished3").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished4='" + new String(request.getParameter("finished4").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask0='" + new String(request.getParameter("thisTask0").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask1='" + new String(request.getParameter("thisTask1").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask2='" + new String(request.getParameter("thisTask2").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask3='" + new String(request.getParameter("thisTask3").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask4='" + new String(request.getParameter("thisTask4").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate0='" + new String(request.getParameter("thisDate0").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate1='" + new String(request.getParameter("thisDate1").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate2='" + new String(request.getParameter("thisDate2").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate3='" + new String(request.getParameter("thisDate3").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate4='" + new String(request.getParameter("thisDate4").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "entryDate='" + getDate() + "', ";
            sql += "entryTime='" + getTime() + "', ";
            sql += "summary='" + new String(request.getParameter("summary").toString().getBytes("ISO-8859-1"), "gbk") + "' ";
            sql += "WHERE entryDate = '" + date + "'";
        }
        stmt.execute(sql);
        sql = "SELECT * FROM work WHERE name = '" + name +"' ORDER BY entryDate DESC";
        rs = stmt.executeQuery(sql);

        if (!rs.next()) {
            throw new Exception("Rs contents nothing!");
        }

        out.println("<h2><strong>" + name + "</strong>的工作登记表</h2>");

        out.println("<hr>");
        out.println("<table align=center border=1>");
        out.println("亲爱的 <font color=green>"+ name + "</font>，您输入的资料如下。若有错误，可回<a href=\"javascript:history.go(-1)\">前页</a>修改。");
        out.println("<tr>");
        out.println("<th>上周预定完成事项：<br>【<span class=\"red\">预定完成日期</span>】工作描述");
        out.println("<th>本周完成事项");
        out.println("<th>下周预定完成事项：<br>【<span class=\"red\">预定完成日期</span>】工作描述");
        out.println("<th>综合说明");
        out.println("<th>登录日期");
        out.println("<tr>");
        out.println("<td>" + PrintSession(session, "prevDate", "prevTask") + " &nbsp; </td>");
        out.println("<td>" + PrintField(rs, "finished", 0) + " &nbsp;</td>");
        out.println("<td>" + PrintDateTask(rs, "thisDate", "thisTask") + " &nbsp; </td>");
        out.println("<td>" + rs.getString("summary").toString() + " &nbsp;</td>");
        out.println("<td>" + rs.getString("entryDate").toString() + "<br>" + rs.getString("entryTime").toString() + " &nbsp;</td>");
        out.println("</table>");

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

<hr>
<div class="center">
[<a href="listEachPerson.jsp"><strong style="color:green"><%=name%></strong>登录之全部资料</a>]
[<a href="listLastRecord.jsp">每位同学的最後一笔资料</a>]
</div>

</body>
</html>