<%@ page import="java.sql.Connection" %>
<%@ page import="com.ajax.common.DBManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	DBManager dbManager = new DBManager();

	String type = request.getParameter("type");

	if (type == null && type.length() == 0) {
		LinkedHashMap<String, Object> resp = new LinkedHashMap<String, Object>();
		resp.put("resp", "fail");
		resp.put("desc", "no_type");
		return;
	}

	//  주석 테스트
	Connection conn = dbManager.getConnection();

	PreparedStatement ps = null;
	ResultSet rs = null;

	StringBuilder sql = new StringBuilder();

	if (type.equals("insert")) {
		new StringBuilder();
		sql.append(" INSERT INTO user (name) VALUE (?) ");

		String name = request.getParameter("name");
		if (name != null && name.length() > 0) {} else {
			name = "no_name";
		}

		int result = 0;
		int genkey = 0;
		try {
			ps = conn.prepareStatement(sql.toString(), PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setString(1, name);
			result = ps.executeUpdate();
			if (result > 0) {
				rs = ps.getGeneratedKeys();
				if (rs.next()) {
					genkey = rs.getInt(1);
				}
				LinkedHashMap<String, Object> resp = new LinkedHashMap<String, Object>();
				resp.put("resp", "ok");
				resp.put("genkey", genkey);
				out.print(JSONValue.toJSONString(resp));
				return;
			} else {
				LinkedHashMap<String, Object> resp = new LinkedHashMap<String, Object>();
				resp.put("resp", "fail");
				resp.put("desc", "insert_fail");
				out.print(JSONValue.toJSONString(resp));
				return;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}


	} else if (type.equals("select")) {
		new StringBuilder();
		sql.append(" SELECT id_user, name FROM user ");

		LinkedList<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		HashMap<String , Object> map = new HashMap<String , Object>();
		try {
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			while (rs.next()) {
				map = new HashMap<String , Object>();
				map.put("id_user", rs.getInt("id_user"));
				map.put("name", rs.getString("name"));
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LinkedHashMap<String, Object> resp = new LinkedHashMap<String, Object>();
		resp.put("resp", "ok");
		resp.put("list", list);
		out.print(JSONValue.toJSONString(resp));
		return;

	}

	try {
		if (rs != null) {rs.close();}
		if (ps != null) {ps.close();}
		conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}

	LinkedHashMap<String, Object> resp = new LinkedHashMap<String, Object>();
	resp.put("resp", "ok");
	resp.put("desc", "error");
	out.print(JSONValue.toJSONString(resp));
%>
