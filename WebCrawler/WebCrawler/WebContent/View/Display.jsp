<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.*" %>
      <%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Traversed Links</title>
<link rel="stylesheet" href="css/jquery.treeview.css" />
	<link rel="stylesheet" href="css/screen.css" />
	
	<script src="js/jquery.js" type="text/javascript"></script>
	<script src="js/jquery.cookie.js" type="text/javascript"></script>
	<script src="js/jquery.treeview.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="js/demo.js"></script>

</head>
<body>
<% 
Connection con = null;

Statement stmt = null;
try {	

	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_crawler","root","dreemaindia");
	stmt = con.createStatement();

	if(!con.isClosed())
		System.out.println("Successfully Connected!!!");
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (InstantiationException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (IllegalAccessException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
	String url=request.getParameter("url");
	String keyword=request.getParameter("keyword");

	PreparedStatement ps=null;
	PreparedStatement ps1=null;
	PreparedStatement ps2=null;
	PreparedStatement ps3=null;
	PreparedStatement ps4=null;
	PreparedStatement ps5=null;
	PreparedStatement ps6=null;
	int rowcount;
	int start_id=0;
	int parent_id;
	String site=null;
	int url_id=0;
	boolean isContain=false;

	ps=con.prepareStatement("select start_id from crawl_inspector where url=? and keyword=? ");
	ps.setString(1, url);
	ps.setString(2, keyword);
	
	ResultSet rs= ps.executeQuery();
	while(rs.next()){
		start_id=rs.getInt(1);
		ps1=con.prepareStatement("select url_id,url,isContain from crawl_manager where start_id=? and depth=?");
		ps1.setInt(1,start_id);
		ps1.setInt(2,0);
		ResultSet rs1=ps1.executeQuery();
		while(rs1.next()){
			url_id=rs1.getInt(1);
			site=rs1.getString(2);
			isContain=rs1.getBoolean(3);
		}
	}
	
%>
<div id="main">

<ul id="navigation">

<%if (isContain){ %>
		<li><b><a href="<%=url %>" style=" color: red" ><span> <% out.println(url); %></a></b></span>
		<%} else {%>
		
		<li><a href="<%=url %>" ><span> <% out.println(url); %></a></span>
		<%} %>
<ul>
	<%
	ps2=con.prepareStatement("select url_id,url,isContain from crawl_manager where parent_id=?");
	ps2.setInt(1, url_id);
	ResultSet rs2=ps2.executeQuery(); 
	while(rs2.next()){ 
		url_id=rs2.getInt(1);
		url=rs2.getString(2);
		isContain=rs2.getBoolean(3);
		%>
		<%if (isContain){ %>
		<li><b><a href="<%=url %>" style=" color: red" ><span> <% out.println(url); %></a></b></span>
		<%} else {%>
		
		<li><a href="<%=url %>" ><span> <% out.println(url); %></a></span>
		<%} %>
		<ul>
			
		<%   ps3=con.prepareStatement("select url_id,url,isContain from crawl_manager where parent_id=?");
		ps3.setInt(1, url_id);
		ResultSet rs3=ps3.executeQuery(); 
		while(rs3.next()){ 
			url_id=rs3.getInt(1);
			url=rs3.getString(2);
			isContain=rs3.getBoolean(3); %>
			<%if (isContain){ %>
		<li><b><a href="<%=url %>" style=" color: red" ><span> <% out.println(url); %></a></b></span>
		<%}
			else{%>
		
		<li><a href="<%=url %>"> <span> <% out.println(url);    %> </a></span> 
		<%} %>
		<ul>
		<%
			
		 ps4=con.prepareStatement("select url_id,url,isContain from crawl_manager where parent_id=?");
		ps4.setInt(1, url_id);
		ResultSet rs4=ps4.executeQuery(); 
		while(rs4.next()){ 
		    
			url=rs4.getString(2);
			isContain=rs4.getBoolean(3); %>
			<%if (isContain){ %>
		<li><b><a href="<%=url %>" style=" color: red" ><span> <% out.println(url); %></a></b></span>
		<%} 
		else{ %>
		
		<li> <a href="<%=url %>"><span> <% out.println(url);    %></a></span> </li>	
		<%} %>
		<%} %>
		</ul>
	</li>
		<% } %>
		
		</ul>
		</li>
		<% } %>
		</ul></li></ul></div>
<% 
    ps5=con.prepareStatement("delete from crawl_manager where start_id=? ");
	ps5.setInt(1, start_id);
	ps5.executeUpdate();
	
%>
</body>
</html>