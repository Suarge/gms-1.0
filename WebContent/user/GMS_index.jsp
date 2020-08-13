<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>体育管场地管理系统</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/toast.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SMS-index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/button.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/showMessage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
</head>
<body>
	<!--引入头部-->
	<div class="header">
		<div class="real_header">
			<a href="#" style="text-decoration: none; color: #337ab7;"> <img
				src="${pageContext.request.contextPath }/img/logo.png"
				class="head_img"> <span class="head_span1">体育馆场地管理系统</span>
			</a>
			<div class="login">
				<!-- 用户名为空展示 -->
				<c:if test="${empty user }">
					<div>
						<a href="${pageContext.request.contextPath }/user/login.jsp" style="margin-left: -60px;">登录
						</a>
					</div>
					<div class="dropdown" style="margin-top: -22px;">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"
							role="button" aria-haspopup="true" aria-expanded="false"> <i
							class="glyphicon glyphicon-user"></i> 个人中心
						</a>
						<ul class="dropdown-menu " aria-labelledby="dropdownMenu1">
							<li>
<%-- 								<a href="${pageContext.request.contextPath}/order?method=pageOrderList" target="_blank" data-toggle="modal" > --%>
<!-- 									<i class="glyphicon glyphicon-user"></i> -->
<!-- 									个人中心 -->
<!-- 								</a> -->
								<a href="" data-toggle="modal" >
									<i class="glyphicon glyphicon-user"></i>
									个人中心
								</a>
							</li>
							<li role="separator" class="divider"></li>
							<li>
								<a href="">
									<i class="glyphicon glyphicon-off"></i>
									注销登录
								</a>
							</li>
						</ul>
					</div>
				</c:if>
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
			<p style="width: 1000px; margin: 0 auto; height: 30px; line-height: 30px;">
				<img style="margin-left: -6px;" src="${pageContext.request.contextPath }/img/laba.png"> 
				<span id="topnotice">通知：
				
				</span>
			</p>
		</div>
	</div>

	<!-- 展示栏 -->
	<div class="container" style="margin-top: 36px;">
		<div class="row " style="margin-top: 10px;">
			<div class="col-lg-8" style="background-color: #FFFFFF;">
				<!-- 场馆类型标签页 -->
				<ul class="nav nav-tabs" id="myTab"  style="margin-top: 5px;">
					<!-- ajax加载 -->
					<!-- <li class="active"><a href="#乒乓球场"  data-toggle="tab" onclick="findVenueByIdAndTime(this)">乒乓球场</a></li> -->
				</ul>
				<!-- 场馆展示页 -->
				<div class="tab-content row" id="message">
				
				<!-- ajax加载 -->
					<%--  <div role="tabpanel" class="tab-pane fade in active" id="乒乓球场" >
						<div class="col-lg-6 tab_div1" >
							<img src="${pageContext.request.contextPath}/img/playground.jpg" class="tab_img" >
						</div>
						<div class="col-lg-6 tab_div2" >
							<p class="tab_p">联系人: 王老师</p>
							<p class="tab_p">联系电话: 13856992553</p>
							<p class="tab_p" >场地地址: 航空港乒乓球场地</p>
							<p class="tab_p tab_p_area" >
								篮球训练馆，位于体育馆主馆负一层西北侧，面积814.56㎡，内有标准篮球场地一块，可进行篮球、排球、乒乓球、羽毛球等专业比赛，现为...
							</p>
						</div>
					</div>   --%>
					
				</div>

			</div>
			<!-- 通知公告 -->
			<div class="col-lg-4"
				style="background-color: #FFFFFF; border-left: solid 10px; color: #f0f4f7;">
				<p class="pig" style="border-bottom: 1px solid #e8e8e8; padding-bottom: 8px;">
					<span style="color: #333; font-size: 16px;">通知公告</span> 
					<a class="pull-right" href="#" style="padding: 0 0px; color: #666; text-decoration: none;"></a><!-- 更多>> -->
				</p>
				<div class="nave">
				
					<ul id="noticeList" style="list-style-type: none; margin: 0; padding: 0;">
						<!-- <li><a href="#"><span>关于支付宝充值异常的通知</span></a> <span class="pull-right text-color">04-22 </span></li>
						<li><a href="#"><span>关于充值标准调整的通知</span></a> <span class="pull-right text-color">06-20 </span></li>
						<li><a href="#"><span>关于恢复网络充值的通知</span></a> <span class="pull-right text-color">06-20 </span></li>
						<li><a href="#"><span>关于综合馆营业时间调整的通知</span></a> <span class="pull-right text-color">05-03 </span></li>
						<li><a href="#"><span>游泳馆及综合馆闭馆通知</span></a> <span class="pull-right text-color">06-01 </span></li>
						<li><a href="#"><span>关于暂停网络充值的通知</span></a> <span class="pull-right text-color">05-21 </span></li>
						<li><a href="#"><span>关于暂停网络充值的通知</span></a> <span class="pull-right text-color">05-21 </span></li> -->
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12 "
				style="background-color: #FFFFFF; margin-top: 10px;">
				<div class=" state" style="margin-top: 10px;">
					<span class="first" style="background: #fdb75d; margin-left: 5px;"></span><span>已预约</span>
					<span class="first" style="background: #22cf9c; margin-left: 20px;"></span><span>已选</span>
					<span class="first"
						style="background: #fff; border: 1px solid #999; margin-left: 20px;"></span><span>可预约</span>
					<span class="first" style="background: #ccc; margin-left: 20px;"></span><span>不可用</span>
					<!-- 日期插件 -->
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<span id="nowdayone"></span>
								<!-- 将获得的日期放到这里 -->
								<input type="hidden" id = "swiper_tex" value="">
							</div>
							<div class="swiper-slide">
								<span id="nextdayone"></span>
							</div>
							<div class="swiper-slide">
								<span id="nextdaytwo"></span>
							</div>
						</div>
						<!-- 如果需要导航按钮 -->
						<div class="swiper-button-prev "
							style="color: #CCCCCC !important;"></div>
						<div class="swiper-button-next "
							style="color: #CCCCCC !important;"></div>
					</div>
					<div class="sub_for" style="margin-top: -36px;">
						<a style="text-decoration: none; margin-top: 13px; float: right; margin-right: 4px; background-color: #35bbfb;"
							onclick="submitIfExits()" target="_blank" class="button button-primary button-pill button-small">去预约
						</a>
						
						<!-- 定义多个隐藏域来保存获得的场馆信息 -->
						<form id="hiddenForm" action="${pageContext.request.contextPath}/order?method=confirmOrder" method="post">
							<!-- 传递场馆编号过去 加上时间就可以获得场馆对象-->							
							<input type="hidden" id = "venue_id" name="venue_id" value=""> 
							<input type="hidden" id = "order_Date" name="order_Date" value="">
							<input type="hidden" id = "order_Price" name="order_Price" value="">
							<input type="hidden" id = "order_St" name="order_St" value="">
							<input type="hidden" id = "order_Ed" name="order_Ed" value="">
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<!--order没有使用 -->
				<div
					style="background: #fff; padding: 15px; padding-top: 10px; position: relative;">
					<div style="width: 100%;">
						<!--overflow-x: scroll-->
						<table class="firstTable" id="venue_data">
							<!--场地时间安排-->
							<tr class="first firstTitle" style="background: #f0f4f7; line-height: 12px;">
								<td style="min-width: 90px; height: 50px;">场地</td>
								<td>9:00<br>-<br>10:00</td>
								<td>10:00<br>-<br>11:00</td>
								<td>11:00<br>-<br>12:00</td>
								<td>12:00<br>-<br>13:00</td>
								<td>13:00<br>-<br>14:00</td>
								<td>14:00<br>-<br>15:00</td>
								<td>15:00<br>-<br>16:00</td>
								<td>16:00<br>-<br>17:00</td>
								<td>17:00<br>-<br>18:00</td>
								<td>18:00<br>-<br>19:00</td>
							</tr>
							<!--场地信息-->
							<!-- <tr class="first del">
								点击获得
								<td class="place">篮球半场1</td>
								<td><span class="gray" data-num="1" type-name="篮球馆" data-name="篮球半场1" data-data="2019-1-5" data-stime="9" data-etime="10"></span></td>
								<td><span class="gray" data-num="1" type-name="篮球馆" data-name="篮球半场1" data-data="2019-1-5" data-stime="9" data-etime="10"></span></td>
								<td><span class="gray" data-num="1" type-name="篮球馆" data-name="篮球半场1" data-data="2019-1-5" data-stime="9" data-etime="10"></span></td>
								<td><span class="gray" data-num="1" type-name="篮球馆" data-name="篮球半场1" data-data="2019-1-5" data-stime="9" data-etime="10"></span></td>
							</tr> -->
							
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid f_top">
		<div class="row">
			<!--<div style="border:solid ;color: #EC971F"></div>-->
			<div class="footer" style="position: relative;">
				版权所有©GMS-体育馆场地管理系统 &nbsp;&nbsp;&nbsp;</div>
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/toast.js"></script>
<script type="text/javascript">

	$(function(){
		var now = new Date();
		var nowday = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
		var nextday = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+(now.getDate()+1);
		var nextnextday = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+(now.getDate()+2);
		//设置当前日期
		$('#nowdayone').html(nowday);
		$('#swiper_tex').attr("value",nowday);
		$('#nextdayone').html(nextday);
		$('#nextdaytwo').html(nextnextday);

		//获取当天日期放入隐藏域
		var swiper = new Swiper('.swiper-container', {
			nextButton : '.swiper-button-next',
			prevButton : '.swiper-button-prev',
			speed : 600,
			onSlideChangeEnd : function(swiper) { // 触发slider切换的回调函数
				var tex = $('.swiper-slide-active span').html();
				$('#swiper_tex').attr("value",tex);
				//选择完日期后调用场馆函数展示
				findVenueByIdAndTime($('#myTab').find("li.active a"));
			}
		});
		
		//页面加载场馆通知
		var no_content="";
		var topContent=""; 
		$.ajax({
			   type: "POST",
			   url: "${pageContext.request.contextPath}/order?method=noticeList",
			   success: function(data){
				   for(var i=0;i<7;i++){
					   no_content+="<li><a href='${pageContext.request.contextPath}/order?method=viewNotice&noticeId="+data[i].notice_Id+"'><span>"+data[i].notice_Title+"</span></a> <span class='pull-right text-color'>"+data[i].notice_Time+"</span></li>";
				   }
				   $('#noticeList').append(no_content);
				   
				   topContent+="<a href='${pageContext.request.contextPath}/order?method=viewNotice&noticeId="+data[0].notice_Id+"' style='color: red;'>"+data[0].notice_Title+"</a>"
				   $('#topnotice').append(topContent);
				
			   },
// 			   async: false,
			   dataType:"json"
			});
		
		
		//页面加载场馆类型
		var liContent = "";//场馆名id='"+i+ball+"'
		var divContent = "";//场馆的展示信息
		
		$.ajax({
			   type: "POST",
			   url: "${pageContext.request.contextPath}/order?method=typeList",
			   success: function(data){
				   for(var i = 0;i<data.length;i++){
						if(i==0){
							liContent+="<li class='active'><a href='#"+data[i].type_Name+"' id='"+data[i].type_Name+"' value='"+data[i].type_Name+"' data-toggle='tab' onclick='findVenueByIdAndTime(this)'>"+data[i].type_Name+"</a></li>";
							
							divContent+="<div role='tabpanel' class='tab-pane fade in active' id='"+data[i].type_Name+"'><div class='col-lg-6 tab_div1' >"
							+"<img src='${pageContext.request.contextPath}/img/playground"+i+".jpg' class='tab_img'></div>"
							+"<div class='col-lg-6 tab_div2' ><p class='tab_p'>联系人: "+data[i].type_Linkman+"</p><p class='tab_p'>联系电话: 13856992553</p>"
							+"<p class='tab_p' >场地地址: "+data[i].type_Address+"</p><p class='tab_p tab_p_area' >"+data[i].type_Introduction+"</p></div></div>";
						}else{
							liContent+="<li><a href='#"+data[i].type_Name+"' value='"+data[i].type_Name+"' data-toggle='tab' onclick='findVenueByIdAndTime(this)'>"+data[i].type_Name+"</a></li>";
							
							divContent+="<div role='tabpanel' class='tab-pane fade' id='"+data[i].type_Name+"'><div class='col-lg-6 tab_div1' >"
							+"<img src='${pageContext.request.contextPath}/img/playground"+i+".jpg' class='tab_img'></div>"
							+"<div class='col-lg-6 tab_div2' ><p class='tab_p'>联系人: "+data[i].type_Linkman+"</p><p class='tab_p'>联系电话: 13856992553</p>"
							+"<p class='tab_p' >场地地址: "+data[i].type_Address+"</p><p class='tab_p tab_p_area' >"+data[i].type_Introduction+"</p></div></div>";
						}
					};
					$("#myTab").append(liContent);
					$("#message").append(divContent);
					//判断标识符,如果为空,表示是第一次访问，将乒乓球场的this传递给函数
					if("${empty flag}"=="true"){
						//通过document.getElementById('乒乓球场')来获得this 调用函数
						findVenueByIdAndTime(document.getElementById('乒乓球场'));
					};
			   },
			   async: false,
			   dataType:"json"
			});
		
	});
	//页面加载结束
	
	// 标签页
	$('#myTab a').click(function(e) {
		e.preventDefault();
		$(this).tab('show');
	});
	
	//获得所有场馆
	function findVenueByIdAndTime(id){
		var currentDate = $('#swiper_tex').attr("value");
		var venueName = $(id).text();
		
		//判断当前是否存在表格tr，如果有就清空
		var isdel = document. getElementsByClassName('del');
		if(isdel){
			$(".del").empty();
		}
		
		//通过ajax异步获取当前日期和所选择场馆类型的所有场馆信息
		var venueContent = "";
		$.ajax({
			   type: "POST",
			   url: "${pageContext.request.contextPath}/order?method=venueList",
			   data: {currentDate:currentDate,venueName:venueName},
			   success: function(data){
				   for(var i = 0;i<data.length;i++){
						//获得分时状态 指定时间是9:00-19:00期间
						venueContent+="<tr class='first del'><td class='place'>"+data[i].venue_name+"</td>";
						//获得分时状态字段
						var vdstate = data[i].vdstate_st;
						for(var j = 9;j<vdstate.length-4;j++){
							 if(vdstate[j]==0){
								//表示当前场馆不可用
								venueContent+="<td><span id ="+data[i].venue_name+j+" j_id ="+j+" class='gray' venue_id="+data[i].venue_id+" venue_type="+data[i].venue_type+" venue_name="+data[i].venue_name+" vdstate_date="+data[i].vdstate_date+" venue_price="+data[i].venue_price+" ><img class='blank' src='${pageContext.request.contextPath }/img/dui.png' /></span></td>";
							}else if(vdstate[j]==1){
								//表示当前场馆可用
								//判断当前的id和放入全局变量的id是否一样
								if((data[i].venue_name+j+data[i].vdstate_date)==state)
									venueContent+="<td><span id ="+data[i].venue_name+j+data[i].vdstate_date+" j_id ="+j+" class='green' venue_id="+data[i].venue_id+" venue_type="+data[i].venue_type+" venue_name="+data[i].venue_name+" vdstate_date="+data[i].vdstate_date+" venue_price="+data[i].venue_price+"><img src='${pageContext.request.contextPath }/img/dui.png' /></span></td>";
								else 
									venueContent+="<td><span id ="+data[i].venue_name+j+data[i].vdstate_date+" j_id ="+j+" class='white' venue_id="+data[i].venue_id+" venue_type="+data[i].venue_type+" venue_name="+data[i].venue_name+" vdstate_date="+data[i].vdstate_date+" venue_price="+data[i].venue_price+"><img class='blank' src='${pageContext.request.contextPath }/img/dui.png' /></span></td>";
							}else{
								//表示当前场馆已被预约
								venueContent+="<td><span id ="+data[i].venue_name+j+data[i].vdstate_date+" j_id ="+j+" class='yellow' venue_id="+data[i].venue_id+" venue_type="+data[i].venue_type+" venue_name="+data[i].venue_name+" vdstate_date="+data[i].vdstate_date+" venue_price="+data[i].venue_price+"><img class='blank' src='${pageContext.request.contextPath }/img/dui.png' /></span></td>";
							}	
							
						}
						venueContent+="</tr>"; 
					} 
				   $('#venue_data').append(venueContent);
			   },
			   async: false,
			   dataType:"json"
		});
		
	}
	
	//设置计数变量
	var count = 0;
	//设置是否是绿色的状态  
	var state ="";

	//获得点击表格的各种属性
	$("table.firstTable").on("click",'td span',function(){
		
		//获得场馆编号
 		var venue_id = $(this).attr('venue_id');
		//获得当前场馆的价格
		var venue_price = $(this).attr('venue_price');
		//获得日期yyyy-MM-dd
		var vdstate_date = $(this).attr('vdstate_date');
		//获得当前的id  9-18     后面取消的时候传递id过来，id代表vdstate_st的第几位，把状态改为1  表示可用
		var j_id = $(this).attr("j_id");
		//获得选择的开始结束时间
		var stime = 0;
		var etime = 0;
		switch(parseInt(j_id)){   
			case 9  : stime = 9 ; etime = 10;break;
			case 10 : stime = 10; etime = 11;break;
			case 11 : stime = 11; etime = 12;break;
			case 12 : stime = 12; etime = 13;break;
			case 13 : stime = 13; etime = 14;break;
			case 14 : stime = 14; etime = 15;break;
			case 15 : stime = 15; etime = 16;break;
			case 16 : stime = 16; etime = 17;break;
			case 17 : stime = 17; etime = 18;break;
			case 18 : stime = 18; etime = 19;break;
			default : break;
		}
		
		//选择预约的场馆
		if ($(this).attr('class') == 'green') {
			//把√隐藏
			$(this).find('img').addClass('blank');
			$(this).removeClass('green');
			$(this).addClass('white');
			//清空加到隐藏域中的属性
			//计数器减一
			count--;
 			$('#venue_id').attr("value","");
			$('#order_Price').attr("value","");
			$('#order_Date').attr("value","");
			$('#order_St').attr("value","");
			$('#order_Ed').attr("value","");
			//将加入的状态全部还原
			state = ""; 
// 			venue_t = "";
		} else {
			if(count==1){
				showMessage('一次只能预约一个场地',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
				return ;
			}
			//如果没有订单生成
			if("${empty orderlist}"=="true"){
				if ($(this).attr('class') == 'white') {
					//把√显示出来
					$(this).find('img').removeClass('blank');
					$(this).addClass('green');
					$(this).removeClass('white');
					
					//如果是白色的话，才将上面的信息加到指定区域
	 				$('#venue_id').attr("value",venue_id);
					$('#order_Price').attr("value",venue_price);
					$('#order_Date').attr("value",vdstate_date);
					$('#order_St').attr("value",stime);
					$('#order_Ed').attr("value",etime);
					//将计数加一
					count++;
					//给状态赋值 唯一值 （场馆名+id+日期）  和当前场馆类型
	 				state = $(this).attr('id');
				}
			}else{
				showMessage('您还有订单未完成，请先完成或取消预约',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
				return;
			}
			
		}
		
	});
	
	
	//提交预约订单
	function submitIfExits(){
		//场馆编号id
		var venue_id = $('#venue_id').attr("value");
		//判断如果没有选择场馆
		if(venue_id==""||venue_id==undefined){
			showMessage('请选择您要预约的场馆',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
		}else{
			if("${empty user}"=="true"){
				showMessage('请登录后再预约',2000,true,'bounceIn-hastrans','bounceOut-hastrans');
			}else{
				$('#hiddenForm').submit();
			}
		}
	}
	
</script>

</html>