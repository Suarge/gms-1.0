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
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/Chart.min.css" rel="stylesheet">
    <title>bck_analytics</title>
    <style>
        html {
            overflow-x: hidden;
            overflow-y: hidden;
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

        /* 设置按钮间距 */
        .bt2 {
            margin-left: 10px;
        }

        /* 表单1调整 */
        .form1-tx {
            width: 50%;
        }

        .form1-bt {
            height: 26px;
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
                <form id="analytics_all" method="POST" action="${pageContext.request.contextPath}/admin?method=analytics_all">
                    <div class="col-sm-1"></div>
                    <div class="col-sm-4" style="margin-left:40px;">
                        <span>日期范围:</span>
                        <input size=13 type="text" class="date-st" id="date_st" name="date_st" value="${date_st}" readonly required>
                        <span>~</span>
                        <input size=13 type="text" class="date-ed" id="date_ed" name="date_ed" value="${date_ed}" readonly required>
                    </div>
                    <input type="hidden" name="currentPageStr1">
                    <div class="col-sm-2">
                        <span> 结果分类方式:</span>
                        <c:if test='${category=="venue"}'>
							<input type="radio" style="margin-left:5px;" class="control-label" id="type" value="type" name="category" />类型
                        	<input type="radio" style="margin-left:5px;" class="control-label" id="venue" value="venue" name="category" checked />场地
						</c:if>
						<c:if test='${category!="venue"}'>
							<input type="radio" style="margin-left:5px;" class="control-label" id="type" value="type" name="category" checked />类型
                        	<input type="radio" style="margin-left:5px;" class="control-label" id="venue" value="venue" name="category" />场地
						</c:if>
                    </div>
                    <div class="col-sm-1"></div>
                    <div class="col-sm-1">
                        <input type="submit" class="form1-bt btn btn-sm btn-primary" value="查询">
                    </div>
                </form>
            </div>
            <div class="row" style="margin-top: 25px;">
                <div class="col-sm-1">
                    <a class="carousel-control" style="padding-top: 385px;" href="#carousel-example-generic" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                </div>
                <div class="col-sm-10" style="width: 1035px; height:602px;">
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner" role="listbox">
                       		<c:forEach items="${analyticslist}" var="analytics" varStatus="vs" >
                       			<c:if test="${vs.count==1}">
                       				<div class="item active">	
								</c:if>	
                       			<c:if test="${vs.count!=1}">
                       				<div class="item">	
								</c:if>	
	                                <div class="row">
	                                    <div class="col-sm-6">
	                                        <div style="margin-left:0px; margin-top:15px; width: 280px; height:85px; border: 2px solid #f7f7f7;">
	                                            <div class="card card1" style="padding-top:3px;padding-left:15px;padding-right:15px;">
	                                            <div style="float:right;padding-top:14px;margin-right:-25px;">
	                                                <img style="width:65%;" src="${pageContext.request.contextPath}/img/renminbi.png">
	                                            </div>
	                                            <h5 class="">收入情况</h5>
	                                            <h3 style="font-weight: 700; margin-top:0px;">${analytics.analytics_Profit}</h3>
	                                            </div>
	                                        </div>
	                                        <div style="margin-left:120px; margin-top:15px; width: 280px; height:85px; border: 2px solid #f7f7f7;">
	                                            <div class="card card2" style="padding-top:3px;padding-left:15px;padding-right:15px;">
	                                            <div style="float:right;padding-top:14px;margin-right:-25px;">
	                                                <img style="width:65%;" src="${pageContext.request.contextPath}/img/rent-sign.png">
	                                            </div>
	                                            <h5 class="">租用人次</h5>
	                                            <h3 style="font-weight: 700; margin-top:0px;">${analytics.analytics_Rent}</h3>
	                                            </div>
	                                        </div>
	                                        <div style="margin-left:0px; margin-top:15px; width: 280px; height:85px; border: 2px solid #f7f7f7;">
	                                            <div class="card card3" style="padding-top:3px;padding-left:15px;padding-right:15px;">
	                                                <div style="float:right;padding-top:14px;margin-right:-25px;">
	                                                    <img style="width:65%;" src="${pageContext.request.contextPath}/img/percentage.png">
	                                                </div>
	                                                <h5 class="">使用率</h5>
	                                                <h3 style="font-weight: 700; margin-top:0px;">${analytics.analytics_Usage}</h3>
	                                            </div>
	                                        </div>
	                                        <div style="margin-left:120px; margin-top:15px; width: 270px; height:233px; border: 2px solid #f7f7f7;">
                                            <div class="card card4" style="padding: 5px;">
                                                <div style="padding:15px 15px; padding-top:7px; padding-bottom:5px;">
                                                    <div style="padding-top:3px;padding-left:15px;padding-right:15px;">
                                                        <canvas id="myDoughnut${vs.count}" width="220px" height="230px"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
	                                    </div>
	                                    <div class="col-sm-6">
	                                        <div class="card card5" style="border: 2px solid #f7f7f7; margin-top:5px; ">
	                                            <canvas id="myPie${vs.count}" width="400px" height="400px"></canvas>
	                                        </div>
	                                        <div style="text-align:center; width:373px; height:40px; margin-top:20px; padding-left: 100px;">
	                                            <span style="font-weight: 700; font-size:20px;">${analytics.analytics_Name}情况分析</span>
	                                        </div>
	                                    </div>
	                                </div>
                            	</div>
							</c:forEach>
                        </div>
                    </div> 
                </div>
                <div class="col-sm-1">
                    <a class="carousel-control" style="padding-top: 385px; margin-left:97px;" href="#carousel-example-generic" role="button"data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
            
        </div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/js/Chart.bundle.min.js"></script>
<script type="text/javascript">
    $(function () {
    	if("${empty analyticslist}"=="true"){
			$('input[name="category"]').val('type');
			$('#analytics_all').submit();
		};
		if("${empty analyticslist}"!="true"){
			<c:forEach items="${analyticslist}" var="analytics" varStatus="vs" >
				var id1="myDoughnut"+"${vs.count}";
				var datatext1="${analytics.analytics_Sexpercentage}";
				var data1=datatext1.split(" ");
				var id2="myPie"+"${vs.count}";
				var datatext2="${analytics.analytics_Agepercentage}";
				var data2=datatext2.split(" ");
				loaddoughnut(id1,data1);
				loadpie(id2,data2);
			</c:forEach>
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
          precss=['17px','445px','15px','224px'];
          //precss=['17px','475px','15px','224px'];
          wd='280px'; ht='85px';
        }else if(obj.hasClass('card2')){
          precss=['118px','345px','134px','102px'];
          wd='280px'; ht='85px';
        }else if(obj.hasClass('card3')){
          precss=['217px','245px','15px','224px'];
          wd='280px'; ht='85px';
        }else if(obj.hasClass('card4')){
          precss=['317px','1px','135px','112px'];
          wd='269px'; ht='228px';
        }else{
          precss=['6px','60px','16px','17px'];
          wd='484px'; ht='486px';
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
    
    //设置日期控件
    $(".date-st").datetimepicker({
        format: 'yyyy-mm-dd h:00',
        autoclose: true,
        todayBtn: true,
        todayHighlight: true,
        minView: 1,
        initialDate: new Date()
    }).on('changeDate', function (ev) {
        //设置截止日期不能小于开始日期
        $('.date-ed').datetimepicker('setStartDate', ev.date);
    });
    $(".date-ed").datetimepicker({
        format: 'yyyy-mm-dd h:00',
        autoclose: true,
        todayBtn: true,
        todayHighlight: true,
        minView: 1,
        initialDate: new Date()
    });
    
    function loadpie(id,mydata){
        var data = {
            labels: ['0~19', '20~29', '30~39', '40~49', '50~59','60以上'],
            datasets: [
                {
                    data: mydata,
                    backgroundColor: [
//                         'rgba(255, 99, 132, 0.7)',
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
                text: '订单年龄分布'
            }
        };
        var ctx = document.getElementById(id).getContext("2d");
        var currentMonthChart = new Chart(ctx,{
            type: 'pie',//doughnut是甜甜圈?图形,pie是饼状图
            data: data,
            options:options
        });
    }

    function loaddoughnut(id,mydata){
        var data = {
            labels: ['男', '女'],
            datasets: [
                {
                    data: mydata,
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 99, 132, 0.7)',
                    ]
                }
            ]
        };
        var options = {
            title: {
                display: true,
                text: '男女欢迎度'
            }
        };
        var ctx = document.getElementById(id).getContext("2d");
        var currentMonthChart = new Chart(ctx,{
            type: 'doughnut',//doughnut是甜甜圈?图形,pie是饼状图
            data: data,
            options:options
        });

    }
</script>

</html>
