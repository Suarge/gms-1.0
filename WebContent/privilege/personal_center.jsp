<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>个人中心</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/toast.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/toastr.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SMS-index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/personal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderlist.css">
</head>
<body>
	<!--引入头部-->
	<div class="header">
		<div class="real_header">
			<a href="#" style="text-decoration: none; color: #337ab7;"> <img
				src="${pageContext.request.contextPath }/img/logo.png" class="head_img"> <span class="head_span1">体育馆场地管理系统</span>
			</a>
			<div class="login">
				<div>
					<a href="" style="margin-left: -60px;"></a>
				</div>
				<div class="dropdown nav navbar-nav navbar-right" style="margin-top: -22px; margin-right: 3px;">
					<a href="" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
						<i class="glyphicon glyphicon-user"></i> 个人中心
					</a>
					<ul class="dropdown-menu " aria-labelledby="dropdownMenu1">
						<li>
							<!-- 引入模态框 --> 
							<a href="" data-toggle="modal" data-target=".showMessage" data-whatever="@mdo"> 
								<i class="glyphicon glyphicon-user"></i> 个人信息
							</a>
						</li>
						<li role="separator" class="divider"></li>
						<li>
							<!-- 引入修改密码模态框 --> 
							<a href="" data-toggle="modal" data-target="#updateModal" data-whatever="@mdo"> 
								<i class="glyphicon glyphicon-pencil"></i> 修改密码
							</a>
						</li>
						<li role="separator" class="divider"></li>
						<li>
							<a href="${pageContext.request.contextPath }/user?method=logout"> <i class="glyphicon glyphicon-off"></i>
								注销登录
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="top_line"></div>
		<div class="message">
			<p
				style="width: 1000px; margin: 0 auto; height: 30px; line-height: 30px;">
				<img style="margin-left: -6px;" src="${pageContext.request.contextPath }/img/laba.png"> 
				<span>通知：<a href="${pageContext.request.contextPath }/order?method=viewNotice&noticeId=${noticelist[0].notice_Id }" style="color: red;">${noticelist[0].notice_Title }</a></span>
			</p>
		</div>
	</div>

	<!-- 大展示框 -->
	<div class="container">
		<div class="row">
			<div class="top-notice" >
				<a href="${pageContext.request.contextPath }/user/GMS_index.jsp" target="_blank">首页&nbsp;&nbsp;&gt;</a> <a href="#">个人中心&nbsp;&nbsp;</a>
			</div>
		</div>
		<!-- 订单详情界面 -->
		<div class="col-lg-12"
			style="background-color: white; height: 540px;">
			<div class="col-md-12">
				<div class="widget-area-2 lorvens-box-shadow">
					<!-- <h2 class="widget-title">我 的 预 约</h2> -->
					<div class="row">
						<div class="col-sm-10">
							<form id="subForm" class="navbar-form navbar-left" action="${pageContext.request.contextPath }/order?method=pageOrderList" method="post">
								<span>关键字搜索： </span>
								<div class="form-group">
									<input type="text" class="form-control" id="sub" name="sub" placeholder="查询" value="${sub}">
									<!-- 默认值是"" 当表单提交的时候要判断 -->
									<input type="hidden" id="currentPage" name="currentPage">
								</div>
								<button type="submit" class="btn btn-default ">提交</button>
							</form>
						</div>
						<div class="col-sm-2" style="padding-top:15px;">
							<button style="margin-left: 6px;" type="button" onclick="export_order()"
	                        class="preadd-btn btn btn-warning btn-sm">导出数据</button>
						</div>
					</div>

					<table class="table table-hover">
						<thead style="font-size: 20;">
							<tr>
								<th>序号</th>
								<th>订单号</th>
								<th>预约场馆</th>
								<th>预约时间</th>
								<th>订单生成时间</th>
								<th>价格</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						
						<tbody><!-- style="height: 30px;"    成功的绿色用sw 的class-->
							<c:forEach items="${pageBean.list }"  var="order" varStatus="vs" >
								 <tr>
									<td>${vs.count+pageBean.currentCount*pageBean.currentPage-pageBean.currentCount}</td>
									<td>${order.order_Id}</td>
									<td><a tabindex="0" style="text-decoration:none;" role="button" data-toggle="popover" data-html="true" data-trigger="focus" title="场地详细信息" data-container="body" 
	                      			data-content="场馆类别 : ${order.order_VenueId.venue_Type}<br/>接待能力 : ${order.order_VenueId.venue_Capacity}人<br/>开放时间 : ${order.order_VenueId.venue_Open}:00<br/>关闭时间 : ${order.order_VenueId.venue_Close}:00">${order.order_VenueId.venue_Name}</a></td>
									<td>${order.order_Date} ${order.order_St}:00-${order.order_Ed}:00</td>
									<td>${order.order_Mktime2 }</td>
									<td>${order.order_Price }</td>
									<c:if test="${order.order_State==0}">
										<td><button  type="button" class="btn btn-warning btn-sm sh sw">进行中</button></td>
										<td style="padding-left:0px;"><button type="button" class="btn btn-danger btn-sm sh" onclick="delOrder('${order.order_Id}','${order.order_Date}','${order.order_VenueId.venue_Id}','${order.order_St}')">取消</button></td>
									</c:if>
									<c:if test="${order.order_State==1}">
										<td><button  type="button" class="btn btn btn-info btn-sm sh sw">已取消</button></td>
										<td><i class="glyphicon glyphicon-minus" style="color:red;font-size:18px;padding-left:3px"></i></td>
									</c:if>
									<c:if test="${order.order_State==2}">
										<td><button  type="button" class="btn btn-success btn-sm sh sw">已完成</button></td>
										<td><i class="glyphicon glyphicon-minus" style="color:red;font-size:18px;padding-left:3px"></i></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>

					</table>
					<!-- 分页 -->

					<div class="row" style="margin: 0 auto; margin-top: 30px;">
						<div style="text-align: center; margin-top: 10px;">
							<nav aria-label="Page navigation">
								<ul class="pagination ">
								 <!-- 判断当前页是否是第一页 -->
									<c:if test="${pageBean.currentPage==1 }">
										<li>
											<a href="javascript:void(0);" aria-label="Previous">
												<span  aria-hidden="true">&laquo;</span> 
											</a>
										</li>
									</c:if>	
									<c:if test="${pageBean.currentPage!=1 }">
										<li>
											<a href="javascript:void(0);" onclick="changePage(${pageBean.currentPage-1})" aria-label="Previous" >
												<span  aria-hidden="true">&laquo;</span> 
											</a>
										</li>
									</c:if>	
									<!-- 判断当前页 -->
									<c:forEach begin="1" end="${pageBean.totalPage }" var="page">
										<c:if test="${pageBean.currentPage==page }">
											<li class="active"><a href="javascript:void(0);">${page}</a></li>
										</c:if>
										<c:if test="${pageBean.currentPage!=page }">
											<li><a href="javascript:void(0);" onclick="changePage(${page})">${page}</a></li>
										</c:if>
									</c:forEach>	
									 <!-- 判断当前页是否是最后一页 -->	
									<c:if test="${pageBean.currentPage==pageBean.totalPage }">
										<li><a href="javascript:void(0);" aria-label="Next"> 
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>
									<c:if test="${pageBean.currentPage!=pageBean.totalPage }">
									<li><a href="javascript:void(0);" onclick="changePage(${pageBean.currentPage+1})" aria-label="Next"> 
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>
								</ul>
							</nav>
						</div>

					</div>
					<!-- 分页结束 -->

				</div>
			</div>

		</div>

	</div>

	<!-- 个人信息模态框 -->
	<div class="modal showMessage" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">我的信息</h4>
					</div>
					<div class="modal-body">
						<p>
							<span>姓名：${user.user_Id}</span>
						</p>
						<p>
							<span>性别：${user.user_Sex}</span>
						</p>
						<p>
							<span>年龄：${user.user_Age}</span>
						</p>
						<p>
							<span>邮箱：${user.user_Email}</span>
						</p>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改密码模态框 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">修改密码</h4>
				</div>
				<div class="modal-body">
					<!-- 修改表单 -->
					<form id="user_update" action="${pageContext.request.contextPath }/user?method=updatePassword" method="POST">
						<div class="form-group">
							<label for="recipient-name" class="control-label ">原始密码:</label>
							<input type="password" name="prepassword" class="form-control" id="prepassword">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="control-label">修改密码:</label> 
							<input type="password" name="newpassword" class="form-control" id="newpassword">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="control-label">确认密码:</label> 
							<input type="password" name="repassword" class="form-control" id="repassword">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary submit_update_password">确认修改</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 界面页尾 -->
	<div class="container-fluid footer">
		<div class="row">
			<!--<div style="border:solid ;color: #EC971F"></div>-->
			<div class="footer" style="position: relative;">
				版权所有©GMS-体育馆场地管理系统 &nbsp;&nbsp;&nbsp;</div>
		</div>
	</div>
</body>

<script src="${pageContext.request.contextPath }/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/md5.js"></script>
<script src="${pageContext.request.contextPath}/js/toast.js"></script>
<script type="text/javascript">
	
	$(function () {
	    $('[data-toggle="popover"]').popover();
	});
	
	//分页
	function changePage(pageNum){
		$('#currentPage').val(pageNum);
		$("#subForm").submit();	
	}
	
	//取消订单
	function delOrder(orderId,orderDate,venueId,orderSt){
 		//当前时间大小
		var now = new Date();
		var nowday = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();//2019-12-5
		var hours = now.getHours();
	    var minutes = now.getMinutes();
	    var seconds = now.getSeconds();
	    
	    var nowtime = nowday+" "+hours+":"+minutes+":"+seconds;

	    orderAllDate = orderDate+" "+orderSt+":00:00";//${order.order_Date} ${order.order_St}:00:00
	    var orderDateTime = new Date(orderAllDate.replace(/-/g,'/')).getTime();
	    var nowtimeTime = new Date(nowtime.replace(/-/g,'/')).getTime();
	    
	    if(orderDateTime-nowtimeTime>=6*60*60*1000){
	    	//var del = confirm("您确定要取消预约吗？提前六小时可以取消预约");
	    	Ewin.confirm({ message: "您确认要取消预约吗？" }).on(function (e) {
				if (e) {
					window.location.href="${pageContext.request.contextPath}/order?method=delOrder&orderId="+orderId+"&venueId="+venueId+"&orderDate="+orderDate+"&orderSt="+orderSt;
					}
				
			});
	    }else{
	    	showMessage('请提前六小时取消预约',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
	    }
	}
	
	 //修改密码
	 $("body").on("click", ".submit_update_password",function(e){
	    	if($('#prepassword').val().trim()==''){
				//toastr.warning('原密码不能为空');	
	    		showMessage('原密码不能为空',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			}
			else if($('#newpassword').val().trim()==''){
				//toastr.warning('新密码不能为空');
				showMessage('新密码不能为空',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			}
			else if($('#newpassword').val().trim()!=$('#repassword').val().trim()){
				//toastr.warning('两次填写密码不一致');
				showMessage('两次填写密码不一致',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			}
			else if(md5($('#prepassword').val().trim())!="${user.user_Password}"){
				//toastr.error('原密码填写错误');
				showMessage('原密码填写错误',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			}
			else{
				$("#user_update").submit();
			}
	  });
	
	//导出数据
	function export_order(){
		this.location.href="${pageContext.request.contextPath}/order?method=export_order";
	}
	
	
	//引入的confirm
	(function ($) {
		 window.Ewin = function () {
		 var html = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">' +
		  '<div class="modal-dialog modal-sm">' +
		   '<div class="modal-content">' +
		   '<div class="modal-header">' +
		   '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>' +
		   '<h4 class="modal-title" id="modalLabel">[Title]</h4>' +
		   '</div>' +
		   '<div class="modal-body">' +
		   '<p>[Message]</p>' +
		   '</div>' +
		   '<div class="modal-footer">' +
		 '<button type="button" class="btn btn-default cancel" data-dismiss="modal">[BtnCancel]</button>' +
		 '<button type="button" class="btn btn-primary ok" data-dismiss="modal">[BtnOk]</button>' +
		 '</div>' +
		   '</div>' +
		  '</div>' +
		  '</div>';
		 
		 
		 var dialogdHtml = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">' +
		  '<div class="modal-dialog">' +
		   '<div class="modal-content">' +
		   '<div class="modal-header">' +
		   '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>' +
		   '<h4 class="modal-title" id="modalLabel">[Title]</h4>' +
		   '</div>' +
		   '<div class="modal-body">' +
		   '</div>' +
		   '</div>' +
		  '</div>' +
		  '</div>';
		 var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
		 var generateId = function () {
		 var date = new Date();
		 return 'mdl' + date.valueOf();
		 }
		 var init = function (options) {
		 options = $.extend({}, {
		 title: "操作提示",
		 message: "提示内容",
		 btnok: "确定",
		 btncl: "取消",
		 width: 200,
		 auto: false
		 }, options || {});
		 var modalId = generateId();
		 var content = html.replace(reg, function (node, key) {
		 return {
		  Id: modalId,
		  Title: options.title,
		  Message: options.message,
		  BtnOk: options.btnok,
		  BtnCancel: options.btncl
		 }[key];
		 });
		 $('body').append(content);
		 $('#' + modalId).modal({
		 width: options.width,
		 backdrop: 'static'
		 });
		 $('#' + modalId).on('hide.bs.modal', function (e) {
		 $('body').find('#' + modalId).remove();
		 });
		 return modalId;
		 }
		 
		 return {
		 alert: function (options) {
		 if (typeof options == 'string') {
		  options = {
		  message: options
		  };
		 }
		 var id = init(options);
		 var modal = $('#' + id);
		 modal.find('.ok').removeClass('btn-success').addClass('btn-primary');
		 modal.find('.cancel').hide();
		 
		 return {
		  id: id,
		  on: function (callback) {
		  if (callback && callback instanceof Function) {
		  modal.find('.ok').click(function () { callback(true); });
		  }
		  },
		  hide: function (callback) {
		  if (callback && callback instanceof Function) {
		  modal.on('hide.bs.modal', function (e) {
		  callback(e);
		  });
		  }
		  }
		 };
		 },
		 confirm: function (options) {
		 var id = init(options);
		 var modal = $('#' + id);
		 modal.find('.ok').removeClass('btn-primary').addClass('btn-success');
		 modal.find('.cancel').show();
		 return {
		  id: id,
		  on: function (callback) {
		  if (callback && callback instanceof Function) {
		  modal.find('.ok').click(function () { callback(true); });
		  modal.find('.cancel').click(function () { callback(false); });
		  }
		  },
		  hide: function (callback) {
		  if (callback && callback instanceof Function) {
		  modal.on('hide.bs.modal', function (e) {
		  callback(e);
		  });
		  }
		  }
		 };
		 },
		 dialog: function (options) {
		 options = $.extend({}, {
		  title: 'title',
		  url: '',
		  width: 800,
		  height: 550,
		  onReady: function () { },
		  onShown: function (e) { }
		 }, options || {});
		 var modalId = generateId();
		 
		 var content = dialogdHtml.replace(reg, function (node, key) {
		  return {
		  Id: modalId,
		  Title: options.title
		  }[key];
		 });
		 $('body').append(content);
		 var target = $('#' + modalId);
		 target.find('.modal-body').load(options.url);
		 if (options.onReady())
		  options.onReady.call(target);
		 target.modal();
		 target.on('shown.bs.modal', function (e) {
		  if (options.onReady(e))
		  options.onReady.call(target, e);
		 });
		 target.on('hide.bs.modal', function (e) {
		  $('body').find(target).remove();
		 });
		 }
		 }
		 }();
		})(jQuery);


	
</script>
</body>
</html>