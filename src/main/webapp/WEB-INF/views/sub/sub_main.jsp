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
	}
	.aside_left > .al_tbl_wrap_1{
		width: 100%;
	}
	.aside_left > .al_tbl_wrap_1 > #calendar{
		margin: 0 auto;
	}
	.aside_left > .al_tbl_wrap_1 > #calendar td{
		width:30px;
		height:30px;
		font-size:15px;
		font-weight: bold;
		text-align: center;
		cursor: pointer;
	}
	.aside_left > .al_tbl_wrap_1 > #calendar td > label{
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
	.ar_tbl_wrap_1 {
		width:100%;
	}
	.ar_tbl_wrap_1 > table{
		width:100%;
	}
	.ar_tbl_wrap_1 table td{
		border: 1px solid black;
	}
	.doctor_name{
		text-align: center;
	}
	.al_tbl_wrap2{
		width:100%;
		margin-top:50px;
		display:none;
	}
	.al_tbl_wrap2_title{
		width: 95%;
		margin: 0 auto;
		background: #057be8;
		color: #fff;
		font-size:18px;
		font-weight: bold;
		text-align: center;
		padding: 15px 0;
		letter-spacing: 5px;
	}
	.al_tbl_wrap2 > #tbl_simple_reservation{
		width:95%;
		margin: 0 auto;
		border: 1px solid lightgray;
		display:block;
		padding:15px;
		background: #d3e5f6;
	}
	#tbl_simple_reservation tr{
		
	}
	#tbl_simple_reservation th, #tbl_simple_reservation td{
		font-size:15px;
		font-weight: bold;
	}
	#tbl_simple_reservation .tbl_content_title{
		text-align: left;
		padding-top:15px;
	}
	#tbl_simple_reservation .tbl_content {
		padding-left:20px;
		padding-top:5px;
	}
	#tbl_simple_reservation .tbl_content_pName{
		padding:0;
		font-size:17px;
	}
</style> 
<script>
$(function(){
	
	//달력 생성
	buildCalendar();
	
	//날짜마다 요일 표시
	write_yoil();
	
	//오늘 요일 정보 GET
	get_hospital_day_info(get_today());
	
	//오늘 정보GET
	setTimeout(function(){get_today_reservation()},100);
	
	//달력 날짜 클릭 시 해당 정보GET
	$(document).on("click", "#calendar td:not(.tr_not > td)", function(){
		//날짜마다 요일 표시
		write_yoil();
		
		//클릭한 td 붉은색 네모
		$("#calendar td").css("border","0");
		$(this).not(".tr_not > td").css("border","1px solid red");
		
		//클릭한 날짜 정보 GET
		var date = $(this).text();
		var year_month=$("#select_year_month").val();
		var fulldate=year_month+"-"+date;
		var day = $(this).find("input[type='hidden']").val();
		
		get_hospital_day_info(day);
		setTimeout(function(){get_select_date_reservation(fulldate)},100);
		
	 });
	
	$(document).on({
		mouseenter:function(){$(".al_tbl_wrap2").css("display","block");},
		mouseleave:function(){$(".al_tbl_wrap2").css("display","none");}
		}, ".patient_p_tag");
		
	
	
	
});
//달력에 각 일마다 요일 표시
function write_yoil(){
	var idx=1;
	for(var i=0; i < $("#calendar tr:not(.tr_not) td").length; i++){
		if(idx == 8){
			idx = 1;
		} 
		$("#calendar tr:not(.tr_not) td").eq(i).append("<input type='hidden' value='"+idx+"'>");
		idx++;
	}
}

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
	console.log("reservationInfo GET");
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationInfoGet/"+date,
		type: "get",
		dataType:"json", 
		success:function(json){
			
			var target_tag="";
			var txt="";				
			//$(".timetable_inner_content").html("");
			
			for(i=0;i<json.reservationList.length;i++){
				target_tag = ".doctor_"+json.reservationList[i].main_doctor+"_"+json.reservationList[i].normal_rtime;
				
				txt = "<p class='patient_p_tag' style='background:yellow;border:1px solid gray;'>"+json.reservationList[i].name+"</p>";
				
				$(target_tag).append(txt);
			}
		}
	});
}

function get_today(){
	var date=new Date();
	var day=(date.getDay()+1)+"";
	return day;
}

//요일 별 병원 정보 및 의사 정보GET해서 표 만들기
function get_hospital_day_info(day){
	console.log("dayInfo GET");
	var txt= "";
	
	$.ajax({
		url:"${pageContext.request.contextPath}/dayInfoGet/"+day,
		type: "get",
		dataType:"json", 
		success:function(json){				
			var starttime=Number(json.hospitalInfo.start_time);
			var endtime=Number(json.hospitalInfo.end_time);
			var lunch=Number(json.hospitalInfo.lunch);
			
			txt = "<table><tr><td></td>";
			for(var i=starttime; i < endtime; i++){
				txt+="<td>"+i+"시</td>";
			}
			txt+="</tr>";
			$(json.doctorList).each(function(){
				txt += "<tr class='"+this.type+"_"+this.eno+"'><td>"+this.name+"</td>";
				for(var i=starttime; i < endtime; i++){
					if(i == lunch){
						txt += "<td class='"+this.type+"_"+this.eno+"_"+i+"' style='background:gray; text-align:center;'>점심시간</td>";
					}else{
						txt += "<td class='"+this.type+"_"+this.eno+"_"+i+" timetable_inner_content'></td>"
					}
				}
				txt += "</tr>";
			});
			
			txt+="</table>";				
			
			$(".ar_tbl_wrap_1").html(txt);
		}
	});
}
</script> 
</head> 
<body>
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside_left">
				<div class="al_tbl_wrap_1">
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
				<div class="al_tbl_wrap2">
					<p class="al_tbl_wrap2_title">일반예약</p>
					<table id="tbl_simple_reservation">
						<tr>
							<td class="tbl_content_pName">김길동(68255)님 ▶ 김정훈</td>
						</tr>
						<tr>
							<th class="tbl_content_title">-예약일시</th>
						</tr>
						<tr>
							<td class="tbl_content">2019-03-27 09:00</td>
						</tr>
						<tr>
							<th class="tbl_content_title">-진료종류</th>
						</tr>
						<tr>
							<td class="tbl_content">주사-MP 30분</td>
						</tr>
						<tr>
							<th class="tbl_content_title">-등록정보</th>
						</tr>
						<tr>
							<td class="tbl_content">2019-03-20 by 정은비</td>
						</tr>
						<tr>
							<th class="tbl_content_title">-변경처리</th>
						</tr>
						<tr>
							<td class="tbl_content">2019-03-27 by 조수빈</td>
						</tr>
					</table>
				</div>
			</div><!-- aside_left end -->
			<div class="aside_right">
				<div class="ar_tbl_wrap_1">
					
					
				</div><!-- tbl_wrap_2 end-->
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div><!-- footer_wrap end -->
	</div><!-- body_wrap end -->
</body>
</html> 