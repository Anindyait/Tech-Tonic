<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>  
<head>  
<title>Core Tag Example</title>  
</head>  
<body>  
<% String names = ",Balls,,Ballin,,Hood,,Mamba,";%>
<% String[] array =  names.split("[,]+");
for (int i=1;i<array.length;i++){%>
	<h1>#<% out.println(array[i]); %></h1>
	<% } out.println(array.length);%>  
</body>  
</html>  