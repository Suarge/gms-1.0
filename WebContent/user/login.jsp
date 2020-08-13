<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/toast.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login-style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/showMessage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
<title>Insert title here</title>
</head>
<body>
	<div class="sign-up-from">
		<form id="reform" class="register-form" action="${pageContext.request.contextPath}/user?method=register" method="post" >
			<img class="imgs" src="${pageContext.request.contextPath}/img/count.png" />
			<h1>会员注册</h1>
			<input type="text" class="input-box" id="user_Id" name="user_Id" placeholder="学号/工号" required="true"/> 
			<input type="text" class="input-box" id="user_Sex" name="user_Sex" placeholder="性别" required="true"/>
			<input type="text" class="input-box" id="user_Age" name="user_Age" placeholder="年龄" required="true"/>
			<input type="password" class="input-box" id="user_Password" name="user_Password" placeholder="密码" required="true"/>
			<input type="password" class="input-box" id="user_rePassword" name="user_rePassword" placeholder="确认密码"required="true" >
		 	<input type="email" class="input-box" id="user_Email" name="user_Email" placeholder="电子邮件" required="true" />
			<button class="sign-up-btn">创建账户</button>
			<p class="message">
				已经有了一个账户? <a href="#">立刻登录</a>
			</p>
		</form>

		<form id="loform" action="${pageContext.request.contextPath}/user?method=login" method="post">
			<img class="imgs" src="${pageContext.request.contextPath}/img/count.png" />
			<h1>会员登录</h1>
			<input type="text" class="input-box" id="user_Id" name="user_Id" placeholder="请输入学号/工号" /> 
			<input type="password" class="input-box" id="user_Password" name="user_Password" placeholder="请输入密码" /> <span>
			<input type="checkbox" class="check-box">记住密码</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<span><input type="checkbox" name="autoLogin">自动登录</span>
			<button type="submit" class="sign-up-btn">登录</button>
			<a style="color:red;">${loginError }</a>
			<p class="message">
				还没有账号？<a href="#">立刻创建</a>
			</p>
			<p></p>
		</form>

	</div>
</body>
<!-- 引入表单检验插件 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/toast.js"></script>
<script>
	// 同一个页面跳转
	$(function() {
		$('.message a').click(function() {
			$('form').animate({
				height : 'toggle',
				opacity : 'toggle'
			}, 'slow');
		});
		
		
		//注册校验两次密码是否一致
		$('#user_rePassword').blur(function(){
			 if($("#user_rePassword").val()!=$("#user_Password").val()){
				 showMessage('两次密码不一致',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			 }
		});
		
		
		//后台校验用户名是否存在
		$('#user_Id').blur(function(){
			var flag= false;
			var user_Id =$('#user_Id').val();
			
			$.ajax({
				"async":false,
				"url":"${pageContext.request.contextPath}/user?method=CheckUsername",
				"data":{"user_Id":user_Id},
				"type":"POST",
				"dataType":"json",
				"success":function(data){
					flag = data.isExist;
				}
			});
			
			if(flag==true){
				 showMessage('用户名已存在,请输入正确的学号/工号',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			}
		});
		
	})
</script>
</html>