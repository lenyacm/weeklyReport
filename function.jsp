<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="javax.servlet.http.HttpSession,java.io.*,java.util.*,java.text.*,java.sql.*"%>

<%!
    String getDate() {
		java.util.Date dNow = new java.util.Date();
        SimpleDateFormat fmd = new SimpleDateFormat("yyyy-MM-dd");
        return fmd.format(dNow);
    }
%>

<%!
    String getTime() {
		java.util.Date dNow = new java.util.Date();
        SimpleDateFormat fmt = new SimpleDateFormat("HH:mm:ss");
        return fmt.format(dNow);
    }
%>

<%!
    boolean checkPassword(String name, String password) {//У���û�������

        String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		// ����JDBC����
		String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=member";
		// ���ӷ����������ݿ�
		String userName = "sa"; // Ĭ���û���
		String userPwd = "123456"; // ����
		Connection dbConn = null;
		try {
			Class.forName(driverName);
			dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		Statement sql;
		ResultSet rs;
		try {
			sql = dbConn.createStatement();
			rs = sql.executeQuery("SELECT* FROM members");
			while (rs.next()) {
				if(rs.getString("name").equals(name)&&rs.getString("password").equals(password)){ 
					return true;
				}
			}
			dbConn.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
        return false;
    }
%>

<%!
	boolean isSameDate(String date1, String date2) {//�ж��Ƿ�ͬһ��
	
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date d1 = null;
		java.util.Date d2 = null;
		try {
			d1 = format.parse(date1);
			d2 = format.parse(date2);
		}
		catch (Exception e) {
		e.printStackTrace();
		}
		java.util.Calendar cal1 = java.util.Calendar.getInstance();
		java.util.Calendar cal2 = java.util.Calendar.getInstance();
		cal1.setFirstDayOfWeek(java.util.Calendar.MONDAY);//��������Ϊһ�ܵĵ�һ�죬�۵ý���һ��Ϊһ�ܵ�һ��
		cal2.setFirstDayOfWeek(java.util.Calendar.MONDAY);
		cal1.setTime(d1);
		cal2.setTime(d2);
		int subYear = cal1.get(java.util.Calendar.YEAR) - cal2.get(java.util.Calendar.YEAR);
		if (subYear == 0){// subYear==0,˵����ͬһ��
			if (cal1.get(java.util.Calendar.WEEK_OF_YEAR) == cal2.get(java.util.Calendar.WEEK_OF_YEAR))
				return true;
		}
		else if (subYear == 1 && cal2.get(java.util.Calendar.MONTH) == 11){ //subYear==1,˵��cal��cal2��һ��;java��һ����"0"��ʶ����ô12����"11"
   			if (cal1.get(java.util.Calendar.WEEK_OF_YEAR) == cal2.get(java.util.Calendar.WEEK_OF_YEAR))
				return true;
		}
		else if (subYear == -1 && cal1.get(java.util.Calendar.MONTH) == 11){//subYear==-1,˵��cal��cal2Сһ��
			if (cal1.get(java.util.Calendar.WEEK_OF_YEAR) == cal2.get(java.util.Calendar.WEEK_OF_YEAR))
				return true;
		}
		return false;
	}
 %>

<%!
    boolean judgeExists(String name) {//����û����ѷ����
        String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		// ����JDBC����
		String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=member";
		// ���ӷ����������ݿ�
		String userName = "sa"; // Ĭ���û���
		String userPwd = "123456"; // ����
		Connection dbConn = null;
		try {
			Class.forName(driverName);
			dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		Statement sql;
		ResultSet rs;
		try {
			sql = dbConn.createStatement();
			rs = sql.executeQuery("SELECT* FROM members");
			while (rs.next()) {
				if(rs.getString("name").equals(name)){ 
					return true;
				}
			}
			dbConn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
        return false;
    }
%>

<%!
    boolean addUser(String name, String password) {//������û�
        String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		// ����JDBC����
		String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=member";
		// ���ӷ����������ݿ�
		String userName = "sa"; // Ĭ���û���
		String userPwd = "123456"; // ����
		Connection dbConn = null;
		try {
			Class.forName(driverName);
			dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		Statement sql;
		try {
			sql = dbConn.createStatement();
			sql.execute("INSERT INTO members (name, password) VALUES ('" + name +"', '" + password +"')");
			dbConn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
        return true;
    }
%>

<%!
    String[] getMirStudentsName() {
        String[] students = new String[128];

        String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName = member";

        String userName = "sa";
        String userPwd = "123456";

        Connection dbConn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {

        	Class.forName(driverName);
        	dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
        	stmt = dbConn.createStatement();

            String sql = "SELECT * FROM members";
            rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {
                students[i++] = rs.getString("name");
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
        return students;
    }
%>

<%!
    String PrintField(ResultSet rs, String field, int editable) {
        String result = new String();
        try {
            result += "<ol>\n";
            for (int i = 0; i < 5; ++i) {
                if (editable == 0) {
                    if (rs.getString(field + Integer.toString(i)).length()!=0) {
                        result += "<li>" + rs.getString(field + Integer.toString(i)) + "\n";
                    }
                } else {
                    result += "<li><textarea name=\n";
                    result += field + Integer.toString(i) + "\n";
                    result += " cols=30 rows=2 wrap=virtual>\n";
                    result += rs.getString(field + Integer.toString(i)) + "\n";
                    result += "</textarea></li>\n";
                }
            }
            result += "</ol>";
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>

<%!
    String PrintDateTask(ResultSet rs, String dateField, String taskField) {
        String result = new String();
        try {
            result += "<ol>\n";
            for (int i = 0; i < 5; i++) {
                if (rs.getString(taskField + Integer.toString(i)).length()!=0) {
                    result += "<li>��<span style=\"color: red;\">" + rs.getString(dateField + Integer.toString(i)) + "</span>��" + rs.getString(taskField + Integer.toString(i)) + "\n";
                }
            }
            result += "</ol>\n";
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>

<%!
    String PrintSession(HttpSession session, String dateField, String taskField) {
        String result = new String();
        try {
            result += "<ol>\n";
            for (int i = 0; i < 5; i++) {
                if (!session.getAttribute(taskField + Integer.toString(i)).equals("")) {
                    result += "<li>��<span class=\"red\">" + session.getAttribute(dateField + Integer.toString(i)) + "</span>��" + session.getAttribute(taskField + Integer.toString(i)) + "\n";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>

