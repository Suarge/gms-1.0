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
    <title>bck_order</title>
    <style>
        html { overflow-x:hidden; }
        .table {
            margin-left: 10px;
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

        /* 设置发布通知按钮间距 */
        .preadd-btn {
            margin-left: 127px;
        }

        table tbody tr td:last-of-type {
            
            border-bottom: 1px solid;
            border-color: #e3e3e3;
        }
    </style>
</head>

<body>
    <div class="panel panel-default">
        <div class="panel-body container">
            <div class="row">
                <div class="col-sm-4">
                    <form id="query_order" method="POST" action="${pageContext.request.contextPath}/admin?method=query_order">
                        <span>关键字查询:</span>
                        <input type="text" class="form1-tx" id="query_key" name="query_key" value="${query_key}">
                        <input type="hidden" id="currentPage" name="currentPage" value="${pageBean_order.currentPage}">
                        <input type="hidden" id="currentCount" name="currentCount" value="${pageBean_order.currentCount}">
                        <input type="hidden" id="sort_state" name="sort_state" value="${sort_state}">
                        <input type="submit" class="form1-bt btn btn-sm btn-primary" value="查询">
                    </form>
                </div>
                <div class="col-sm-4"></div>
                <div class="col-sm-2" style="padding-left: 30px;">
                    <button type="button" onclick="export_order()"
                        class="preadd-btn btn btn-warning btn-sm">导出数据</button>
                </div>
            </div>
        </div>
        <!-- Table -->
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>#</th>
                    <th>预约场地</th>
                    <th>场地类别</th>
                    <th>预约人</th>
                    <th>预约日期<img id="dd" onclick="change_sort(this)" style="margin-bottom:2px;margin-left:2px;" src="${pageContext.request.contextPath}/img/sort.png"></th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>预约价格<img id="pp" onclick="change_sort(this)" style="margin-bottom:2px;margin-left:2px;" src="${pageContext.request.contextPath}/img/sort.png"></th>
                    <th>预约生成时间<img id="tt" onclick="change_sort(this)" style="margin-bottom:2px;margin-left:2px;" src="${pageContext.request.contextPath}/img/sort.png"></th>
                    <th>预约状态</th> 
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${pageBean_order.list}" var="order" varStatus="vs" >
             		<tr>
		                <th scope="row">${vs.count+pageBean_order.currentCount*pageBean_order.currentPage-pageBean_order.currentCount}</th>
		                <td>${order.order_VenueId.venue_Name}</td>
		                <td>${order.order_VenueId.venue_Type}</td>
		                <td><a tabindex="0" style="text-decoration:none;" role="button" data-toggle="popover" data-html="true" data-trigger="focus" title="用户详细信息" data-container="body" 
	                       data-content="学号 : ${order.order_UserId.user_Id}<br/>邮箱 : ${order.order_UserId.user_Email}<br/>性别 : ${order.order_UserId.user_Sex}<br/>年龄 : ${order.order_UserId.user_Age}岁">${order.order_UserId.user_Id}</a></td>
		                <td>${order.order_Date}</td>
		                <td>${order.order_St}:00</td>
		                <td>${order.order_Ed}:00</td>
		                <td>${order.order_Price}</td>
		                <td>${order.order_Mktime2}</td>
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
        <div class="container" style="width: 1410px;">
            <div class="row">
                <div class="col-sm-9" style="margin-top:23px;">
                    <div class="row">
                        <div class="col-sm-5" style="padding-right: 0px; width:300px">
                            <span style="font-size: 20px;">当前总共有${pageBean_order.totalCount}条数据,每页显示</span>
                        </div>
                        <div class="col-sm-2" style="padding-left: 10px;padding-right:0px; width:55px;">
                            <div class="dropdown showpagenum">
                                <button class="btn btn-default dropdown-toggle" style="height: 27px; padding-top:3px;"
                                    type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="true">
                                    <span style="display:inline-block;width:11px;">${pageBean_order.currentCount}</span>
                                    <span class="caret" style="margin-left: 3px;"></span>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1"
                                    style="min-width: 41px;">
                                    <li><a href="javascript:void(0);" onclick="changeShowPageNum('5')"
                                            style="display:none; padding-left:14px;">5</a></li>
                                    <li><a href="javascript:void(0);" onclick="changeShowPageNum('7')"
                                            style="padding-left:14px;">7</a></li>
                                    <li><a href="javascript:void(0);" onclick="changeShowPageNum('10')"
                                            style="padding-left:14px;">10</a></li>
                                    <li><a href="javascript:void(0);" onclick="changeShowPageNum('15')"
                                            style="padding-left:14px;">15</a></li>
                                    <li><a href="javascript:void(0);" onclick="changeShowPageNum('20')"
                                            style="padding-left:14px;">20</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-4" style="padding-left: 20px;">
                            <span style="font-size: 20px;">条数据</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3" style="margin-left:-60px;">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                           <!-- 判断当前页是否是第一页 -->
							<c:if test="${pageBean_order.currentPage==1 }">
								<li class="disabled">
									<a href="javascript:void(0);" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pageBean_order.currentPage!=1 }">
								<li>
									<a href="javascript:void(0);" onclick="changePage(${pageBean_order.currentPage-1})" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
				             
				             <c:if test="${pageBean_order.totalPage<=5 }">
								<c:forEach begin="1" end="${pageBean_order.totalPage }" var="page">
									<!-- 判断当前页 -->
									<c:if test="${pageBean_order.currentPage==page }">
										<li class="active"><a href="javascript:void(0);">${page}</a></li>
									</c:if>
									<c:if test="${pageBean_order.currentPage!=page }">
										<li><a href="javascript:void(0);" onclick="changePage(${page})">${page}</a></li>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test="${pageBean_order.totalPage>5 && pageBean_order.currentPage==1}">
								<li class="active"><a href="javascript:void(0);">1</a></li>
								<li><a href="javascript:void(0);" onclick="changePage('2')">2</a></li>
								<li><a href="javascript:void(0);" onclick="changePage('3')">3</a></li>
								<li><a href="javascript:void(0);" onclick="changePage('4')">4</a></li>
								<li><a href="javascript:void(0);" onclick="changePage('5')">...</a></li>
							</c:if>
							<c:if test="${pageBean_order.totalPage>5 && pageBean_order.totalPage-pageBean_order.currentPage<3}">
								<c:forEach begin="${pageBean_order.totalPage-3}" end="${pageBean_order.totalPage }" var="page">
									<!-- 判断当前页 -->
									<c:if test="${pageBean_order.currentPage==page }">
										<li class="active"><a href="javascript:void(0);">${page}</a></li>
									</c:if>
									<c:if test="${pageBean_order.currentPage!=page }">
										<li><a href="javascript:void(0);" onclick="changePage(${page})">${page}</a></li>
									</c:if>
								</c:forEach>
								<li><a href="javascript:void(0);">...</a></li>
							</c:if>
							<c:if test="${pageBean_order.totalPage>5 && pageBean_order.currentPage!=1 && pageBean_order.totalPage-pageBean_order.currentPage>=3}">
								<c:forEach begin="${pageBean_order.currentPage-1}" end="${pageBean_order.currentPage+2}" var="page">
									<!-- 判断当前页 -->
									<c:if test="${pageBean_order.currentPage==page }">
										<li class="active"><a href="javascript:void(0);">${page}</a></li>
									</c:if>
									<c:if test="${pageBean_order.currentPage!=page }">
										<li><a href="javascript:void(0);" onclick="changePage(${page})">${page}</a></li>
									</c:if>
								</c:forEach>
								<li><a href="javascript:void(0);" onclick="changePage('${pageBean_order.currentPage+3}')">...</a></li>
							</c:if>
							
				             <!-- 判断当前页是否是最后一页 -->
							<c:if test="${pageBean_order.currentPage==pageBean_order.totalPage }">
								<li class="disabled">
									<a href="javascript:void(0);" aria-label="Next"> 
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pageBean_order.currentPage!=pageBean_order.totalPage }">
								<li>
									<a href="javascript:void(0);" onclick="changePage(${pageBean_order.currentPage+1})" aria-label="Next"> 
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('[data-toggle="popover"]').popover();
        if("${empty pageBean_order}"=="true"){
            $("#query_order").submit();
       	};
       	//更新选项
       	$(".showpagenum ul li a").each(function () {
           if("${pageBean_order.currentCount}" == $(this).text()) $(this).hide();
           else $(this).show();
       	});
       	//更新排序按钮
       	var flag1="false";
       	var flag2="false";
       	var flag3="false";
        if('${sort_state}'=='1'){ //日期降序
        	$('#dd').attr('src','${pageContext.request.contextPath}/img/sort-down.png');
        	flag1="true";
        }else  if('${sort_state}'=='2'){ //日期升序
        	$('#dd').attr('src','${pageContext.request.contextPath}/img/sort-up.png');
        	flag1="true";
        }else  if('${sort_state}'=='3'){ //价格降序
        	$('#pp').attr('src','${pageContext.request.contextPath}/img/sort-down.png');
        	flag2="true";
        }else  if('${sort_state}'=='4'){ //价格升序
        	$('#pp').attr('src','${pageContext.request.contextPath}/img/sort-up.png');
        	flag2="true";
        }else  if('${sort_state}'=='5'){ //时间降序
        	$('#tt').attr('src','${pageContext.request.contextPath}/img/sort-down.png');
        	flag3="true";
        }else  if('${sort_state}'=='6'){ //时间升序
        	$('#tt').attr('src','${pageContext.request.contextPath}/img/sort-up.png');
        	flag3="true";
        }
        if("false"==flag1) $('#dd').attr('src','${pageContext.request.contextPath}/img/sort.png');
        if("false"==flag2) $('#pp').attr('src','${pageContext.request.contextPath}/img/sort.png');
        if("false"==flag3) $('#tt').attr('src','${pageContext.request.contextPath}/img/sort.png');
    });

    function changePage(pageNum) {
        //1 将页码的值放入对应表单隐藏域中
        $("#currentPage").val(pageNum);
        //2 提交表单
        $("#query_order").submit();				
     };

     /* 改变每页显示的页数 */
     function changeShowPageNum(num) {
         $('#currentCount').val(num);
         $("#currentPage").val("1");
         $("#query_order").submit();
     }
     
     /* 导出订单数据 */
     function export_order(){
    	 this.location.href="${pageContext.request.contextPath}/admin?method=export_order";
     }
    
    /* 切换排序方式 */
    function change_sort(obj){
    	var idd = $(obj).attr("id");
        var sc = $(obj).attr('src');
    	if(idd=="dd"){
    		if(sc=='${pageContext.request.contextPath}/img/sort.png') $("#sort_state").val("1"); //当前是默认,点击变成日期降序
    		else if(sc=='${pageContext.request.contextPath}/img/sort-down.png') $("#sort_state").val("2"); //当前是默认,点击变成日期升序
    		else $("#sort_state").val("7"); //当前是升序,恢复默认
    	}
    	else if(idd=="pp"){
    		if(sc=='${pageContext.request.contextPath}/img/sort.png') $("#sort_state").val("3"); //当前是默认,点击变成价格降序
    		else if(sc=='${pageContext.request.contextPath}/img/sort-down.png') $("#sort_state").val("4"); //当前是默认,点击变成价格升序
    		else $("#sort_state").val("7"); //当前是升序,恢复默认
    	}
    	else{
    		if(sc=='${pageContext.request.contextPath}/img/sort.png') $("#sort_state").val("5"); //当前是默认,点击变成时间降序
    		else if(sc=='${pageContext.request.contextPath}/img/sort-down.png') $("#sort_state").val("6"); //当前是默认,点击变成时间升序
    		else $("#sort_state").val("7"); //当前是升序,恢复默认
    	}
    	$("#currentPage").val("1");
    	$("#query_order").submit();
    }
</script>

</html>