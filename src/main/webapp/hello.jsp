<%--
  Created by IntelliJ IDEA.
  @auther: 唐智科
  @computerName: tzk
  Date: 19-7-21
  Time: 下午6:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%String path = request.getContextPath();
    pageContext.setAttribute("path",path);
%>
<html>
<head>
    <title>员工信息表</title>

</head>
<body>
<a href="${path}/employee/login">skip</a>
</body>
</html>
