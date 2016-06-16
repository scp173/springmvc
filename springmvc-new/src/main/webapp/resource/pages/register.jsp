<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML>
<html lang="en-US">
<head>
    <title>注册</title>
    <meta charset="UTF-8">
    <meta name="keywords" content="注册页面模板,网站注册页面,注册模板页面,网站模板,注册页面表单验证">
    <meta name="description" content="JS代码网提供大量的注册页面模板的学习和下载">
    <link type="text/css" href="resource/pages/logincss/public.css" rel="stylesheet">
    <link type="text/css" href="resource/pages/logincss/register.css" rel="stylesheet">
    <link type="text/css" href="resource/pages/logincss/reset.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" />
    <script src="resource/js/jquery.min.js" type="text/javascript"></script>
    <script src="resource/js/jquery.form.js" type="text/javascript"></script>
    <script src="resource/pages/loginjs/json.parse.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function(){
            $(".registerbtn").click(function(){
                var agreenMent=$("#agreement").attr("data");

                //alert(agreenMent);0
                var userName= $("#username").val();
                var userPass= $("#password1").val();
                var userPass2=$("#password2").val();
                var userEmail=$("#mail").val();
                var vercode =$("#varcode").val();

                userPass=$.trim(userPass);
                userPass2=$.trim(userPass2);

                $(".input_div1 span,.input_div2 span,.input_div3 span,.input_div4 span,.input_div6 span,.input_div5 span").html("");
                $(".btn").val('注册中...').attr('disabled','disabled');

                if(!isRegisterUserName(userName)){
                    $(".input_div1 span").html('<img src="resource/pages/loginimg/text_error.png"><font color=red>账户名格式不正确!</font>');
                    $("#username").focus();
                    $(".btn").val('注册').removeAttr('disabled');
                    return false;
                }else if(!isEmail(userEmail)){
                    $(".input_div2 span").html('<img src="resource/pages/loginimg/text_error.png"><font color=red>邮箱格式不正确!</font>');
                    $("#mail").focus();
                    $(".btn").val('注册').removeAttr('disabled');
                    return false;
                }else if(userPass.length <8){
                    $(".input_div3 span").html('<img src="resource/pages/loginimg/text_error.png"><font color=red>密码格式不正确!</font>');
                    $("#password1").focus();
                    $(".btn").val('注册').removeAttr('disabled');
                    return false;
                }else if(userPass != userPass2){
                    $(".input_div4 span").html('<img src="resource/pages/loginimg/text_error.png"><font color=red>两次输入的密码不一致!</font>');
                    $("#password2").focus();
                    $(".btn").val('注册').removeAttr('disabled');
                    return false;
                } else if(vercode ==''){
                    $(".input_div5 span").html('<img src="resource/pages/loginimg/text_error.png"><font color=red>输入用户昵称</font>').fadeIn();
                    $("#varcode").focus();
                    $(".btn").val('注册').removeAttr('disabled');
                    return false;
                } else if(agreenMent != '1'){
                    //$(".agreenment-tips").html('请先同意用户条款!').fadeIn();
                    $(".input_div6 span").html('<img src="resource/pages/loginimg/text_error.png"><font color=red>请先同意用户条款!</font>');
                    $(".btn").val('注册').removeAttr('disabled');
                    return false;
                }else{

                    var ajax_option={
                        type:"post",
                        url:"${pageContext.request.contextPath}/registerAction",
                        dataType:"json",
                        async:false,
                        success:function(data){
                           // alert(data);
                            if (data.success==1) {//1成功
                                setCookie("username", data.loginUser, "d7")

                            }else
                            {
                                alert("faild");

                            }
                        }};
                    $("#registerForm").ajaxSubmit(ajax_option);
                }

            })

            $(".change").click(function(){
                $("#imgcode").attr('src','vercode');
            })

            $('.check2').click(function(){
                var rel = $('#agreement').attr("data");
                //alert(rel);
                if(rel =='1'){
                    $('#agreement').attr("data","0");
                }else{
                    $('#agreement').attr("data","1");
                }
                $('.check2').toggleClass("check1");
            });

        });

        function isRegisterUserName(s){
            var patrn=/^[a-zA-Z0-9]{1}([a-zA-Z0-9]|[._]){5,19}$/;
            if (!patrn.exec(s)) return false
            return true
        }

        function isEmail(email){
            var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            if(!myreg.test(email)) return false;
            return true;
        }

    </script>
    <style>
        .input_div span{ background:#FFF;}
    </style>
    <!--[if IE 6]>
    <script src="resource/pages/loginjs/DD_belatedPNG.js"  type="text/javascript"></script>
    <script>DD_belatedPNG.fix('.png_bg');</script>
    <![endif]-->
</head>
<body>


<div class="register_content">

    <ul class="step_ul step1 clear">
        <li class="li1">01、填写资料</li>
        <li class="li2">02、完成注册</li>
    </ul>

    <form name="registerForm" id='registerForm' action="/registerAction" method="post" style="padding:60px 40px 88px 40px;font-family:Microsoft Yahei">
        <div class="div_form clear ">
            <label>账户名：</label>
            <div class="input_div input_div1">
                <input id="username" name="username" type="text" placeholder="格式6-24位数字字母组合" maxlength="24">
                <span></span>
            </div>
        </div>
        <div class="div_form clear ">
            <label>昵称：</label>
            <div class="input_div input_div5" >
                <input id="nickname" name="nickname" type="text" maxlength="30" placeholder="请填写用户昵称">

            </div>
        </div>
        <div class="div_form clear ">
            <label>常用的邮箱帐号：</label>
            <div class="input_div input_div2" >
                <input id="mail" name="useremail"  type="text" placeholder="请填写正确的邮箱，以便接收账号激活邮件" maxlength="64">
                <span></span>
            </div>
        </div>
        <div class="div_form clear ">
            <label>请创建一个密码：</label>
            <div class="input_div input_div3">
                <input id="password1" name="userpass" type="password" placeholder="最少 8 个字符，区分大小写" maxlength="32">
                <span></span>
            </div>
        </div>
        <div class="div_form clear ">
            <label>重新输入密码：</label>
            <div class="input_div input_div4">
                <input id="password2" type="password" placeholder="再次输入密码" maxlength="32">
                <span></span>
            </div>
        </div>

        <div class="div_form clear ">
            <label></label>
            <div class="input_div check2 input_div6" data="0" id="agreement">
                我已阅读并接受《用户注册协议》
                <span></span>
            </div>
        </div>

        <div class="div_form clear ">
            <label></label>
            <div class="input_div">
                <input id="registerbtn" class="registerbtn" type="button" value="注册" />
            </div>
        </div>

    </form>

    <div class="reg_login">
        <p>已有帐号？</p>
        <a class="btn2" href="/main">返回登录</a>
    </div>
    <div class="bg"></div>
</div>

<!-- footer start -->
<!-- footer end -->
</body>
</html>
















