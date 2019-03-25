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
		width:100%;
	}
	.header{
		width:100%;
	}
	table{
		border:1px solid lightgray;
	}
	td{
		width:30px;
		height:30px;
		font-size:15px;
		font-weight: bold;
		border: 1px solid lightgray;
		text-align: center;
		cursor: pointer;
	}
	td > label{
		display:block;
		line-height: 29px;
		width:100%;
		height:100%;
		cursor: pointer;
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
				<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
				    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
				        <td><label onclick="prevCalendar()"><</label></td>
				        <td align="center" id="tbCalendarYM" colspan="5">
				        yyyy년 m월</td>
				        <td><label onclick="nextCalendar()">>
				            
				        </label></td>
				    </tr>
				    <tr>
				        <td align="center" style="font-color:#F79DC2">일</td>
				        <td align="center">월</td>
				        <td align="center">화</td>
				        <td align="center">수</td>
				        <td align="center">목</td>
				        <td align="center">금</td>
				        <td align="center" style="font-color:#1056ca !important">토</td>
				    </tr> 
				</table>
			
			</div><!-- aside_left end -->
			
			<div class="aside_right">
				
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div>
	</div><!-- body_wrap end -->
</body>
</html> 