<%@ page language="java" import="java.util.*,java.sql.*,java.text.*,java.io.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp" %>

<%! String name = new String();%>

<%  
	name = session.getAttribute("name").toString();
	session.setAttribute("name",name);
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>登录<%=name%>的本周工作进度</title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <%!
        	String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        	String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName = progress";

        	String userName = "sa";
        	String userPwd = "123456";
            
        	Connection dbConn = null;
            Statement sql = null;
            ResultSet rs = null;

            String[] prevTask = new String[5];
            String[] prevDate = new String[5];
            String[] finished = new String[5];
            String[] thisTask = new String[5];
            String[] thisDate = new String[5];
            String summary = new String();
        %>

        <%
            for (int i = 0; i < 5; i++) {
                prevTask[i] = "";
                prevDate[i] = "";
                finished[i] = "";
                thisTask[i] = "";
                thisDate[i] = "";
            }
            summary = "";
            
            try {
            	Class.forName(driverName);
            	dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
            	sql = dbConn.createStatement();
            	rs = sql.executeQuery("select * from work where name='" + name + "' order by entryDate desc");
                
                if (rs.next()) {
                    java.util.Date dNow = new java.util.Date();
                    SimpleDateFormat fty = new SimpleDateFormat("yyyy-MM-dd");
                    if (isSameDate(String.valueOf(fty.format(dNow)),String.valueOf(rs.getString("entryDate")))) { //若和目前时间在同一周，则显示旧资料
                        for (int i = 0; i < 5; ++i) {
                            finished[i] = rs.getString("finished" + Integer.toString(i));
                            thisTask[i] = rs.getString("thisTask" + Integer.toString(i));
                            thisDate[i] = rs.getString("thisDate" + Integer.toString(i));
                            summary = rs.getString("summary");
                        }
                        if (rs.next()) { //找到第二笔资料，应该是上星期的资料
                            for (int i = 0; i < 5; i++) {
                                prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                                prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
                            }
                        }
                    } else { //若和目前时间不在同一个星期...
                        for (int i = 0; i < 5; ++i) {
                            prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                            prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
                        }
                    }
                }
                rs.close();
                sql.close();
                dbConn.close();
            } catch (SQLException se) {   
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (sql != null) sql.close();
                } catch (SQLException se) {
                	se.printStackTrace();
                }
                try {
                    if (dbConn!=null) dbConn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
        <form method=post action="handin.jsp">
        <table border=1 style="margin: 20px auto 10px">
        <caption>登陆<Strong><%=name%></strong>的本周工作记录</caption>
        <tr>
        <th colspan=2>上周预定完成事项
        <th rowspan=2>本周完成事项
        <th colspan=2>下周预定完成事项
        <th rowspan=2>综合说明
        <tr>
        <th>工作描述<th>预定完成日期
        <th>工作描述<th>预定完成日期
        <% 
            for (int i = 0; i < 5; i++) {
                out.print("<tr>");
                //上周预定完事项
                out.print("<td>" + (prevTask[i]==null?"":prevTask[i]) + "&nbsp;");
                //上周任务完成时间
                out.print("<td>" + (prevDate[i]==null?"":prevDate[i]) + "&nbsp;");
                //本周完成任务
                out.print("<td><textarea name=\"finished" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + (finished[i]==null?"":finished[i]) + "</textarea>");
                //下周预定完成时向
                out.print("<td><textarea name=\"thisTask" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + (thisTask[i]==null?"":thisTask[i]) + "</textarea>");
                //本周任务完成时间
                out.print("<td><textarea name=\"thisDate" + Integer.toString(i) + "\" cols=15 rows=3 wrap=virtual>" + (thisDate[i]==null?"":thisDate[i]) + "</textarea>");
                if (i == 0) {
                    //本周任务总结
                    out.print("<td rowspan=5><textarea name=\"summary\" cols=20 rows=18 wrap=virtual>" + (summary==null?"":summary) + "</textarea>");
                }
            } 
        %>
        <%
            for (int i = 0; i < 5; i++) {
                session.setAttribute("prevTask" + Integer.toString(i), (prevTask[i]!=null)?prevTask[i]:"");
                session.setAttribute("prevDate" + Integer.toString(i), (prevDate[i]!=null)?prevDate[i]:"");
            }
        %>
        </table>
        <h3 class="center">
        <input type=submit value="送出表单">
        <input type=reset  value="恢复原值">
        </h3>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <ol style="text-align: left">
        <li>请务必在每星期五下午五点前填写完毕。过了星期六午夜，系统自动跳到下一周，就无法再填写本周的进度了。
        <li>请务必每一栏都要填写，尤其是「本周预定完成事项」，一定要填入相关的「预定完成时间」。
        </ol>
        <hr>
        <div class="center">[<a href="listEachPerson.jsp"><%=name%>的所有登录资料</a>][<a href=index.jsp>返回登录界面</a>]</div>
    </body>
</html>