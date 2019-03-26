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
	//달력 생성
	buildCalendar();
	
	//오늘 요일 정보 GET
	get_hospital_day_info();
	
	//오늘 정보GET
	get_today_reservation();
	
	//날짜 클릭 시 해당 정보GET
	$(document).on("click", "#calendar td:not(.tr_not > td)", function(){
		//클릭한 td 붉은색 네모
		$("#calendar td").css("border","0");
		$(this).not(".tr_not > td").css("border","1px solid red");
		
		//클릭한 날짜 정보 GET
		var date = $(this).text();
		var year_month=$("#select_year_month").val();
		var fulldate=year_month+"-"+date;
		
		get_select_date_reservation(fulldate);
	 });
	
	//오늘날짜 예약정보 GET
	function get_today_reservation(){
		var today=new Date();
		var today_month=(today.getMonth()+1)+"";
		var today_date=today.getDate()+"";
		var update_month="";
		var update_date="";
		
		//날짜 월이 한자리면 앞에 숫자0 추가
		if(today_month.length <= 1){
			update_month="0"+today_month;
		}else{
			update_month=today_month;
		}
		//날짜 일이 한자리면 앞에 숫자0 추가
		if(today_date.length <= 1){
			today_date="0"+today_date;
		}else{
			update_date=today_date;
		}
		
		get_select_date_reservation(today.getFullYear()+"-"+update_month+"-"+update_date);
	}
	
	
	
	
	//달력에서 선택한 날짜 예약정보 GET
	function get_select_date_reservation(date){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/reservationInfoGet/"+date,
			type: "get",
			dataType:"json", 
			success:function(json){
				console.log(json);
				var target_tag="";
				var txt="";				
				$(".timetable_inner_content").html("");
				for(i=0;i<json.reservationList.length;i++){
					target_tag = ".doctor_"+json.reservationList[i].main_doctor+"_"+json.reservationList[i].normal_rtime;
					
					txt = "<p>"+json.reservationList[i].name+"</p>";
					
					$(target_tag).append(txt);
				}
			}
		});
	}
	
	function get_hospital_day_info(){
		var date=new Date();
		var day=date.getDay()+"";
		console.log(day);
		$.ajax({
			url:"${pageContext.request.contextPath}/dayInfoGet/"+day,
			type: "get",
			dataType:"text", 
			success:function(json){
				console.log(json);
				/* var target_tag="";
				var txt="";				
				$(".timetable_inner_content").html("");
				for(i=0;i<json.reservationList.length;i++){
					target_tag = ".doctor_"+json.reservationList[i].main_doctor+"_"+json.reservationList[i].normal_rtime;
					
					txt = "<p>"+json.reservationList[i].name+"</p>";
					
					$(target_tag).append(txt);
				} */
			}
		});
	}
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
					    <tr class="tr_not"><!-- label은 마우스로 클릭을 편하게 해줌 -->
					        <td><label onclick="prevCalendar()"><</label></td>
					        <td align="center" id="tbCalendarYM" colspan="5"> 
					        yyyy년 m월</td>
					        <td><label onclick="nextCalendar()">>
					            
					        </label></td>
					    </tr>
					    <tr class="tr_not">
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
					<h1>${hospitalInfo.start_tiem-1}</h1>
					<%-- <table>
						<tr>
							<td></td>
							<c:forEach begin="${hospitalInfo.start_time}" end="${hospitalInfo.end_time-1}" var="idx">
								<td>${idx}시&nbsp;&nbsp;&nbsp;</td>
							</c:forEach>
						</tr>
						<c:forEach var="item" items="${doctorList}">
							<tr class="${item.type}_${item.eno}">
								<td class="doctor_name">${item.name}</td>
								<c:forEach begin="${hospitalInfo.start_time}" end="${hospitalInfo.end_time-1}" var="idx">
									<c:choose> 
										<c:when test="${idx==hospitalInfo.lunch}">
											<td class="${item.type}_${item.eno}_${idx}" style="background:gray; text-align:center;">점심시간</td>
										</c:when>										
										<c:otherwise>	
											<td class="${item.type}_${item.eno}_${idx} timetable_inner_content"></td>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</tr>
						</c:forEach>
					</table> --%>
				</div><!-- tbl_wrap_2 end-->
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div><!-- footer_wrap end -->
	</div><!-- body_wrap end -->
</body>
</html> 