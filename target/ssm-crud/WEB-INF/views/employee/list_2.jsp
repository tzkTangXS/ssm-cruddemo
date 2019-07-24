<%--
  Created by IntelliJ IDEA.
  @auther: 唐智科
  @computerName: tzk
  Date: 19-7-23
  Time: 下午1:39
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
</head>
<body>
<script src="${path}/static/js/jquery-1.12.4.min.js"></script>
<script src="${path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
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
            <button id="bt_add" type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
            
        </div>
    </div>
        <!-- ===========Modal模态框=========== -->
        <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    </div>

                    <div class="modal-body">
                       <%--==========放表单===========--%>
                           <form class="form-horizontal">
                               <div class="form-group">
                                   <label for="empName_add" class="col-sm-2 control-label">员工姓名</label>
                                   <div class="col-sm-10">
                                       <input type="text" name="empName" class="form-control" id="empName_add" placeholder="张三">
                                       <span  class="help-block"></span>
                                   </div>
                               </div>
                               <div class="form-group">
                                   <label for="email_add" class="col-sm-2 control-label">邮&emsp;箱</label>
                                   <div class="col-sm-10">
                                       <input type="text" name="email" class="form-control" id="email_add" placeholder="23421341@qq.com">
                                       <span  class="help-block"></span>
                                   </div>
                               </div>
                               <div class="form-group">
                                   <div class="col-sm-offset-2 col-sm-8">
                                   <label class="radio-inline">
                                       <input type="radio" name="gender" id="genderM_add" value="M"> 男
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio" name="gender" id="genderF_add" value="F" checked="checked"> 女
                                   </label>
                                   </div>
                               </div>
                                <%--===============下拉列表==================--%>
                             <div class="form-group">
                                 <label class="col-sm-2 control-label">所属部门</label>
                                 <div class=" col-sm-8">

                                     <select id="dept_add" class="form-control" name="deptId">

                                     </select>
                                 </div>
                             </div>
                    </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="emp_save_bt">Save changes</button>
                    </div>

                    <%--=========表单结束=============--%>
                </div>
            </div>
        </div>
    <%--列表--%>
    <div class="row">
        <div class="col-md-7 col-md-offset-2 col-xs-12">
            <div class="table-responsive">
                <table id="table"  class="table table-hover">
                    <thead>
                    <th>ID</th>
                    <th>员工姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所属部门</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <%--===========员工信息===========--%>

                    </tbody>

                </table>
            </div>
        </div>

    </div>
    <%--==============分页===================--%>
    <div class="row">
        <div  id="page_info" class="col-md-offset-2 col-md-4">

            <%--=======页数相关信息=======--%>

        </div>
        <br>
        <div id="page_nav" class="col-md-offset-7 col-md-4">
            <%--<nav aria-label="Page navigation">
                <ul  class="pagination">
                    <li>
                        <a href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li>
                        <a href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>--%>
        </div>
    </div>
</div>

<script type="text/javascript" >
    var maxPageBigger;
    $(function () {
        skip_page(1);
    });

    function skip_page(pn) {
        $.ajax({
            url:"${path}/employee/showAll",
            data:"pn="+pn,
            type:"GET",
            success:function (msg) {
                //console.log(msg);
                /*
                * 1.解析并显示员工性息
                * 2.解析并显示分页性息
                * */
                build_table(msg);
                build_page_info(msg);
                build_page_nav(msg);
            }
        });
    }

    /*=============================================创建表格=============================================*/
    function build_table(msg) {
        /*========构建表格之前清空表格=========*/
        $("#table tbody").empty();
        var list = msg.data.pageInfo.list;
        $.each(list,function (index,item) {
            // alert(item.empName);
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd=$("<td></td>").append(item.email);

            if (item.deptId != null){
            var deptNameTd=$("<td></td>").append(item.department.deptName);
            }else {
                var deptNameTd=$("<td></td>");
            }
            /*=======操作======*/
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(empIdTd,empNameTd,genderTd,emailTd,deptNameTd)
                .append(btnTd)
                .appendTo("#table tbody");
        });
    }
    /*=============================================页码信息=============================================*/
    function build_page_info(msg) {
        $("#page_info").empty();
        $("#page_info").append("当前页码："+msg.data.pageInfo.pageNum+"总共页数："+
            msg.data.pageInfo.pages+"每页行数："+msg.data.pageInfo.pageSize+"总记录数："
            +msg.data.pageInfo.total+"连续显示页数："+msg.data.pageInfo.navigatePages);
        /*===========给全局变量:总记录数赋值，用于实现保存跳转新添加员工所在一页======*/
        maxPageBigger=msg.data.pageInfo.pages+1;
    }
    /*==================================================页面导航=============================================*/
    function build_page_nav(msg) {
        $("#page_nav").empty();
        var topPageNavli = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var previous = $("<li></li>").append($("<a></a>").append("<span></span>").append("&laquo;").attr("href","#"));
        var next = $("<li></li>").append($("<a></a>").append("<span></span>").attr("aria-hidden","true").append("&raquo;").attr("href","#"));
        var tailPageNvali = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        var ul = $("<ul></ul>").addClass("pagination");
        var nav = $("<nav></nav>").attr("aria-label","Page navigation");
        /*=====================判断是否为首页======================*/
        if(msg.data.pageInfo.isFirstPage){
            topPageNavli.addClass("disabled");
            previous.addClass("disabled");
        }else {
            topPageNavli.click(function () {
                skip_page(1)
            });
            previous.click(function () {
               skip_page(msg.data.pageInfo.pageNum-1);
            });
        }
       /* if(!msg.data.pageInfo.isFirstPage){

        }*/
        ul.append(topPageNavli,previous);
        $.each(msg.data.pageInfo.navigatepageNums,function (index,item) {
           var numli = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
           if(msg.data.pageInfo.pageNum==item){
               numli.addClass("active");
           }
           numli.click(function () {
               skip_page(item);
           });
           ul.append(numli);
        });
        /*=============判断是否为末页====================*/
        if(msg.data.pageInfo.isLastPage){
            tailPageNvali.addClass("disabled");
            next.addClass("disabled");
        }else {
        next.click(function () {
            skip_page(msg.data.pageInfo.pageNum+1)
        });
        tailPageNvali.click(function () {
                skip_page(msg.data.pageInfo.pages);
            });

        }
        ul.append(next,tailPageNvali);
        nav.append(ul);
        $("#page_nav").append(nav);

    }
    /*=============================================点击添加按钮=============================================*/


    $("#bt_add").click(function () {
        /*发送Ajax请求，查出部门信息*/
        getDepts();
        //弹出模态框
        /**
         * 1.弹出模态框时，清空数据
         * 2.清空验证属性
         * */
        $("#modal form")[0].reset();
        clearValidationAboutModel($("#empName_add"));
        clearValidationAboutModel($("#email_add"));
        /*设置模态框属性*/
        $("#modal").modal({
            backdrop:"static"
        });
    });
    function getDepts() {
        $.ajax({
            url:"${path}/department/getAll",
            type:"GET",
            success:function (msg) {
                // console.log(msg);
                /*========返回的msg信息========*/
                /*{"cod":100,
                "msg":"处理成功",
                "data":{"departments":[{"deptId":1,"deptName":"name"},{"deptId":2,"deptName":"dshe"},{"deptId":3,"deptName":"java开发部"}]}}
                * */
                $.each(msg.data.departments,function () {
                    $("<option></option>").attr("value",this.deptId).append(this.deptName).appendTo("#dept_add");
                })

            }

        });
    }
    /*==============正则校验================*/
    function validationEmp(){
        var judge =false;
        var empName = $("#empName_add").val();
        var email = $("#email_add").val();
        var regName = /(^[a-zA-Z]{6,16}$)|(^[\u2E80-\u9FFF]{2,4}$)/;
        var regemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        // alert(regName.test(empName));
        // alert(regemail.test(email));
        /*++++验证姓名++++*/
        if(regName.test(empName)){
            changeInformationAboutValidation($("#empName_add"),"success","");
            changeInformationAboutValidation($("#email_add"),"error","邮箱格式不正确!");
            if(regemail.test(email)){
                changeInformationAboutValidation($("#email_add"),"success","");
                judge = true;
            }
        }else {
            changeInformationAboutValidation($("#empName_add"),"error","员工姓名必须为：6～16字母或者2~4个中文字符组成!");
            changeInformationAboutValidation($("#email_add"),"error","邮箱格式不正确!");
            if(regemail.test(email)){
                changeInformationAboutValidation($("#email_add"),"success","");
            }
        }

            return judge;


    }
    /**
    * 清空模态框里的但验证属性
     *
     * */
    function clearValidationAboutModel(id) {
        var parent = id.parent();
        var span=id.next("span");
        parent.removeClass("has-success has-error");
        span.removeClass("glyphicon glyphicon-ok");
        span.text("");
    }
    function changeInformationAboutValidation(id, status, msg){
            clearValidationAboutModel(id);
        var parent = id.parent();
        var span=id.next("span");
        if("success" == status){
            parent.addClass("has-success");
            span.addClass("glyphicon glyphicon-ok");
        }else {
            parent.addClass("has-error");
            span.append(msg);
        }
    }



    $("#email_add").change(function () {
        var email = this.value;
        $.ajax({
            url:"${path}/employee/addValidation",
            data:"email="+email,
            type:"POST",
            success:function (msg) {
                if(msg.cod==100){
                    changeInformationAboutValidation($("#email_add"),"success","");
                    $("#emp_save_bt").attr("email-va","success");
                }else {
                    changeInformationAboutValidation($("#email_add"),"error","该邮箱以绑定员工，不可用");
                    $("#emp_save_bt").attr("email-va","error");
                }
            }
        });
    });

    //点击保存按钮
    $("#emp_save_bt").click(function () {
        /*
        * 1.使用jquery进行校验
        * 2.提交请求给服务器
        * */

        if($(this).attr("email-va")=="error"){
            return false;
        }

        if(!validationEmp()){
            return;
        }
        setTimeout(function () {
            $.ajax({
                url:"${path}/employee/add",
                type:"POST",
                data:$("#modal form").serialize(),
                success:function (result) {
                    // alert(result.msg);
                    $("#modal").modal('hide');
                    skip_page(maxPageBigger);
                }
            });
        },1)

    });
</script>
</body>
</html>

