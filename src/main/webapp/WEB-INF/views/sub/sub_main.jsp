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
		padding-left:10px;
		padding-top:5px;
	}
	#tbl_simple_reservation .tbl_content_pName{
		padding:0;
		font-size:17px;
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
	.ar_tbl_wrap_2 {
		width:100%;
		margin-top: 100px;
	}
	.ar_tbl_wrap_2 > table{
		width:100%;
	}
	.ar_tbl_wrap_2 table td{
		border: 1px solid black;
	}
	.therapist_name{
		text-align: center;
	}
</style> 
<script>
$(function(){
	var num=130;
	console.log(parseInt(num/60)+", "+num%60);
	
	//달력 생성
	buildCalendar();
	
	get_patient();
	
	//날짜마다 요일 표시
	write_yoil();
	
	//오늘 요일 및 날짜에 해당하는 병원 정보, 진료 예약 정보 GET 
	get_day_reservation_info(get_today());
	
	//달력 날짜 클릭 시 해당 정보GET
	$(document).on("click", "#calendar td:not(.tr_not > td)", function(){
		//날짜마다 요일 표시
		write_yoil();
		
		//클릭한 td 붉은색 네모
		$("#calendar td").css("border","0");
		$(this).not(".tr_not > td").css("border","1px solid red");
		
		//클릭한 날짜 정보 GET
		var date = $(this).text();
		var update_date = "";
		var year_month = $("#select_year_month").val();
		var fulldate = "";
		
		//날짜 일이 한자리면 앞에 숫자0 추가
		if(date.length <= 1){
			update_date = "0"+date;
		}else{
			update_date=date;
		}
		
		fulldate = year_month+"-"+update_date;
		var day = $(this).find("input[type='hidden']").val();
		
		//get_hospital_day_info(day);
		//setTimeout(function(){get_select_date_reservation(fulldate)},100);
		
		get_day_reservation_info(fulldate);
	 });
	
	$(document).on({
		mouseenter:function(){
			var rno=$(this).find("input[type='hidden']").val(); 

			$.ajax({
				url:"${pageContext.request.contextPath}/reservationInfoByRno/"+rno,
				type: "get",
				dataType:"json", 
				success:function(json){
					console.log(json);
					var str="";
					str="<p class='al_tbl_wrap2_title'>"+json.rtype+"예약</p><table id='tbl_simple_reservation'>"
						+"<tr><td class='tbl_content_pName'>"+json.name+"("+json.cno+")님 ▶"+ json.main_doctor+"</td></tr>"
						+"<tr><th class='tbl_content_title'>- 예약일시</th></tr>";
						if(json.rtype == '일반진료' || json.rtype == '일반치료'){
							str += "<tr><td class='tbl_content'>"+json.normal_date+" "+(Number(json.normal_rtime)/60)+"시</td></tr>";
						}else if(json.rtype == '고정진료' || json.rtype == '고정치료'){
							str += "<tr><td class='tbl_content'>"+json.fix_day+"요일 "+(Number(json.fix_rtime)/60)+"시</td></tr>";
						}
						str += "<tr><th class='tbl_content_title'>- 진료종류</th></tr>"
							+"<tr><td class='tbl_content'>"+json.clinic+"</td></tr>"
							+"<tr><th class='tbl_content_title'>- 등록정보</th></tr>"
							+"<tr><td class='tbl_content'>"+json.regdate+" by "+json.writer+"</td></tr>";
						
					if(json.updatedate != ""){
						str += "<tr><th class='tbl_content_title'>- 변경처리</th></tr>"
							+"<tr><td class='tbl_content'>"+json.updatedate+" by "+json.updatewriter+"</td></tr>";
					}
					if(json.memo != ""){
						str +=  "<tr><th class='tbl_content_title'>- 메모</th></tr>"
							+"<tr><td class='tbl_content'>"+json.memo+"</td></tr>";
					}
					
					str+="</table>";
						
					$(".al_tbl_wrap2").html(str);
				}
			});
			$(".al_tbl_wrap2").css("display","block");
			
		},
		mouseleave:function(){$(".al_tbl_wrap2").css("display","none");}
		}, ".patient_p_tag");
		
	
	
	
});

function get_patient(){
	$.ajax({
		url:"${pageContext.request.contextPath}/patientAllGet",
		type: "get",
		dataType:"json", 
		success:function(json){
			console.log(json);
		}
	});
}

function get_today(){
	var today=new Date();
	var today_month=(today.getMonth()+1)+"";
	var today_date=today.getDate()+"";
	var update_month="";
	var update_date="";
	var fullDate="";
	
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
	
	fulldate = today.getFullYear()+"-"+update_month+"-"+update_date;
	return fulldate;
}

function get_day_reservation_info(date){
	var txt = "";
	$.ajax({
		url:"${pageContext.request.contextPath}/dayAndReservationInfo/"+date,
		type: "get",
		dataType:"json", 
		success:function(json){
			console.log(json);
			
			var starttime=Number(json.hospitalInfo.start_time)/60;
			var endtime=Number(json.hospitalInfo.end_time)/60;
			var lunch=Number(json.hospitalInfo.lunch)/60;
			//진료 테이블 생성
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
			
			//치료 테이블 생성
			txt = "<table><tr><td></td>";
			for(var i=starttime; i < endtime; i++){
				txt+="<td>"+i+"시</td>";
			}
			txt+="</tr>";
			$(json.therapistList).each(function(){
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
			$(".ar_tbl_wrap_2").html(txt);
			
			//예약정보 생성
			var target_tag="";
							
			$(json.reservationListNormal).each(function(){
				if(this.rtype == '일반진료'){
					target_tag = ".doctor_"+this.main_doctor+"_"+(Number(this.normal_rtime)/60);
					txt = "<p class='patient_p_tag' style='background:yellow;border:1px solid gray;'>"+this.name+"<input type='hidden' value='"+this.rno+"'></p>";
					$(target_tag).append(txt);
				}else if(this.rtype == '일반치료'){
					target_tag = ".therapist_"+this.main_therapist+"_"+(Number(this.normal_rtime)/60);
					txt = "<p class='patient_p_tag' style='background:yellow;border:1px solid gray;'>"+this.name+"<input type='hidden' value='"+this.rno+"'></p>";
					$(target_tag).append(txt);
				}
				
			});
			
			$(json.reservationListFix).each(function(){
				if(this.rtype == '고정진료'){
					target_tag = ".doctor_"+this.main_doctor+"_"+(Number(this.fix_rtime)/60);
					txt = "<p class='patient_p_tag' style='background:pink;border:1px solid gray;'>"+this.name+"<input type='hidden' value='"+this.rno+"'></p>";
					$(target_tag).append(txt);
				}else if(this.rtype == '고정치료'){
					target_tag = ".therapist_"+this.main_therapist+"_"+(Number(this.fix_rtime)/60);
					txt = "<p class='patient_p_tag' style='background:pink;border:1px solid gray;'>"+this.name+"<input type='hidden' value='"+this.rno+"'></p>";
					$(target_tag).append(txt);
				}
				
			});
			
			
		}
	});
}

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
									
				</div><!-- al_tbl_wrap2 end -->
			</div><!-- aside_left end -->
			<div class="aside_right">
				<div class="ar_tbl_wrap_1">
					
					
				</div><!-- tbl_wrap_2 end-->
				<div class="ar_tbl_wrap_2">
				
				</div>
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div><!-- footer_wrap end -->
	</div><!-- body_wrap end -->
</body>
</html> 