<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/toastr.min.css" rel="stylesheet">
        <title>admin登录</title>
        <style>
            body{
                background-image: url('${pageContext.request.contextPath}/img/bg.jpg');
            }
            .mycontainer{
                margin-left: 36%;
                margin-top: 8%;
                border-width: 0px;
                position: absolute;
                left: 0px;
                top: 0px;
                width: 400px;
                height: 400px;
                /*background: inherit;*/
                background-color: rgba(255, 255, 255, 1);
                border: none;
                border-radius: 3px ;
            }
            .input1,.input2{
                position: absolute;
                left: 0px;
                top: 0px;
                width: 310px;
                height: 45px;
                margin-left: 12%;
                background: inherit;
/*                background-color: rgba(231, 231, 231, 1);*/
                box-sizing: border-box;
                border-width: 1px;
                border-style: solid;
                border-color: rgba(228, 228, 228, 1);
                border-radius: 5px;
            }
            .input1{
                margin-top:35%;
            }
            .input2{
                margin-top:54%;
            }
            .sbt input{
                width: 135px;
                height: 35px;
                margin-left: 125px;
                margin-top: 15px;
                background: inherit;
                background-color: rgba(67, 69, 72, 1);
                border: none;
                border-radius: 5px;
            }
        </style>
        
    </head>
    <body>
        <div class="mycontainer">
            <div>
                <form id="loginform" action="${pageContext.request.contextPath }/admin?method=login" method="post">
                    <div style="margin-top: 15%;margin-left: 23%;">
                        <span style="font-size: 20px;font-weight: 700;">体育馆场地管理系统</span>
                    </div>
                    <div class="input1 row">
                        <div class="col-sm-1" style="margin-left:-15px;">
                            <img src="${pageContext.request.contextPath}/img/login-u.svg" style="height: 21px;margin-top: 9px;margin-left: 10px;">
                            </div>
                            <div class="col-sm-1"></div>
                            <div class="col-sm-6" style="margin-left: -20px;">
                                <input type="text" name="username" placeholder="用户名" style="margin-top: 7px;background-color: transparent;border-color: transparent;outline:none;">
                        </div>
                    </div>
                    <div class="input2 row">
                        <div class="col-sm-1" style="margin-left:-15px;">
                        <img src="${pageContext.request.contextPath}/img/login-p.svg" style="height: 21px;margin-top: 9px;margin-left: 10px;">
                        </div>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-6" style="margin-left: -20px;">
                            <input type="password" name="password" placeholder="密码" style="margin-top: 7px;background-color: transparent;border-color: transparent;outline:none;">
                        </div>
                    </div>
                    <div style="margin-top: 45%;margin-left: 75%; color: #000033;">
                        <span onclick="forgotpassword()">忘记密码</span>
                    </div>
                    <div class="sbt">
                        <input type="button" onclick="checkform()" style="color: white;" value="登录">
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/toastr.min.js"></script>
    <script>
    	$(function(){
    		// 设置操作结果提示的位置和展示时间
    	    toastr.options.positionClass = 'toast-center-center';
    	    toastr.options.timeOut = 1200;
    	    if("${error}"=="") ;
    	    else{
    	    	toastr.error("${error}");
    	    }
    	});
		function checkform(){
			if($('input[name=username]').val().trim()==''){
				toastr.warning('用户名不能为空');	
			}
			else if($('input[name=password]').val().trim()==''){
				toastr.warning('密码不能为空');
			}
			else{
				$("#loginform").submit();	
			}
		}
		function forgotpassword(){
			toastr.warning('暂时不支持当前功能');
		}
    </script>
</html>