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
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript" src="${path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${path}/static/jquery/jquery-1.12.4.min.js" />
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
                <table class="table table-hover">
                    <th>ID</th>
                    <th>员工姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所属部门</th>
                    <th>操作</th>

                </table>
            </div>
        </div>

    </div>
    <%--分页--%>
    <div class="row">
        <div class="col-md-offset-3 col-md-4">
            <p align="center"> 当前页码：总共页数：每页行数：总记录数：
                连续显示页数：</p>
        </div>
        <br>

    </div>
</div>
<script type="text/javascript" >
    $(function () {
        $.ajax({
            URL:"${path}/employee/showAll",
            data:"pn=2",
            type:"GET",
            success:function (result) {
                console.log(result);
                console.log("asdfasf");

            }
        });
    });
</script>
</body>
</html>
