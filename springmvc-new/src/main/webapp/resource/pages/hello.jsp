<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>

<head>

    <%--必须放前面 jquery--%>
    <script type="text/javascript" charset="UTF-8" src="resource/js/jquery.min.js"></script>
        <script type="text/javascript" charset="UTF-8" src="resource/js/jquery.js"></script>

        <script type="text/javascript" src="resource/js/jquery.form.js"></script>
    <script type="text/javascript" src="resource/js/cookie.js"></script>
        <%--<script type="text/javascript" src="resource/js/jquery.js"></script>--%>
        <script type="text/javascript" src="resource/js/main.js"></script>

    <link rel="stylesheet" type="text/css" href="resource/css/thems.css">
        <link rel="stylesheet" type="text/css" href="resource/css/button.css">
        <link rel="stylesheet" type="text/css" href="resource/css/common.css"/>
        <link rel="stylesheet" type="text/css" href="resource/css/style.css"/>

        <title>个人主页</title>
    <link rel="shortcut icon" href="resource/img/fluidicon.png">

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

    function showdialog(className) {
        $('#dialogBg').fadeIn(150);
        $('#dialog').removeAttr('class').addClass('animated '+className+'').fadeIn();

    }

    $(function(){
        getSrceenWH();

        //显示弹框
//        $("#loginBtn").click(function(){
//            className = $(this).attr('class');
//            $('#dialogBg').fadeIn(150);
//            $('#dialog').removeAttr('class').addClass('animated '+className+'').fadeIn();
//        });

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
        <%--form.action = "${pageContext.request.contextPath}/main";--%>
        <%--form.method = "post";--%>
        <%--form.submit();--%>
    <%--}--%>
    <%--function callBackGraFunc(responseText, statusText) {--%>
      <%--//  alert("登录成功!");--%>
        <%--$('#dialogBg').fadeOut(200,function(){--%>
            <%--$('#dialog').addClass('bounceOutUp').fadeOut();--%>
        <%--});--%>
        <%--var form = document.getElementsByClassName("logNav");--%>


    <%--}--%>

    <%--$(document).ready(function() {--%>
        <%--var options = {--%>
            <%--success: callBackGraFunc--%>
        <%--};--%>

        <%--// jquery.form 提交表单--%>
        <%--$('#editForm').ajaxForm(options);--%>
    <%--})--%>
    //检查用户是否登录
    function checkCookie() {
        var cookie = getCookie("username");
        if (cookie!=null)
        {
            //已存在
        //    alert(cookie);
            var my = document.getElementById("needlogindiv");
            if (my != null) {
                my.parentNode.removeChild(my);
                //添加用户资料div
              //  adduserdiv(cookie);
            }
            adduserdiv(cookie);


        }
        else{
            addneedlogindiv();
        }
    }

//    --------------
    //退出登录
    function logout() {
        var my = document.getElementById("islogin");
        if (my != null) {
            my.parentNode.removeChild(my);
            //添加用户资料div
            addneedlogindiv();
        }
        delCookie("username");
    }


    //登录
    function addUser() {

       // var val=$("#submitBtn option:selected").val();
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/loginAction",
            dataType:"json",
            async:false,
            contentType: "application/json",
              data:DataDeal.formToJson($( '#editForm').serialize()),
           // data:JSON.stringify({nickname:'google',username:'hello',password:'123456'}),
            success: function(data) {
          //  alert("success");

                //登录成功,缓存cookie
                if (data.success==1) {//1成功
                    setCookie("username", data.loginUser, "d7")
                    $('#dialogBg').fadeOut(200, function () {
                        $('#dialog').addClass('bounceOutUp').fadeOut();
                    });
                    //    alert("username"+data.loginUser);
                    //先移除左边div 重新添加登录后用户div
                    var my = document.getElementById("needlogindiv");
                    if (my != null) {
                        my.parentNode.removeChild(my);
                        //添加用户资料div
                        adduserdiv(data.loginUser);
                    }
                }else
                {
                    alert("faild");

                }
            
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("faild");

            }
        });

    }
    //动态添加需要登录界面
    function addneedlogindiv() {
        var my = document.createElement("ul");
        var amy = document.createElement("a");
        amy.href = "javascript:showdialog('bounceInDown'); ";
        my.className = "logNav";
        my.id = "needlogindiv"
        var parent = document.getElementById("wheader");
        parent.appendChild(my);
        var child1 = document.createElement("li");
        child1.id="loginBtn" ;
        child1.class="bounceInDown";
        amy.innerHTML = "登录";
        child1.appendChild(amy);
        my.appendChild(child1);
        var bmy = document.createElement("a");
        bmy.href = "javascript: void(0)";
        var child2 = document.createElement("li");
        bmy.innerHTML = "注册";
        bmy.href = "/register";
        child2.id = "logout";
        child2.appendChild(bmy);
        my.appendChild(child2);
    }

    function adduserdiv(str1) {
        var my = document.createElement("ul");
        my.id = "islogin"
        var amy = document.createElement("a");
        amy.href = "javascript: void(0)";
        my.className = "userinfo";
        var parent = document.getElementById("wheader");
        parent.appendChild(my);
        var child1 = document.createElement("li");
        amy.innerHTML = "hello,"+str1;
        child1.appendChild(amy);
        my.appendChild(child1);
        var bmy = document.createElement("a");
        bmy.href = "javascript:logout();";
        var child2 = document.createElement("li");
        bmy.innerHTML = "退出登录";
        child2.id = "logout";
        child2.appendChild(bmy);
        my.appendChild(child2);
    }
//模拟按钮点击事件
</script>

<body onload="checkCookie()">

<%--<div id="Layer1" style="position:absolute; width:100%; height:100%; z-index:-1">--%>
    <%--<img src="resource/img/Forest.jpg" height="100%" width=1000px/>--%>
<%--</div>--%>

<div class="header" id="wheader">
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
    <%--<ul class="logNav" id="needlogindiv">--%>
        <%--<li  id="loginBtn"><a href="javascript:showdialog('bounceInDown');"> 登录</a></li>--%>
         <%--<li class="bounceInDown" onclick="register()"><a href="javascript:;">注册</a></li>--%>
    <%--</ul>--%>


</div>

<div class="slide-main" id="touchMain">
    <a class="prev" href="javascript:;" stat="prev1001"><img src="resource/img/images/l-btn.png" /></a>
    <div class="slide-box" id="slideContent">
        <div class="slide" id="bgstylec" style="background:url(resource/img/images/bannerbg2.jpg) no-repeat 0 0";>
            <a stat="sslink-3" href="" target="_blank">
                <div class="obj-e"><img src="resource/img/images/dm3.png" /></div>
                <div class="obj-f"><img src="resource/img/images/dm3-c.png" /></div>
            </a>
        </div>
        <%--<div class="slide" id="bgstylea" style="background:url(resource/img/images/bannerbg3.jpg) no-repeat 0 0";>--%>
            <%--<a stat="sslink-1" href="" target="_blank">--%>
                <%--<div class="obj-a"><img src="resource/img/images/dm1.png" /></div>--%>
                <%--<div class="obj-b"><img src="resource/img/images/dm1-c.png" /></div>--%>
            <%--</a>--%>
        <%--</div>--%>
        <div class="slide" id="bgstyleb" style="background:url(resource/img/images/bannerbg.jpg) no-repeat 0 0";>
            <a stat="sslink-2" href="" target="_blank">
                <div class="obj-c"><img src="resource/img/images/dm2.png" /></div>
                <div class="obj-d"><img src="resource/img/images/dm2-c.png" /></div>
            </a>
        </div>
    </div>
    <a class="next" href="javascript:;" stat="next1002"><img src="resource/img/images/r-btn.png" /></a>
    <div class="item">
        <a class="cur" stat="item1001" href="javascript:;"></a><a href="javascript:;" stat="item1002"></a><a href="javascript:;" stat="item1003"></a>
    </div>
</div>


<%--弹出登录狂视图--%>
<div id="dialogBg"></div>
<div id="dialog" class="animated">
    <img class="dialogIco" width="50" height="50" src="resource/img/ico.png"/>
    <div class="dialogTop">
        <a href="javascript:;" class="claseDialogBtn">关闭</a>
    </div>
    <form  id="editForm"  method="post">
        <ul class="editInfos">
            <li><label color="#ff0000">帐号：<input type="text" name="username"  class="ipt"/></label></li>
            <li><label color="#ff0000">密码：<input type="password" name="password"  class="ipt" autocomplete="off"/></label></li>
        </ul>
    </form>
    <button class="button button-royal button-rounded button-small" onclick="addUser()">登录</button>

</div>

<%--完毕--%>
</body>
</html>