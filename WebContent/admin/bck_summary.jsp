<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/Chart.min.css" rel="stylesheet">
    <title>bck_summary</title>
    <style>
        html {
            overflow-x: hidden;
        }

        /* 清除面板边框 */
        .panel-default {
            border: 0px;
        }

        /* 控制面板间距 */
        .panel-body {
            margin: 0px 10px;
            width: 1410px;
        }
        
        /* 控制整体位置 */
        .bk{
          position: absolute;
          z-index: 99;
          border-radius:10px;
        }
        .bk_1{
          height: 0px;
          border-left: 2px solid #0099FF;
        }
        .bk_2 {
          width: 0px;
          border-top: 2px solid #0099FF;
        }
        .bk_3{
          height: 0px;
          border-right: 2px solid #0099FF;
        }
        .bk_4{
          width:0px;
          border-bottom: 2px solid #0099FF;
        }
    </style>
</head>

<body>
    <div class="panel panel-default">
        <div class="panel-body container">
            <div class="row">
                <div class="col-sm-3" style="margin-left: 115px;">
                    <div style="margin-left:0px; margin-top:3px; width: 280px; height:85px; border: 2px solid #f7f7f7;">
                        <div class="card card1" style="padding-top:3px;padding-left:15px;padding-right:15px;">
                            <div style="float:right;padding-top:14px;margin-right:-25px;">
                                <img style="width:65%;" src="${pageContext.request.contextPath}/img/paw-print.png">
                            </div>
                            <h5 class="">网站今日访问量</h5>
                            <h3 style="font-weight: 700; margin-top:0px;">${summaryTodayVistors}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3" style="margin-left: 35px;">
                    <div style="margin-left:0px; margin-top:3px; width: 280px; height:85px; border: 2px solid #f7f7f7;">
                        <div class="card card1" style="padding-top:3px;padding-left:15px;padding-right:15px;">
                            <div style="float:right;padding-top:14px;margin-right:-25px;">
                                <img style="width:65%;" src="${pageContext.request.contextPath}/img/reserved.png">
                            </div>
                            <h5 class="">今日预约量</h5>
                            <h3 style="font-weight: 700; margin-top:0px;">${summaryTodayOrderCount}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3" style="margin-left: 35px;">
                    <div style="margin-left:0px; margin-top:3px; width: 280px; height:85px; border: 2px solid #f7f7f7;">
                        <div class="card card1" style="padding-top:3px;padding-left:15px;padding-right:15px;">
                            <div style="float:right;padding-top:14px;margin-right:-25px;">
                                <img style="width:65%;" src="${pageContext.request.contextPath}/img/income.png">
                            </div>
                            <h5 class="">今日收入</h5>
                            <h3 style="font-weight: 700; margin-top:0px;">${summaryTodayOrderProfit}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="width: 1400px; height:600px;">
                    <div class="row">
                        <div class="col-sm-6" style="width:600px;margin-left:68px;">
                            <div style="padding:20px 20px;">
                                <div class="card card2" style="border: 2px solid #f7f7f7; margin-top:5px; padding:10px 10px; padding-top:0px;">
                                    <canvas id="mysummaryChart" width="200px" height="200px"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5" >
                            <div style="padding:20px 20px;">
                                <div class="card card3" style="border: 2px solid #f7f7f7; margin-top:5px; ">
                                    <canvas id="mysummaryPie" width="200px" height="200px"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6" style="width:1230px;">
                    <div class="panel panel-default">
                        <div class="panel-heading">最近预约订单</div>
                        <div class="panel-body" style="padding-left: 0px; margin-left:0px; padding-bottom:0px;">
                            <table class="table table-hover" style="width:1200px;">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>预约人</th>
                                        <th>预约场地</th>
                                        <th>场地类别</th>
                                        <th>预约创建时间</th>
                                        <th>预约价格</th>
                                        <th>订单状态</th>
                                    </tr>
                                </thead>
                                <tbody>
	                                <c:forEach items="${latest_orderlist}" var="order" varStatus="vs" >
					             		<tr>
							                <th scope="row">${vs.count}</th>
							                <td>${order.order_UserId.user_Id}</td>
							                <td>${order.order_VenueId.venue_Name}</td>
							                <td>${order.order_VenueId.venue_Type}</td>
							                <td>${order.order_Mktime2}</td>
							                <td>${order.order_Price}</td>
											<c:if test="${order.order_State==0}">
												<td><span class="label label-warning" style="padding: 8px; font-size:85%">进行中</span></td>
											</c:if>	
							                <c:if test="${order.order_State==1}">
												<td><span class="label label-danger" style="padding: 8px; font-size:85%">已取消</span></td>
											</c:if>
											<c:if test="${order.order_State==2}">
												<td><span class="label label-success" style="padding: 8px; font-size:85%">已成功</span></td>
											</c:if>	
						                 </tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/Chart.bundle.min.js"></script>
<script type="text/javascript">
	$(function(){
		if("${empty summaryTodayVistors}"=="true"){
            this.location.href="${pageContext.request.contextPath}/admin?method=summary_all";
       	};
       	if("${empty summaryTodayVistors}"!="true"){
			var datatext="${summary_orderCountByDateAndVen_val}";
			var datapie=datatext.split(" ");
			var datatext2="${summary_venueVisCountByDate_ti}";
			var data2=datatext2.split(" ");
			var datatext3="${summary_venueVisCountByDate_val}";
			var data3=datatext3.split(" ");
			loadpie('mysummaryPie',datapie);
			loadchart('mysummaryChart',data2,data3);
		};
	});
	
	//边框效果改变
	function biankuang(obj,time,wd,ht){
	  for(let i=1;i<5;i++){
	    let str = ".bk_"+i;
	    if(i%2==0){
	      //上下调整宽
	      $(obj).find(str).stop(true).animate({
	        width: wd
	      },time)
	    }
	    else{
	      $(obj).find(str).stop(true).delay(time).animate({
	        height: ht
	      },time)
	    }
	  }
	}
	//触发
	$('.card').hover(
	  function () {
	    var obj = $(this);
	    //动态添加边框div
	    if(obj.hasClass('withclass')==false){
	      obj.prepend(`
	        <div class="bk bk_1"></div>
	        <div class="bk bk_2"></div>
	        <div class="bk bk_3"></div>
	        <div class="bk bk_4"></div>
	      `)
	      obj.addClass('withclass')
	    }
	    let precss,wd,ht;
	    //设置边框的上下左右偏移
	    if(obj.hasClass('card1')){
	      precss=['1px','1px','14px','58px'];
	      wd='279px'; ht='84px';
	    }else if(obj.hasClass('card2')){
	      precss=['26px','20px','34px','34px'];
	      wd='530px'; ht='517px';
	    }else{
	      precss=['26px','20px','34px','34px'];
	      wd='514px'; ht='512px';
	    }
	    $(".bk_1").css('top',precss[0])
	    $(".bk_1").css('left',precss[2])
	    $(".bk_2").css('bottom',precss[1])
	    $(".bk_2").css('left',precss[2])
	    $(".bk_3").css('bottom',precss[1])
	    $(".bk_3").css('right',precss[3])
	    $(".bk_4").css('top',precss[0])
	    $(".bk_4").css('right',precss[3])

	    //设置边框的长和宽
	    biankuang(obj,300,wd,ht);
	  },
	  function () {
	    var obj = $(this);
	    biankuang(obj,100,'0px','0px');
	  }
	);
	
    function loadchart(id,mydata1,mydata2) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: mydata1,
                datasets: [{
                    label: '访问量',
                    data: mydata2,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 59, 4, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(255, 59, 4, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                },
                title: {
                    display: true,
                    text: '近7日流量分析'
                }
            }
        });
    }
   
    function loadpie(id,mydata){
        var data = {
            labels: ['乒乓球场','排球场', '篮球场','网球场', '羽毛球场'],
            datasets: [
                {
                    data: mydata,
                    backgroundColor: [
                    	 'rgba(54, 162, 235, 0.7)',
                         'rgba(255, 206, 86, 0.7)',
                         'rgba(75, 192, 192, 0.7)',
                         'rgba(153, 102, 255, 0.7)',
                         'rgba(255, 159, 64, 0.7)',
                         'rgba(255, 12, 24, 0.7)'
                    ]
                }
            ]
        };
        var options = {
            title: {
                display: true,
                text: '订单场馆分布'
            }
        };
        var ctx = document.getElementById(id).getContext("2d");
        var currentMonthChart = new Chart(ctx,{
            type: 'pie',//doughnut是甜甜圈?图形,pie是饼状图
            data: data,
            options:options
        });
    }
</script>

</html>