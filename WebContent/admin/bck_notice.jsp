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
    <title>bck_notice</title>
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
            margin-left: 25px;
        }

        table tbody tr td:last-of-type {
            width: 120px;
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
                    <form id="query_notice" method="POST" action="${pageContext.request.contextPath}/admin?method=query_notice">
                        <span>关键字查询:</span>
                        <input type="text" class="form1-tx" id="query_key" name="query_key" value="${query_key}">
                        <input type="hidden" id="currentPage" name="currentPage" value="${pageBean_notice.currentPage}">
                        <input type="hidden" id="currentCount" name="currentCount" value="${pageBean_notice.currentCount}">
                        <input type="submit" class="form1-bt btn btn-sm btn-primary" value="查询">
                    </form>
                </div>
                <div class="col-sm-3"></div>
                <div class="col-sm-2">
                    <button type="button" onclick="openadd_notice_Modal()"
                        class="preadd-btn btn btn-success btn-sm">发布新通知</button>
                </div>
                <div class="col-sm-2" style="padding-left: 30px;">
                    <button type="button" onclick="export_notice()"
                        class="preadd-btn btn btn-warning btn-sm">导出数据</button>
                </div>
            </div>
        </div>
        <!-- Table -->
        <table class="table table-hover" style="table-layout:fixed;">
            <thead>
                <tr>
                    <th style="width:5%;">#</th>
                    <th style="width:10%;">通知人</th>
                    <th style="width:25%;">通知标题</th>
                    <th style="width:35%;">通知内容</th>
                    <th style="width:10%;">通知日期</th>
                    <th style="width:14%;"></th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${pageBean_notice.list}" var="notice" varStatus="vs" >
             		<tr>
		                 <th scope="row">${vs.count+pageBean_notice.currentCount*pageBean_notice.currentPage-pageBean_notice.currentCount}</th>
		                 <td>${notice.notice_Man}</td>
		                 <td>${notice.notice_Title}</td>
		                 <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${notice.notice_Content}">${notice.notice_Content }</td>
		                 <td>${notice.notice_Time}</td>
	                     <td>
	                        <button type="button" onclick="openupdate_notice_Modal('${notice.notice_Id}','${notice.notice_Man}',
	                        '${notice.notice_Title}','${notice.notice_Content}','${notice.notice_Time}')"
	                            class="bt1 btn btn-info btn-xs">修改</button>
	                        <button type="button" onclick="opendel_notice_Modal('${notice.notice_Id}')"
	                            class="bt2 btn btn-danger btn-xs">删除</button>
                   		 </td>
	                 </tr>
				</c:forEach>
            </tbody>
        </table>
        <div class="container" style="width: 1410px;">
            <div class="row">
                <div class="col-sm-9" style="margin-top:23px;">
                    <div class="row">
                        <div class="col-sm-5" style="padding-right: 0px; width:290px">
                            <span style="font-size: 20px;">当前总共有${pageBean_notice.totalCount}条数据,每页显示</span>
                        </div>
                        <div class="col-sm-2" style="padding-left: 0px;padding-right:0px; width:55px;">
                            <div class="dropdown showpagenum">
                                <button class="btn btn-default dropdown-toggle" style="height: 27px; padding-top:3px;"
                                    type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="true">
                                    <span style="display:inline-block;width:11px;">${pageBean_notice.currentCount}</span>
                                    <span class="caret" style="margin-left: 3px;"></span>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1"
                                    style="min-width: 41px; overflow:visible;">
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
                        <div class="col-sm-4" style="padding-left: 10px;">
                            <span style="font-size: 20px;">条数据</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3" style="margin-left:-60px;">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">                            
                            <!-- 判断当前页是否是第一页 -->
							<c:if test="${pageBean_notice.currentPage==1 }">
								<li class="disabled">
									<a href="javascript:void(0);" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pageBean_notice.currentPage!=1 }">
								<li>
									<a href="javascript:void(0)" onclick="changePage('${pageBean_notice.currentPage-1}')" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>	
				             <c:forEach begin="1" end="${pageBean_notice.totalPage }" var="page">
								<!-- 判断当前页 -->
								<c:if test="${pageBean_notice.currentPage==page }">
									<li class="active"><a href="javascript:void(0);">${page}</a></li>
								</c:if>
								<c:if test="${pageBean_notice.currentPage!=page }">
									<li><a href="javascript:void(0);" onclick="changePage('${page}')">${page}</a></li>
								</c:if>
							</c:forEach>
				             <!-- 判断当前页是否是最后一页 -->
							<c:if test="${pageBean_notice.currentPage==pageBean_notice.totalPage }">
								<li class="disabled">
									<a href="javascript:void(0);" aria-label="Next"> 
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pageBean_notice.currentPage!=pageBean_notice.totalPage }">
								<li>
									<a href="javascript:void(0);" onclick="changePage('${pageBean_notice.currentPage+1}')" aria-label="Next"> 
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

        if("${empty pageBean_notice}"=="true"){
             $("#query_notice").submit();
        };
        //更新选项
        $(".showpagenum ul li a").each(function () {
            if("${pageBean_notice.currentCount}" == $(this).text()) $(this).hide();
            else $(this).show();
        });
        
    });
    function changePage(pageNum) {
       //1 将页码的值放入对应表单隐藏域中
       $("#currentPage").val(pageNum);
       //2 提交表单
       $("#query_notice").submit();				
    };

    /* 改变每页显示的页数 */
    function changeShowPageNum(num) {
        $('#currentCount').val(num);
        $("#currentPage").val("1");
        $("#query_notice").submit();
    }
	
    /* 导出通知数据 */
    function export_notice(){
   	 this.location.href="${pageContext.request.contextPath}/admin?method=export_notice";
    }
    
    /* 添加新的通知 */
    function openadd_notice_Modal() {
        var fatherBody = $(window.top.document.body); //获得父窗体的body
        //为父窗体添加modal内容
        fatherBody.append(' \
        		<div class="modal fade in" id="add_notice_model" role="dialog" style="padding-left: 16px; display: block;">\
                <div class="modal-dialog">\
                    <div class="modal-content" style="margin-top:20%">\
                        <form>\
                            <div class="modal-header">\
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span\
                                        aria-hidden="true">&times;</span></button>\
                                <h4 class="modal-title" style="text-align: center;">发布新通知</h4>\
                            </div>\
                            <div class="modal-body">\
                                <div class="row" style="margin-top: 3px;">\
                                    <div class="col-md-2" style="margin-top: 5px;" ><span>通知人:</span></div>\
                                    <div class="col-md-9 " style="padding-left:0px">\
                                        <input type="text" id="notice_Man" class="form-control" required autofocus>\
                                    </div>\
                                </div>\
                                <div class="row"style="margin-top: 3px;">\
                                    <div class="col-md-2" style="margin-top: 5px;"><span>通知标题:</span></div>\
                                    <div class="col-md-9 " style="padding-left:0px">\
                                        <input type="text" id="notice_Title" class="form-control" required autofocus>\
                                    </div>\
                                </div>\
                                <div class="row"style="margin-top: 3px;">\
                                    <div class="col-md-2" style="margin-top: 5px;"><span>通知内容:</span></div>\
                                    <div class="col-md-9" style="padding-left:0px">\
                                        <textarea id="notice_Content" class="form-control" cols="62" rows="6"></textarea>\
                                    </div>\
                                </div>\
                                <div class="row"style="margin-top: 3px;">\
                                    <div class="col-md-2" style="margin-top: 5px;"><span>通知日期:</span></div>\
                                    <div class="col-md-9" style="padding-left:0px">\
                                        <input type="date" id="notice_Time" class="form-control" required autofocus>\
                                    </div>\
                                </div>\
                            </div>\
                            <div class="modal-footer">\
                                <button type="button" class="btn btn-default myclose" data-dismiss="modal">取消</button>\
                                <button type="button" class="submit_add_notice btn btn-primary">确认发布</button>\
                            </div>\
                        </form>\
                    </div>\
                </div>\
            </div>');
        fatherBody.append("<div id='backdropId_add_notice' class='modal-backdrop fade in'></div>"); //为父窗体添加遮罩
    }

    /* 编辑通知 */
    function openupdate_notice_Modal(notice_Id,notice_Man,notice_Title,notice_Content,notice_Time) {
        var fatherBody = $(window.top.document.body); //获得父窗体的body
        //为父窗体添加modal内容
        fatherBody.append(' \
        		<div class="modal fade in" id="update_notice_model" role="dialog" style="padding-left: 16px; display: block;">\
                <div class="modal-dialog">\
                    <div class="modal-content" style="margin-top:20%">\
                        <form>\
                            <div class="modal-header">\
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span\
                                        aria-hidden="true">&times;</span></button>\
                                <h4 class="modal-title" id="myModalLabel" style="text-align: center;">修改通知</h4>\
                            </div>\
                            <input type="hidden" id="notice_Id" value='
                            	+notice_Id+
                           	'>\
                            <div class="modal-body">\
                                <div class="row" style="margin-top: 3px;">\
                                    <div class="col-md-2" style="padding-left:23px; margin-top: 5px;"><span>通知人:</span></div>\
                                    <div class="col-md-9 " >\
                                        <input type="text" id="notice_Man" class="form-control" readonly="readonly" required autofocus  value='
                                        	+notice_Man+
                                           	'>\
                                    </div>\
                                </div>\
                                <div class="row"style="margin-top: 3px;">\
                                    <div class="col-md-2" style="padding-left:23px; margin-top: 5px;"><span>通知标题:</span></div>\
                                    <div class="col-md-9 ">\
                                        <input type="text" id="notice_Title" class="form-control" required autofocus value='
                                        	+notice_Title+
                                           	'>\
                                    </div>\
                                </div>\
                                <div class="row"style="margin-top: 3px;">\
                                    <div class="col-md-2" style="padding-left:23px; margin-top: 5px;"><span>通知内容:</span></div>\
                                    <div class="col-md-9">\
                                        <textarea id="notice_Content" class="form-control" cols="62" rows="6">'
                                        	+notice_Content+
                                    	'</textarea>\
                                    </div>\
                                </div>\
                                <div class="row"style="margin-top: 3px;">\
                                    <div class="col-md-2" style="padding-left:23px; margin-top: 5px;"><span>通知日期:</span></div>\
                                    <div class="col-md-9">\
                                        <input type="date" id="notice_Time"class="form-control" required autofocus value='
                                        	+notice_Time+
                                           	'>\
                                    </div>\
                                </div>\
                            </div>\
                            <div class="modal-footer">\
                            <button type="button" class="btn btn-default myclose" data-dismiss="modal">取消</button>\
                            <button type="button" class="submit_update_notice btn btn-primary">确认修改</button>\
                        </div>\
                        </form>\
                    </div>\
                </div>\
            </div>');
        fatherBody.append("<div id='backdropId_update_notice' class='modal-backdrop fade in'></div>"); //为父窗体添加遮罩
    }

    /* 删除通知 */
    function opendel_notice_Modal(del_id) {
        var fatherBody = $(window.top.document.body); //获得父窗体的body
        //为父窗体添加modal内容
        fatherBody.append(' \
        		<div class="modal fade in" id="del_notice_model" role="dialog" style="padding-left: 16px; display: block;">\
                <div class="modal-dialog" style="margin-top:15%">\
                    <div class="modal-content" style="width:300px;top: 50%;left: 50%;margin-top: -25px;margin-left: -150px;">\
                        <form>\
                        	<input type="hidden" id="del_notice_id" value='
                        	+del_id+
                        	'>\
                            <div class="modal-header">\
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span\
                                        aria-hidden="true">&times;</span></button>\
                                <h4 class="modal-title" style="text-align: center;">操作提示</h4>\
                            </div>\
                            <div class="modal-body">\
                            	<label for="message-text" class="control-label">确定要删除所选通知？</label>\
                            </div>\
                            <div class="modal-footer">\
                            <button type="button" class="btn btn-default myclose" data-dismiss="modal">取消</button>\
                            <button type="button" class="submit_del_notice btn btn-danger">确定</button>\
                        </div>\
                        </form>\
                    </div>\
                </div>\
            </div>');
        fatherBody.append("<div id='backdropId_del_notice' class='modal-backdrop fade in'></div>"); //为父窗体添加遮罩
    }
</script>
</html>