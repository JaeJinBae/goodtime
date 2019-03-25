<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar.js"></script>

<style>
	.all_wrap{
		width: 100%;
		height: 100%;
	}
	.header{
		width:100%;
	}
	.section{
		width:100%;
		height: 100%;
		overflow: hidden;
	}
	.aside_left{
		width:15%;
		min-width:230px;
		height:100%;
		float:left;
		border-right: 1px solid lightgray;
		padding-top:50px;
		background: lightgray;
	}
	.aside_left > .tbl_wrap_1{
		width: 100%;
	}
	.aside_left > .tbl_wrap_1 > #calendar{
		margin: 0 auto;
	}
	.aside_left > .tbl_wrap_1 > #calendar td{
		width:30px;
		height:30px;
		font-size:15px;
		font-weight: bold;
		border: 1px solid lightgray;
		text-align: center;
		cursor: pointer;
	}
	.aside_left > .tbl_wrap_1 > #calendar td > label{
		display:block;
		line-height: 29px;
		width:100%;
		height:100%;
		cursor: pointer;
	}
	.aside_right {
		float:left;
		width:80%;
		min-width:1000px;
		height:100%;
		background: #efefef;
	}
	.tbl_wrap_2 {
		width:100%;
	}
	.tbl_wrap_2 > table{
		width:100%;
	}
	.tbl_wrap_2 table td{
		border: 1px solid black;
	}
	.doctor_name{
		text-align: center;
	}
</style> 
<script>
$(function(){
	buildCalendar(); 
	$(document).on("click", "#calendar td", function(){
		var txt = $(this).text(); 
		//alert(txt); 
	 });
	 
});
</script>
</head>
<body>
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside_left">
				<div class="tbl_wrap_1">
					<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
					    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
					        <td><label onclick="prevCalendar()"><</label></td>
					        <td align="center" id="tbCalendarYM" colspan="5">
					        yyyy년 m월</td>
					        <td><label onclick="nextCalendar()">>
					            
					        </label></td>
					    </tr>
					    <tr>
					        <td align="center" style="color:red;">일</td>
					        <td align="center">월</td>
					        <td align="center">화</td>
					        <td align="center">수</td>
					        <td align="center">목</td>
					        <td align="center">금</td>
					        <td align="center" style="color:#2165d5 !important">토</td>
					    </tr> 
					</table>
				</div><!-- tbl_wrap_1 end -->
			</div><!-- aside_left end -->
			<div class="aside_right">
				<div class="tbl_wrap_2">
					<table>
						<tr>
							<td></td>
							<c:forEach begin="${info.start_time}" end="${info.end_time-1}" var="idx">
								<td>${idx}시&nbsp;&nbsp;&nbsp;</td>
							</c:forEach>
						</tr>
						<c:forEach var="item" items="${doctorList}">
							<tr>
								<td class="doctor_name">${item.name}</td>
								<c:forEach begin="${info.start_time}" end="${info.end_time-1}" var="idx">
									<c:choose>
										<c:when test="${idx==info.lunch}">
											<td style="background:gray; text-align:center;">점심시간</td>
										</c:when>
										<c:otherwise>
											<td></td>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
				</div><!-- tbl_wrap_2 -->
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div><!-- footer_wrap end -->
	</div><!-- body_wrap end -->
</body>
</html> 