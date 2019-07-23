<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%String path = request.getContextPath();
pageContext.setAttribute("PATH",path);
%>
<jsp:forward page="/employee/getAll"></jsp:forward>
<%--<html>
<body>
<h2>Hello World!</h2>
<a href="${PATH}/employee/getAll.do">跳转</a>
</body>
</html>--%>
