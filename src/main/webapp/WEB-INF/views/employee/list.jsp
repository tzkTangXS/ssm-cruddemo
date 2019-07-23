<%--
  Created by IntelliJ IDEA.
  @auther: 唐智科
  @computerName: tzk
  Date: 19-7-22
  Time: 下午11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title>员工信息表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=path%>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path%>/static/jquery/jquery-1.12.4.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
        <h1>CRUD</h1>
        </div>
    </div>
        <%--按钮--%>
    <div class="row">
       <div class="col-md-4 col-md-offset-8">
           <button type="button" class="btn btn-primary">新增</button>
           <button type="button" class="btn btn-danger">删除</button>
       </div>
    </div>
        <%--列表--%>
    <div class="row">
        <div class="col-md-8 col-md-offset-3 col-xs-8">
            <div class="table-responsive">
            <table class="table table-hover center-block">
                <th>ID</th>
                <th>员工姓名</th>
                <th>性别</th>
                <th>邮箱</th>
                <th>所属部门</th>
                <th>操作</th>
                <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                    <td>${emp.empId}</td>
                    <td>${emp.empName}</td>
                    <td>${emp.gender=="M"?"男":"女"}</td>
                    <td>${emp.email}</td>
                    <td>${emp.department.deptName}</td>
                    <td>
                        <button type="button" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-pencil"></span>编辑</button>
                        <button type="button" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span>删除</button>
                    </td>
                </tr>
                </c:forEach>
            </table>
            </div>
        </div>

    </div>
        <%--分页--%>
    <div class="row">
        <div class="col-md-offset-3 col-md-4">
           <p align="center"> 当前页码：${pageInfo.pageNum}总共页数：${pageInfo.pages}每页行数：${pageInfo.pageSize}总记录数：${pageInfo.total}
            连续显示页数：${pageInfo.navigatePages}</p>
        </div>
        <br>
        <div class="col-md-offset-4 col-md-12"><nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="<%=path%>/employee/getAll">首页</a></li>
                <c:if test="${pageInfo.isFirstPage}">
                <li class="disabled">
                    <a href="" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                </c:if>
                <c:if test="${pageInfo.hasPreviousPage}">
                    <li >
                        <a href="<%=path%>/employee/getAll?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach items="${pageInfo.navigatepageNums}" var="p">
                    <c:if test="${p != pageInfo.pageNum}">
                        <li><a href="<%=path%>/employee/getAll?pn=${p}">${p}</a></li>
                    </c:if>
                    <c:if test="${p == pageInfo.pageNum}">
                    <li class="active"><a href="<%=path%>/employee/getAll?pn=${p}">${p}</a></li>
                    </c:if>
                </c:forEach>
                <c:if test="${pageInfo.isLastPage}">
                <li class="disabled">
                    <a href="" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                </c:if>
                <c:if test="${pageInfo.hasNextPage}">
                <li>
                    <a href="<%=path%>/employee/getAll?pn=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                </c:if>
                <li><a href="<%=path%>/employee/getAll?pn=${pageInfo.pages}">尾页</a></li>
            </ul>
        </nav></div>
    </div>
</div>
</body>
</html>
