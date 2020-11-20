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
        <title>��¼<%=name%>�ı��ܹ�������</title>
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
                    if (isSameDate(String.valueOf(fty.format(dNow)),String.valueOf(rs.getString("entryDate")))) { //����Ŀǰʱ����ͬһ�ܣ�����ʾ������
                        for (int i = 0; i < 5; ++i) {
                            finished[i] = rs.getString("finished" + Integer.toString(i));
                            thisTask[i] = rs.getString("thisTask" + Integer.toString(i));
                            thisDate[i] = rs.getString("thisDate" + Integer.toString(i));
                            summary = rs.getString("summary");
                        }
                        if (rs.next()) { //�ҵ��ڶ������ϣ�Ӧ���������ڵ�����
                            for (int i = 0; i < 5; i++) {
                                prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                                prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
                            }
                        }
                    } else { //����Ŀǰʱ�䲻��ͬһ������...
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
        <caption>��½<Strong><%=name%></strong>�ı��ܹ�����¼</caption>
        <tr>
        <th colspan=2>����Ԥ���������
        <th rowspan=2>�����������
        <th colspan=2>����Ԥ���������
        <th rowspan=2>�ۺ�˵��
        <tr>
        <th>��������<th>Ԥ���������
        <th>��������<th>Ԥ���������
        <% 
            for (int i = 0; i < 5; i++) {
                out.print("<tr>");
                //����Ԥ��������
                out.print("<td>" + (prevTask[i]==null?"":prevTask[i]) + "&nbsp;");
                //�����������ʱ��
                out.print("<td>" + (prevDate[i]==null?"":prevDate[i]) + "&nbsp;");
                //�����������
                out.print("<td><textarea name=\"finished" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + (finished[i]==null?"":finished[i]) + "</textarea>");
                //����Ԥ�����ʱ��
                out.print("<td><textarea name=\"thisTask" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + (thisTask[i]==null?"":thisTask[i]) + "</textarea>");
                //�����������ʱ��
                out.print("<td><textarea name=\"thisDate" + Integer.toString(i) + "\" cols=15 rows=3 wrap=virtual>" + (thisDate[i]==null?"":thisDate[i]) + "</textarea>");
                if (i == 0) {
                    //���������ܽ�
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
        <input type=submit value="�ͳ���">
        <input type=reset  value="�ָ�ԭֵ">
        </h3>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <ol style="text-align: left">
        <li>�������ÿ�������������ǰ��д��ϡ�������������ҹ��ϵͳ�Զ�������һ�ܣ����޷�����д���ܵĽ����ˡ�
        <li>�����ÿһ����Ҫ��д�������ǡ�����Ԥ����������һ��Ҫ������صġ�Ԥ�����ʱ�䡹��
        </ol>
        <hr>
        <div class="center">[<a href="listEachPerson.jsp"><%=name%>�����е�¼����</a>][<a href=index.jsp>���ص�¼����</a>]</div>
    </body>
</html>