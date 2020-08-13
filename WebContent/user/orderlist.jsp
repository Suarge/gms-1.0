<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>订单详情</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/SMS-index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/personal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/orderlist.css">
</head>
<body>
	<!--引入头部-->
	<div class="header">
		<div class="real_header">
			<a href="#" style="text-decoration: none; color: #337ab7;"> <img
				src="${pageContext.request.contextPath }/img/logo.png" class="head_img"> <span class="head_span1">体育馆场地管理系统</span>
			</a>
			<div class="login">
				<!-- 用户名不为空展示 -->
				<c:if test="${!empty user }">
					<div>
						<a href="${pageContext.request.contextPath }/user/login.jsp"
							style="margin-left: -60px;">
						</a>
					</div>
					<div class="dropdown" style="margin-top: -22px;">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"
							role="button" aria-haspopup="true" aria-expanded="false"> <i
							class="glyphicon glyphicon-user"></i> ${user.user_Id }
						</a>
						<ul class="dropdown-menu " aria-labelledby="dropdownMenu1">
							<li>
								<a href="javascript:void(0);" onclick="window.open('${pageContext.request.contextPath}/order?method=pageOrderList')" data-toggle="modal" >
									<i class="glyphicon glyphicon-user"></i>
									个人中心
								</a>
							</li>
							<li role="separator" class="divider"></li>
							<li>
								<a href="${pageContext.request.contextPath }/user?method=logout">
									<i class="glyphicon glyphicon-off"></i>
									注销登录
								</a>
							</li>
						</ul>
					</div>
				</c:if>
			</div>
		</div>
		<div class="top_line"></div>
		<div class="message">
			<p
				style="width: 1000px; margin: 0 auto; height: 30px; line-height: 30px;">
				<img style="margin-left: -6px;"
					src="${pageContext.request.contextPath }/img/laba.png">
					 <span>通知：<a href="${pageContext.request.contextPath }/order?method=viewNotice&noticeId=${noticelist[0].notice_Id }" style="color: red;">${noticelist[0].notice_Title }</a></span>
				</span>
			</p>
		</div>
	</div>

	<!-- 大展示框 -->
	<div class="container">
		<div class="row">
			<div class="top-notice">
				<a href="${pageContext.request.contextPath }/user/GMS_index.jsp" target="_blank">首页&nbsp;&nbsp;&gt;</a> <a href="#">订单详情&nbsp;&nbsp;</a>
			</div>
		</div>
		<!-- 订单详情界面 -->
		<div class="col-lg-12" style="background-color: #fff; height: 545px;">
			<form action="${pageContext.request.contextPath}/order?method=submitOrder" method="post">
				<div class="col-md-12">
					<div class="widget-area-2 lorvens-box-shadow min-h">
						<h2 class="widget-title">订 单 列 表</h2>
						<!-- 这里是订单详细表单 -->
						<table class="table table-bordered">
							<thead>
								<th>序号</th>
								<th>订单号</th>
								<th>预约场馆</th>
								<th>预约时间</th>
								<th>订单生成时间</th>
								<th>金额</th>
							</thead>
							<tbody>
							<!-- 遍历order对象 -->
							<tr>
								<td>1</td>
								<td>${orderlist.order_Id}</td>
								<td><a tabindex="0" style="text-decoration:none;" role="button" data-toggle="popover" data-html="true" data-trigger="focus" title="场地详细信息" data-container="body" 
	                      		data-content="场馆类别 : ${orderlist.order_VenueId.venue_Type}<br/>接待能力 : ${orderlist.order_VenueId.venue_Capacity}人<br/>开放时间 : ${orderlist.order_VenueId.venue_Open}:00<br/>关闭时间 : ${orderlist.order_VenueId.venue_Close}:00">${orderlist.order_VenueId.venue_Name}</a></td>
								<td>${orderlist.order_Date}  ${orderlist.order_St}:00-${orderlist.order_Ed}:00</td>
								<td>${orderlist.order_Mktime2}</td>
								<td>${orderlist.order_Price}</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
	
				<!-- 提交按钮 -->
				<!-- <button type="button " class="btn btn-default navbar-btn">确认预约</button> -->
				<div class="t_right">
					<button class="btn btn-default t_sub" type="button" onclick="cancelOrderlist()">取消订单</button>
					<button class="btn btn-default t_sub" type="submit">提交订单</button>
				</div>
			</form>
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
<script type="text/javascript">

	$(function () {
	    $('[data-toggle="popover"]').popover();
	});
	
	function cancelOrderlist(){
		//取消订单，将session清空即可
		Ewin.confirm({ message: "您确认要取消当前订单吗？" }).on(function (e) {
			if (e) {
				window.location.href="${pageContext.request.contextPath}/order?method=cancelOrder";
				}
			});
	}
	
	//引入的confirm
	(function($) {
		window.Ewin = function() {
			var html = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">'
					+ '<div class="modal-dialog modal-sm">'
					+ '<div class="modal-content">'
					+ '<div class="modal-header">'
					+ '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>'
					+ '<h4 class="modal-title" id="modalLabel">[Title]</h4>'
					+ '</div>'
					+ '<div class="modal-body">'
					+ '<p>[Message]</p>'
					+ '</div>'
					+ '<div class="modal-footer">'
					+ '<button type="button" class="btn btn-default cancel" data-dismiss="modal">[BtnCancel]</button>'
					+ '<button type="button" class="btn btn-primary ok" data-dismiss="modal">[BtnOk]</button>'
					+ '</div>' + '</div>' + '</div>' + '</div>';

			var dialogdHtml = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">'
					+ '<div class="modal-dialog">'
					+ '<div class="modal-content">'
					+ '<div class="modal-header">'
					+ '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>'
					+ '<h4 class="modal-title" id="modalLabel">[Title]</h4>'
					+ '</div>'
					+ '<div class="modal-body">'
					+ '</div>'
					+ '</div>' + '</div>' + '</div>';
			var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
			var generateId = function() {
				var date = new Date();
				return 'mdl' + date.valueOf();
			}
			var init = function(options) {
				options = $.extend({}, {
					title : "操作提示",
					message : "提示内容",
					btnok : "确定",
					btncl : "取消",
					width : 200,
					auto : false
				}, options || {});
				var modalId = generateId();
				var content = html.replace(reg, function(node, key) {
					return {
						Id : modalId,
						Title : options.title,
						Message : options.message,
						BtnOk : options.btnok,
						BtnCancel : options.btncl
					}[key];
				});
				$('body').append(content);
				$('#' + modalId).modal({
					width : options.width,
					backdrop : 'static'
				});
				$('#' + modalId).on('hide.bs.modal', function(e) {
					$('body').find('#' + modalId).remove();
				});
				return modalId;
			}

			return {
				alert : function(options) {
					if (typeof options == 'string') {
						options = {
							message : options
						};
					}
					var id = init(options);
					var modal = $('#' + id);
					modal.find('.ok').removeClass('btn-success').addClass(
							'btn-primary');
					modal.find('.cancel').hide();

					return {
						id : id,
						on : function(callback) {
							if (callback && callback instanceof Function) {
								modal.find('.ok').click(function() {
									callback(true);
								});
							}
						},
						hide : function(callback) {
							if (callback && callback instanceof Function) {
								modal.on('hide.bs.modal', function(e) {
									callback(e);
								});
							}
						}
					};
				},
				confirm : function(options) {
					var id = init(options);
					var modal = $('#' + id);
					modal.find('.ok').removeClass('btn-primary').addClass(
							'btn-success');
					modal.find('.cancel').show();
					return {
						id : id,
						on : function(callback) {
							if (callback && callback instanceof Function) {
								modal.find('.ok').click(function() {
									callback(true);
								});
								modal.find('.cancel').click(function() {
									callback(false);
								});
							}
						},
						hide : function(callback) {
							if (callback && callback instanceof Function) {
								modal.on('hide.bs.modal', function(e) {
									callback(e);
								});
							}
						}
					};
				},
				dialog : function(options) {
					options = $.extend({}, {
						title : 'title',
						url : '',
						width : 800,
						height : 550,
						onReady : function() {
						},
						onShown : function(e) {
						}
					}, options || {});
					var modalId = generateId();

					var content = dialogdHtml.replace(reg, function(node, key) {
						return {
							Id : modalId,
							Title : options.title
						}[key];
					});
					$('body').append(content);
					var target = $('#' + modalId);
					target.find('.modal-body').load(options.url);
					if (options.onReady())
						options.onReady.call(target);
					target.modal();
					target.on('shown.bs.modal', function(e) {
						if (options.onReady(e))
							options.onReady.call(target, e);
					});
					target.on('hide.bs.modal', function(e) {
						$('body').find(target).remove();
					});
				}
			}
		}();
	})(jQuery);
</script>
</html>