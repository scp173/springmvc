<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>

<head>
    <%--必须放前面 jquery--%>
    <script type="text/javascript" src="resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="resource/js/jquery.form.js"></script>
    <link rel="stylesheet" type="text/css" href="resource/css/thems.css">
    <link rel="stylesheet" href="resource/css/common.css"/>
    <title>个人主页</title>
    <link rel="shortcut icon" href="http://img3.duitang.com/uploads/item/201605/10/20160510194857_Y5UMd.jpeg">

</head>

<script>
    //改变选中状态
    function hf(value){

        var ul = document.getElementById("uinav");
        var num = ul.childElementCount;
        for(var i = 0; i < num; i++){
            var inputElement = ul.children[i];
            inputElement.className = "tmp";
        }
        var now = ul.children[value-1];

        now.className = "now";

    }
</script>

<script type="text/javascript">
    var w,h,className;
    function getSrceenWH(){
        w = $(window).width();
        h = $(window).height();
        $('#dialogBg').width(w).height(h);
    }

    window.onresize = function(){
        getSrceenWH();
    }
    $(window).resize();

    $(function(){
        getSrceenWH();

        //显示弹框
        $("#loginBtn").click(function(){
            className = $(this).attr('class');
            $('#dialogBg').fadeIn(150);
            $('#dialog').removeAttr('class').addClass('animated '+className+'').fadeIn();
        });

        //关闭弹窗
        $('.claseDialogBtn').click(function(){
            $('#dialogBg').fadeOut(200,function(){
                $('#dialog').addClass('bounceOutUp').fadeOut();
            });
        });
    });
</script>


<%--调用接口scrpt--%>

<script>
    //    <!--初始构造 可在body声明-->
    <%--function addUser() {--%>
        <%--var form = document.getElementById("editForm");--%>
        <%--form.action = "${pageContext.request.contextPath}/loginAction";--%>
        <%--form.method = "post";--%>
        <%--form.submit();--%>
    <%--}--%>
    <%--function callBackGraFunc(responseText, statusText) {--%>
        <%--alert(responseText);--%>
    <%--}--%>

    <%--$(document).ready(function() {--%>
        <%--var options = {--%>
            <%--success: callBackGraFunc--%>
        <%--};--%>

        <%--// jquery.form 提交表单--%>
        <%--$('#editForm').ajaxForm(options);--%>
    <%--})--%>


</script>

<body>
<div class="header">
    <div class="logo"><a href=""><img src="resource/img/apple-gris.png" class="cimg"/></a>
        <label class="cusl">Developer</label>
    </div>
    <ul class="infoNav" id="uinav">
    <li class="now" onclick="hf(1)"><a href="javascript:;">首页</a></li>
    <li class="tmp" onclick="hf(2)"><a href="javascript:;">个人介绍</a></li>
    <li class="tmp" onclick="hf(3)"><a href="javascript:;">代码板</a></li>
    <li class="tmp" onclick="hf(4)"><a href="javascript:;">留言板</a></li>
    <li class="tmp" onclick="hf(5)"><a href="javascript:;">好友板</a></li>
</ul>
    <ul class="userinfo">
        <li class="tmp" onclick="hf(4)"><a href="javascript:;">欢迎,${loginUser}</a></li>
        <li class="tmp" onclick="hf(5)"><a href="javascript:;">退出登录</a></li>
    </ul>

</div>
</body>
</html>