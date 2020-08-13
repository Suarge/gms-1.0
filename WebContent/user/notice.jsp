<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>体育管场地管理系统通知中心</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/SMS-index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/notice.css" />
</head>
<body>
	<!--引入头部-->
	<div class="header">
		<div class="real_header">
			<a href="#" style="text-decoration: none; color: #337ab7;"> <img
				src="${pageContext.request.contextPath }/img/logo.png" class="head_img"> <span class="head_span1">体育馆场地管理系统</span>
			</a>
		</div>
		<div class="top_line"></div>
		<div class="message">
			<p
				style="width: 1000px; margin: 0 auto; height: 30px; line-height: 30px;">
				<img style="margin-left: -6px;" src="http://hqcggl.ouc.edu.cn/itsoftui/img/img/laba.png"> 
				<span>通知：<a href="${pageContext.request.contextPath }/order?method=viewNotice&noticeId=${noticelist[0].notice_Id }" style="color: red;">${noticelist[0].notice_Title }</a></span>
				</span>
			</p>
			</p>
		</div>
	</div>

	<!-- 通知消息 -->
	<div class="container">
		<div class="row">
			<div class="top-notice">
				<a href="${pageContext.request.contextPath }/user/GMS_index.jsp">首页&nbsp;&nbsp;&gt;</a> <a href="#">通知公告&nbsp;&nbsp;</a>
			</div>
		</div>
		<div class=" n_top">
			<h4 class="text-center">体育场馆场地管理系统</h4>
			<div class="text-center">
				<span>作者：${notice.notice_Man}</span>&nbsp;&nbsp;&nbsp;&nbsp; <span>时间：${notice.notice_Time }
					10:48</span>
			</div>
			<div class="">
				<p class="text-center">
				<h3 class="text-center">通&nbsp;&nbsp;知</h3>
				<br>
				</p>
				<p class="n_cont">
					${notice.notice_Content}
				</p>
				<br> <br>
				<p class="text-right" style="font-size: 16px;">
					<span style="font-size: 18px;"> 教室与场馆管理中心 </span> <br> <br>
					${notice.notice_Time } <br>
				</p>

			</div>
		</div>
	</div>


	<!-- 引入页尾 -->
	<div class="container-fluid f_top footer" style="margin-top: 60px;">
		<div class="row">
			<!--<div style="border:solid ;color: #EC971F"></div>-->
			<div class="footer" style="position: relative;">
				版权所有©GMS-体育馆场地管理系统 &nbsp;&nbsp;&nbsp;</div>
		</div>
	</div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
        
</html>