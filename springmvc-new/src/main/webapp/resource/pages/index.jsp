<%--
  Created by IntelliJ IDEA.
  User: 111
  Date: 16-6-9
  Time: 下午8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <style>.div-inline{display: inline}
    </style>

    <style>
        .htmleaf-header{
            padding: 1em 0px 1em;
            letter-spacing: -1px;
            background: #66677c;
        }
         .headimgpa {
             padding: 1em 20px 1em;
             letter-spacing: -1px;
             background: #66677c;         }
    </style>
    <link rel="stylesheet" href="resource/css/common.css"/>
    <title>个人主页</title>
    <link rel="shortcut icon" href="http://img3.duitang.com/uploads/item/201605/10/20160510194857_Y5UMd.jpeg">
    <script type="text/javascript" src="resource/js/jquery.min.js"></script>
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
            $("#click1").click(function(){
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
</head>



<body>
<header class="htmleaf-header">
    <img class="head" width="100px" height="100px" src="resource/img/ico.png"/>
        <%--<div style="width:200px; float:right;">发表日期：2009-09-10</div>--%>
    <h1 style="text-align: center"><font color="#D5D6E2">这是我的个人网站</font></h1>

    <h2 style="text-align: center"><font color="#c3c8cd">MyBlog</font></h2>
    <br>
</header>

<button type="button" id="click1">登录</button>

<div id="dialogBg"></div>
<div id="dialog" class="animated">
    <img class="dialogIco" width="50" height="50" src="resource/img/ico.png"/>
    <div class="dialogTop">
        <a href="javascript:;" class="claseDialogBtn">关闭</a>
    </div>
    <form action="/loginAction" method="post" id="editForm">
        <ul class="editInfos">
            <li><label color="#ff0000">帐号：<input type="text" name="username" required value="username" class="ipt" /></label></li>
            <li><label color="#ff0000">密码：<input type="password" name="password" required value="password" class="ipt" /></label></li>
            <li><input type="submit" value="确认提交" class="submitBtn" onclick="addUser()"/></li>
        </ul>


    </form>
</div>

</body>
</html>
