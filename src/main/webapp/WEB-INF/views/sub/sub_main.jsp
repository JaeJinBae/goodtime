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
<script src="${pageContext.request.contextPath}/resources/js/week_calendar.js"></script>
<style>
	.popup_wrap{
		width:100%;
		position:fixed;
		top:0;
		left:0;
		display:none;
	}
	.popup_bg{
		position: fixed;
		top:0;
		left:0;
		width:100%;
		height:100%;
		background: #111;
		opacity: 0.5;
	}
	.popup_content{
		width:600px;
		height:700px;
		background:#fff;
		margin:0 auto;
		margin-top:100px;
		position: relative;
		z-index: 999;
	}
	.popup_content > table tr{
		display:block;
		margin-top:30px;
	}
	.popup_content > table tr > th{
		font-size:15px;
		width:100px;
	}
	.popup_content > table tr > td{
		font-size:15px;
	}
	.popup_content > table tr > td > select{
		font-size: 15px;
	}
	.popup_patientUpdate{
		display:none;
	}
	.popup_reservation_register{
		display:none;
	}
	.popup_therapy_reservation_register{
		display: none;
	}
	.popup_reservation_register_btn_wrap{
		margin-top:30px;
	}
	.popup_reservation_register_btn_wrap > p{
		display: inline-block;
		margin-left:20px;
		cursor: pointer;
	}
	.all_wrap{
		width: 100%;
		/* height: 100%; */
		padding-bottom:50px;
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
	.al_tbl_wrap2 > .al_tbl_wrap2_title > span{
		cursor: pointer;
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
		font-size:15px;
	}
	.aside_right {
		float:left;
		width:80%;
		min-width:1000px;
		height:100%;
	}
	.ar_tbl_wrap_1{
		width:100%;
		margin-top:30px;
	}
	.week_select_box_wrap{
		display:none;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap{
		overflow:hidden;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table {
		width:100%;
		border-top: 2px solid gray;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr th{
		font-size:15px;
		text-align: center;
		font-weight: bold;
		border-bottom: 2px solid #efefef;
		padding: 7px 0;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:first-child{
		width:0;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(2){
		width:90px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(3){
		width:60px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(4){
		width:60px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(5){
		width:80px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(6){
		width:75px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(7){
		width:70px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(8){
		width:110px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(9){
		width:130px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(10){
		width:70px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:last-child{
		width:60px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr td{
		font-size: 15px;
		text-align: center;
		border-bottom: 1px solid lightgray;
		padding: 2px 0;
	}
	.patient_update_btn, .sms_open_btn, .reservation_select_btn{
		width:40px;
		margin: 0 auto;
		padding: 4px 0;
		font-size:15px;
		background: gray;
		color: #fff;
		cursor: pointer;
		border-radius: 4px;
		text-align: center;
	}
	.page{
		float:right;
		/* width:626px; */ 
		margin:15px;
		margin-bottom:80px;
	}
	.page > ul{
		text-align: center;
	}
	.page ul li{
		
		margin:0 auto;
		list-style: none;
		display: inline-block;
		text-align:center;
		border:1px solid #e9e9e9;
	}
	.active1{
		background: #ed1c24;
	}
	.active2{
		font-weight: bold;
		color:white;
	}
	.page ul li a{
		display:inline-block;
		width:35px;
		height:30px;
		font-size:1.1em;
		line-height: 30px;
	}
	.ar_tbl_wrap_2 {
		width:100%;
	}
	
	.timetable_btn_wrap{
		width:100%;
		border-bottom:2px solid black;
		overflow:hidden;
		margin-bottom:20px;
		padding:0 10px;
	}
	.timetable_btn_wrap > ul{
		float:left;
		margin-right:30px;
	}
	.timetable_btn_wrap > ul > li{
		float:left;
		border: 1px solid gray;
		border-bottom:0;
		border-radius: 7px 7px 0 0;
		font-size:15px;
		padding:5px;
		margin-right:3px;
		cursor: pointer;
	}
	.time_table_wrap > table{
		width:100%;
	}
	.time_table_wrap table td{
		border: 1px solid black;
	}
	.doctor_name{
		text-align: center;
	}
	.ar_tbl_wrap_3 {
		width:100%;
		margin-top: 100px;
	}
	.therapist_name{
		text-align: center;
	}
	.reservation_register_btn{
		display:none;
		width:20px;
		height:20px;
		color:#fff;
		text-align:center;
		font-size:20px;
		background:gray;
		border:1px solid lightgray;
		cursor:pointer;
	}
</style> 
<script>

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
		update_date="0"+today_date;
	}else{
		update_date=today_date;
	}
	
	fulldate = today.getFullYear()+"-"+update_month+"-"+update_date;
	//$(".calendar_select_date").val(fulldate);
	return fulldate;
}

function get_day(date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/getDay/"+date,
		type:"get",
		dataType:"text",
		async:false,
		success:function(json){
			dt = decodeURIComponent(json);
		} 
	})
	return dt;
}

function get_patient_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/patientAllGet",
		type: "get",
		data:info,
		async:false,
		dataType:"json",
		success:function(json){			
			dt = json;
		}
	});
	return dt;
}

function draw_patient_table(info){
	var json = get_patient_all(info);
	
	var str = "";

	$("#inner_tbl_wrap").empty();
	
	str ="<table><tr><th></th><th>이름</th><th>설정</th><th>예약</th><th>담당의사</th><th>담당치료사</th><th>회원등급</th><th>생년월일</th><th>연락처</th><th>차트번호</th><th>메모</th><th>문자</th></tr>";
	
	if(json.patientListAll.length == 0){
		str += "<tr><td colspan='12'>등록된 회원이 없습니다.</td></tr>";
	}else{
		$(json.patientListAll).each(function(){
			str += "<tr><td><input type='hidden' value='"+this.pno+"'></td><td>"+this.name+"</td><td><p class='patient_update_btn'>수정</p></td><td><p class='reservation_select_btn'>선택</p></td><td>"+this.main_doctor_name+"</td><td>"+this.main_therapist+"</td><td>환자</td><td>"+this.birth+"</td><td>"+this.phone+"</td><td>"+this.cno+"</td><td>"+this.memo+"</td><td><p class='sms_open_btn'>열기</p></td></tr>";
		});
	}
	str += "</table>";
	
	str += "<div class='page'><ul>";
	if(json.pageMaker.prev){
		str += "<li><a href='page="+(json.pageMaker.startPage-1)+"&perPageNum=10&searchType="+json.pageMaker.cri.searchType+"&keyword="+json.pageMaker.cri.keyword+"'>&laquo;</a></li>";
	}
	for(var i=json.pageMaker.startPage; i<=json.pageMaker.endPage; i++){
		
		if(json.pageMaker.cri.page == i){
			str += "<li class='active1'><a class='active2' href='page="+i+"&perPageNum=10&searchType="+json.pageMaker.cri.searchType+"&keyword="+json.pageMaker.cri.keyword+"'>"+i+"</a></li>";
		}else{
			str += "<li><a href='page="+i+"&perPageNum=10&searchType="+json.pageMaker.cri.searchType+"&keyword="+json.pageMaker.cri.keyword+"'>"+i+"</a></li>"
		}
	}
	if(json.pageMaker.next){
		str += "<li><a href='page="+(json.pageMaker.endPage+1)+"&perPageNum=10&searchType="+json.pageMaker.cri.searchType+"&keyword="+json.pageMaker.cri.keyword+"'>&raquo;</a></li>";
	}
	str += "</ul></div>";	
	$("#inner_tbl_wrap").append(str);
}


function get_patient_by_pno(pno){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/patientByPno/"+pno,
		type:"get",
		dataType:"json",
		async:false,
		success:function(json){
			dt = json;
		}
	})
	return dt;
}

//환자 정보 수정view에 정보 기입
function draw_patient_update_view(pno){
	var json = get_patient_by_pno(pno);
	
	$(".popup_patientUpdate > input[name='pno']").val(json.pno);
	$(".popup_patientUpdate > table tr td > input[name='cno']").val(json.cno);
	$(".popup_patientUpdate > table tr td > input[name='name']").val(json.name);
	$(".popup_patientUpdate > table tr td > input[name='phone']").val(json.phone);
	$(".popup_patientUpdate > table tr td > input[name='birth']").val(json.birth);
	$(".popup_patientUpdate > table tr td > select[name='gender'] option[value='"+json.gender+"']").prop("selected", true);
	$(".popup_patientUpdate > table tr > td > select[name='main_doctor'] option[value='"+json.main_doctor+"']").prop("selected", true);
	$(".popup_patientUpdate > table tr > td > select[name='main_therapist'] option[value='"+json.main_therapist+"']").prop("selected", true);
	$(".popup_patientUpdate > table tr td > input[name='mail']").val(json.mail);
	$(".popup_patientUpdate > table tr td > input[name='memo']").val(json.memo);
	
	$(".popup_wrap").css("display","block");
	$(".popup_patientUpdate").css("display", "block");
}

function post_patient_update_info(patient){
	$.ajax({
		url:"${pageContext.request.contextPath}/patientUpdate",
		type:"post",
		dataType:"text",
		data:patient,
		async:false,
		success:function(json){
			$(".popup_patientUpdate").css("display", "none");
			$(".popup_wrap").css("display","none");
			draw_patient_table();
		}
	});
}

//요일별 병원정보 get
function get_hospitalInfo_byDay(date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/hospitalInfoGetByDay/"+date,
		type: "get",
		dataType:"json",
		async:false,
		success:function(json){
			dt = json;
		}
	});
	return dt;
}

//직업별 직원정보list get
function get_employeeList_byType(type){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeListGetByType/"+type,
		type: "get",
		dataType:"json",
		async:false,
		success:function(json){
			dt = json;
		}
	});
	
	return dt;
}

function get_employee_byEno(eno){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeGetByEno"+eno,
		type:"get",
		dataTyp:"json",
		async:false,
		success:function(json){
			dt = json;
		}
	});
	return dt;
}

function get_reservationList_byDate(date){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListGetByDate/"+date,
		type: "get",
		dataType:"json",
		async:false,
		success:function(json){
			dt = json;
		}
	});
	
	return dt;
}

function get_reservationList_byDate_byEmployee(date, type, eno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListByDateEno/"+date+"/"+type+"/"+eno,
		type: "get",
		dataType:"json",
		async:false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	
	return dt;
}

function draw_total_time_table(date, type){
	var hospitalDayInfo = get_hospitalInfo_byDay(date);
	var empList = get_employeeList_byType(type);
	
	var starttime=Number(hospitalDayInfo.start_time)/60;
	var endtime=Number(hospitalDayInfo.end_time)/60;
	var lunch=Number(hospitalDayInfo.lunch)/60;
	
	//진료 테이블 생성
	var txt = "<table class='"+type+"_time_table'><tr><td></td>";
	
	for(var i=starttime; i < endtime; i++){
		txt+="<td>"+i+"시</td>";
	}
	txt+="</tr>";
	
	$(empList).each(function(){
		txt += "<tr class='"+this.type+"_"+this.eno+"'><td>"+this.name+"</td>";
		for(var i=starttime; i < endtime; i++){
			//점심시간에 진료 및 치료 하지않는 병원
			/* if(i == lunch){
				txt += "<td class='"+this.type+"_"+this.eno+"_"+i+"' style='background:gray; text-align:center;'>점심시간</td>";
			}else{
				txt += "<td class='"+this.type+"_"+this.eno+"_"+i+" timetable_inner_content'><p class='reservation_register_btn' style='border:1px solid lightgray;width:20px;text-align:center;height:20px;font-size:20px;background:gray;color:#fff;cursor:pointer;'>+</p></td>";
			} */
			//점심시간에도 진료 및 치료하는 병원
			txt += "<td class='"+this.type+"_"+this.eno+"_"+i+" timetable_inner_content'><p class='reservation_register_btn'>+</p></td>";
		}
		txt += "</tr>";
	});
	txt+="</table>";
	return txt;
}

function draw_time_table_by_case(idx){
	var select_date = $(".calendar_select_date").val();
	var table_txt;
	
	switch (idx){
		case 0:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			table_txt = draw_total_time_table(select_date, "doctor");
			table_txt += "<br><br><br>";
			table_txt += draw_total_time_table(select_date, "therapist");
			$(".time_table_wrap").append(table_txt);
			draw_reservation(select_date);
			storage_timetable_btn_num = 0;
			break;
		case 1:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			table_txt = draw_total_time_table(select_date, "doctor");
			$(".time_table_wrap").append(table_txt);
			draw_reservation(select_date);
			storage_timetable_btn_num = 1;
			break;
		case 2:
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 2;
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("doctor"), "doctor");
			break;
		case 3:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 3;
			break;
		case 4:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			table_txt = draw_total_time_table(select_date, "therapist");
			$(".time_table_wrap").append(table_txt);
			draw_reservation(select_date);
			storage_timetable_btn_num = 4;
			break;
		case 5:
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 5;
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("therapist"), "therapist");
			break;
		case 6:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 6;
			break;
		case 7:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 7;
			break;
		case 8:
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 8;
			break;
		case 9:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 9;
			break;
		case 10:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 10;
			break;
		case 11:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 11;
			break;
		default:
			console.log(idx);
	}
}

function draw_reservation(date){
	var json = get_reservationList_byDate(date);
	var clinic;
	//예약정보 생성
	var target_tag = "";
	var txt = "";		
	var patient;
	var time;
	var hour;
	var minute;
	var clinic_time;
	var overMinute;
	var end_time;
	
	$(json.reservationListNormal).each(function(){
		patient = get_patient_by_pno(this.pno);
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.normal_rtime);
		hour = parseInt(time/60);
		minute = time%60;
		overMinute = (minute+clinic_time)-60;
		
		if(overMinute >= 0){
			if(overMinute < 10){
				overMinute = "0"+overMinute;
			}
			end_time = (hour+1)+":"+overMinute;
		}else{
			end_time = minute+clinic_time;
		}
		if(minute == 0){
			minute = "0"+minute;
		}
		
		if(this.rtype == '일반진료'){
			target_tag = ".doctor_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:"+clinic.color+";border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
			$(target_tag).append(txt);
		}else if(this.rtype == '일반치료'){
			target_tag = ".therapist_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:"+clinic.color+";border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
			$(target_tag).append(txt);
		}
		
	});
	
	$(json.reservationListFix).each(function(){
		patient = get_patient_by_pno(this.pno);
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.fix_rtime);
		hour = parseInt(time/60);
		minute = time%60;
		overMinute = (minute+clinic_time)-60;
		
		if(overMinute >= 0){
			if(overMinute < 10){
				overMinute = "0"+overMinute;
			}
			end_time = (hour+1)+":"+overMinute; 
		}else{
			end_time = minute+clinic_time;
		}
		if(minute == 0){
			minute = "0"+minute;
		}
		
		if(this.rtype == '고정진료'){
			target_tag = ".doctor_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#ffaf7a;border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
			$(target_tag).append(txt);
		}else if(this.rtype == '고정치료'){
			target_tag = ".therapist_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#ffaf7a;border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
			$(target_tag).append(txt);
		}
		
	});
}

function get_reservation_byRno(rno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationInfoByRno/"+rno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		}
	});
	return dt;
}

function get_clinic_by_cno(cno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/clinicGetByCno/"+cno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		}
	});
	return dt;
}


//진료, 치료 테이블에서 예약된환자 이름에 마우스 올리면 좌측하단에 예약정보 나타내는 함수
function draw_simple_reservation_view(rno){
	var json = get_reservation_byRno(rno);
	var patient = get_patient_by_pno(json.pno);
	var clinic = get_clinic_by_cno(json.clinic);
	var clinic_time = Number(clinic.time);
	var rtime;
	var hour;
	var minute;
	var overMinute;
	var start_time;
	var end_time="";
	var doctor;
	var therapist;
	var employee = get_employee_byEno(json.eno);
	/* if(json.rtype == "일반치료" || json.rtype == "고정치료"){
		therapist = get_employee_byEno(json.eno);
	}else{
		doctor = get_employee_byEno(json.eno);
	} */
	
	var str="";
	str="<p class='al_tbl_wrap2_title'>"+json.rtype+"예약 &nbsp;&nbsp;<span style='color:#333;font-size:14px;letter-spacing:0;'>[닫기]</span></p><table id='tbl_simple_reservation'>";
	/* if(json.main_doctor == "" || json.main_doctor == null){
		str += "<tr><td class='tbl_content_pName'>"+patient.name+"("+patient.cno+")님 ▶"+ therapist.name+"</td></tr>";
	}else{
		str += "<tr><td class='tbl_content_pName'>"+patient.name+"("+patient.cno+")님 ▶"+ doctor.name+"</td></tr>"; 
	} */
	str += "<tr><td class='tbl_content_pName'>"+patient.name+"("+patient.cno+")님 ▶"+ employee.name+"</td></tr>";
	
	
	str+="<tr><th class='tbl_content_title'>- 예약일시</th></tr>";
	if(json.rtype == '일반진료' || json.rtype == '일반치료'){
		rtime = Number(json.normal_rtime);
		hour = parseInt(rtime/60);
		minute = rtime%60;
		overMinute = (minute+clinic_time)-60;
		
		if(overMinute >= 0){
			//console.log(overMinute);
			if(overMinute < 10){
				overMinute = "0"+overMinute;
				//console.log(overMinute);
			}
			end_time = (hour+1)+":"+overMinute;
		}else{
			end_time = hour+":"+(minute+clinic_time);
		}
		
		if(minute == 0){
			minute = "0"+minute;
		}
		start_time = hour+":"+minute;
		
		str += "<tr><td class='tbl_content'>"+json.normal_date+" "+start_time+"~"+end_time+"</td></tr>"
			+"<tr><th class='tbl_content_title'>- 진료종류</th></tr>";
	}else if(json.rtype == '고정진료' || json.rtype == '고정치료'){
		rtime = Number(json.fix_rtime);
		hour = parseInt(rtime/60);
		minute = rtime%60;
		overMinute = (minute+clinic_time)-60;
		console.log(overMinute);
		if(overMinute >= 0){
			//console.log(overMinute);
			if(overMinute < 10){
				overMinute = "0"+overMinute;
				//console.log(overMinute);
			}
			end_time = (hour+1)+":"+overMinute;
		}else{
			end_time = hour+":"+(minute+clinic_time);
		}
		
		if(minute == 0){
			minute = "0"+minute;
		}
		start_time = hour+":"+minute;
		str += "<tr><td class='tbl_content'>"+json.fix_day+"요일 "+start_time+"~"+end_time+"</td></tr>"
			+"<tr><th class='tbl_content_title'>- 치료종류</th></tr>";
	}
	str += "<tr><td class='tbl_content'>"+clinic.code_name+"</td></tr>"
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
		
	$(".al_tbl_wrap2").css("display","block");
}

function post_reservation_register(vo){
	console.log("post_reservation_register 진입");
	console.log(vo);
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationRegister",
		type:"post",
		dataType:"text",
		data:vo,
		async:false,
		success:function(json){
			console.log(json);
			if(json == "OK"){
				alert("예약등록이 완료되었습니다.");
				$("#reservation_view_btn").html("");
				$(".reservation_register_btn").css("display", "none");
				$("#reservation_view_btn").css("display", "none");
				$(".popup_reservation_register").css("display", "none");
				$(".popup_therapy_reservation_register").css("display", "none");
				$(".popup_wrap").css("display","none");
				
				draw_time_table_by_case(storage_timetable_btn_num);
			}else{
				alert("예약등록이 정상적으로 등록되지 않았습니다. 다시 한번 등록하세요.");
			}
		}
	});
}

//주간 선택하면 select 태그에 값 설정
function draw_week_calendar(date, emp, type){
	
	var today = $(".calendar_select_date").val();
	var year = Number(today.substring(0,4));
	var month = today.substring(5,7);
	var str  = "";
	for(i=year-3; i < year+4; i++){
		if(i == year){
			str += "<option value='"+i+"' selected='selected'>"+i+"년</option>";
		}else{
			str += "<option value='"+i+"'>"+i+"년</option>";
		}
	}
	$("#sh_year").html(str);
	str = "";
	$("#sh_month > option[value='"+month+"']").prop("selected","selected");
	
	$(emp).each(function(){
		str += "<option value='"+this.eno+"'>"+this.name+"</option>";
	});
	$(".week_select_box_wrap > select[name='employee']").html(str);
	str="";
	
	makeWeekSelectOptions(type);
	
	
	
}

function draw_week_timetable(etype){
	var week_time=get_hospitalInfo_byDay("주간");
	var week_sTime=Number(week_time.start_time)/60;
	var week_eTime=Number(week_time.end_time)/60;
	var employee = $(".week_select_box_wrap > select[name='employee']").val();
	var select_week = $("#sh_week").val();
	var select_week_split = select_week.split("|"); 
	var sDate = new Date(select_week_split[0]);
	var tomorrow;
	var arrDay = ["일", "월", "화", "수", "목", "금", "토"];
	var arrDate = [select_week_split[0]];
	
	for(var i=1; i < 7; i++){
		tomorrow = new Date(sDate.setDate(sDate.getDate()+1));
		var year1 = tomorrow.getFullYear();//yyyy
		var month1 = (1 + tomorrow.getMonth());//M
		month1 = month1 >= 10 ? month1 : '0' + month1;// month 두자리로 저장
		var day1 = tomorrow.getDate();//d
		day1 = day1 >= 10 ? day1 : '0' + day1;//day 두자리로 저장
		tomorrow = year1+'-'+month1+'-'+day1;
		arrDate.push(tomorrow);
	}
	
	str = "<table><tr><td></td>";
	
	for(var i=week_sTime; i < week_eTime; i++){
		str += "<td >"+i+"시</td>";
	}
	str += "</tr>";
	
	for(var i=1; i<7; i++){
		str += "<tr class='"+employee+"_"+arrDate[i]+"'><td>"+arrDay[i]+"("+arrDate[i].split("-")[2]+"일)<input type='hidden' value='"+"test"+"'></td>";
		for(n=8; n < 20; n++){
			str += "<td class='"+employee+"_"+arrDate[i]+"_"+n+"'></td>";
		}
		str += "</tr>";
	}
	str += "</table>";
	
	$(".time_table_wrap").html(str);
	
	draw_week_reservation(arrDate, etype, employee);
}

function draw_week_reservation(week, etype, eno){
	var week_reservation = [];
	var json;
	var str="";
	var target_tag = "";
	for(var i=1; i < week.length; i++){
		json = get_reservationList_byDate_byEmployee(week[i], etype, eno) 
		week_reservation.push(json);
	}
	console.log(week_reservation);
	console.log(week_reservation[0].normalVO[0].eno);
	$(week_reservation).each(function(){
		console.log($(this));
	});
}


$(function(){
	//진료view에서 무슨 탭 눌러졌는지 기억하기 위한 변수
	var storage_timetable_btn_num=0;
	
	//달력 생성
	buildCalendar();
	
	$(".calendar_select_date").val(get_today());
	
	//날짜마다 요일 표시
	write_yoil();
	
	//환자table 생성
	draw_patient_table();
	
	draw_time_table_by_case(0); 
	
	
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
		$(".calendar_select_date").val(fulldate);
		//draw_time_table(fulldate);
		$(".time_table_wrap").html("");
		
		draw_time_table_by_case(storage_timetable_btn_num);
	 });
	
	//환자table에서 페이지 클릭
	$(document).on("click", ".page > ul > li > a", function(e){
		e.preventDefault();
		draw_patient_table($(this).attr("href"));
	});
	
	//환자table 환자 검색
	$("#searchBtn").click(function(){
    	var s=$("select[name='searchType']").val();
		var searchType = encodeURIComponent(s);
		var k=$("input[name='keyword']").val();
		var keyword = encodeURIComponent(k);
		draw_patient_table("page=1&perPageNum=10&searchType="+searchType+"&keyword="+keyword);
		
	});
	
	//환자테이블에서 정보 수정 클릭했을 때
	$(document).on("click", ".patient_update_btn", function(){
		var pno=$(this).parent().parent().find("input[type='hidden']").val();
		
		draw_patient_update_view(pno);
	});
	
	//환자정보수정 view에서 버튼 클릭
	$(".popup_patient_update_submit_wrap > p").click(function(){
		var idx = $(this).index();
		if(idx == 0){
			var pno = $(".popup_patientUpdate > input[name='pno']").val();
			var cno = $(".popup_patientUpdate > table tr td > input[name='cno']").val();
			var name =  $(".popup_patientUpdate > table tr td > input[name='name']").val();
			var phone = $(".popup_patientUpdate > table tr td > input[name='phone']").val();
			var birth = $(".popup_patientUpdate > table tr td > input[name='birth']").val();
			var gender = $(".popup_patientUpdate > table tr td > select[name='gender']").val();
			var main_doctor = $(".popup_patientUpdate > table tr td > select[name='main_doctor']").val();
			var main_doctor_name = $(".popup_patientUpdate > table tr td > select[name='main_doctor'] option:selected").html();
			var main_therapist = $(".popup_patientUpdate > table tr td > select[name='main_therapist']").val();
			var mail = $(".popup_patientUpdate > table tr td > input[name='mail']").val();
			var memo = $(".popup_patientUpdate > table tr td > input[name='memo']").val();
			var patient={pno:pno, cno:cno, name:name, phone:phone, birth:birth, gender:gender, main_doctor:main_doctor, main_doctor_name:main_doctor_name, main_therapist:main_therapist, mail:mail, memo:memo};
			
			post_patient_update_info(patient);
		}else{
			$(".popup_patientUpdate").css("display", "none");
			$(".popup_wrap").css("display","none");
		}
	});
	
	//헤더에 있는 환자이름 버튼
	$("#reservation_view_btn").click(function(){
		$(this).css("display", "none");
		$("#reservation_view_btn").html("");
		$(".reservation_register_btn").css("display", "none");
		
	});
	
	//진료table 선택 버튼
	$(".timetable_btn_wrap > ul > li").click(function(){
		var idx = $(this).index();
		draw_time_table_by_case(idx);
		storage_timetable_btn_num = idx;
	});
	
	//진료, 치료 테이블에서 예약에 마우스 올리고 치웠을때
	$(document).on({
		mouseenter:function(){
			var rno=$(this).find("input[type='hidden']").val(); 
			draw_simple_reservation_view(rno);
		},
		mouseleave:function(){}
		}, ".patient_p_tag");/*  */
		
	$(document).on("click", ".al_tbl_wrap2 > .al_tbl_wrap2_title", function(){
		$(".al_tbl_wrap2").css("display","none");
		$(".al_tbl_wrap2").html("");
	});
		
	//환자 리스트에서 예약-선택 버튼 클릭
	$(document).on("click", ".reservation_select_btn", function(){
		var reservation_click_pno = $(this).parent().parent().find("input[type='hidden']").val();
		var reservation_click_cno = $(this).parent().parent().find("td").eq(9).html();
		$("#reservation_view_btn").html($(this).parent().parent().find("td").eq(1).html()+"<input type='hidden' name='pno' value='"+reservation_click_pno+"'><input type='hidden' name='cno' value='"+reservation_click_cno+"'>");
		$("#reservation_view_btn").css("display", "inline-block");
		$(".reservation_register_btn").css("display", "block");
	});
	
	//진료테이블에서 + 클릭
	$(document).on("click", ".doctor_time_table .reservation_register_btn", function(){
		var select_doctor_time = $(this).parent().prop("class");
		var split_className = select_doctor_time.split(" ");//class가 2개라서 공백으로 걸러내면 첫번째 배열에는 doctor_의사번호_시간 걸러짐
		var split_doctor_time=split_className[0].split("_");
		
		var select_date_hospital_time_info = get_hospitalInfo_byDay($(".calendar_select_date").val());
		var select_day = get_day($(".calendar_select_date").val());
		
		var starttime=Number(select_date_hospital_time_info.start_time)/60;
		var endtime=Number(select_date_hospital_time_info.end_time)/60;
		
		var eno=split_doctor_time[1];
		var time=split_doctor_time[2];
		
		var str = "";
		for(i=starttime; i < endtime; i++){
			str += "<option value='"+i+"'>"+i+"시</option>";
		}
		$(".popup_content > table tr > td > select[name='fix_rtime1']").html(str);
		
		$(".popup_reservation_register > h2 > span").html($("#reservation_view_btn").text()+"("+$("#reservation_view_btn > input[name='cno']").val()+")님");
		$(".popup_reservation_register > table td > select[name='clinic'] > option[value='']").prop("selected", true);
		$(".popup_reservation_register > table td > select[name='eno'] > option[value='"+eno+"']").prop("selected", true);
		$(".popup_reservation_register_date").text($(".calendar_select_date").val()+" "+time);
		$(".popup_reservation_register > table tr > td > select[name='fix_rtime1'] > option[value='"+time+"']").prop("selected", true);
		$(".popup_reservation_register > table tr > td > select[name='fix_day'] > option[value='"+select_day+"']").prop("selected", true);
		
		$(".popup_wrap").css("display", "block");
		$(".popup_reservation_register").css("display", "block");
	});
	
	//치료테이블에서 + 클릭
	$(document).on("click", ".therapist_time_table .reservation_register_btn", function(){
		var select_therapist_time = $(this).parent().prop("class");
		var split_className = select_therapist_time.split(" ");//class가 2개라서 공백으로 걸러내면 첫번째 배열에는 doctor_의사번호_시간 걸러짐
		var split_therapist_time=split_className[0].split("_");
		
		var select_date_hospital_time_info = get_hospitalInfo_byDay($(".calendar_select_date").val());
		var select_day = get_day($(".calendar_select_date").val());
		
		var starttime=Number(select_date_hospital_time_info.start_time)/60;
		var endtime=Number(select_date_hospital_time_info.end_time)/60;
		
		var eno=split_therapist_time[1];
		var time=split_therapist_time[2];
		
		var str = "";
		for(i=starttime; i < endtime; i++){
			str += "<option value='"+i+"'>"+i+"시</option>";
		}
		$(".popup_content > table tr > td > select[name='fix_rtime1']").html(str);
		
		$(".popup_therapy_reservation_register > h2 > span").html($("#reservation_view_btn").text()+"("+$("#reservation_view_btn > input[name='cno']").val()+")님");
		$(".popup_therapy_reservation_register > table td > select[name='eno'] > option[value='"+eno+"']").prop("selected", true);
		$(".popup_reservation_register_date").text($(".calendar_select_date").val()+" "+time);
		$(".popup_therapy_reservation_register > table tr > td > select[name='fix_rtime1'] > option[value='"+time+"']").prop("selected", true);
		$(".popup_therapy_reservation_register > table tr > td > select[name='fix_day'] > option[value='"+select_day+"']").prop("selected", true);
		
		$(".popup_wrap").css("display", "block");
		$(".popup_therapy_reservation_register").css("display", "block");
	});
	
	//예약view에서 예약등록, 예약접수, 취소 버튼 기능
	$(".popup_content .popup_reservation_register_btn_wrap > p").click(function(){
		var idx = $(this).index();
		
		//예약등록
		if(idx == 0){
			var vo;
			if($(".popup_reservation_register").css("display") == "block"){
				var selectDate = $(".popup_reservation_register_date").eq(0).text();
				var split_date = selectDate.split(" ");
				
				var pno = $("#reservation_view_btn > input[name='pno']").val();
				var eno = $(".popup_reservation_register > table tr td > select[name='eno']").val();
				var rtype = $(".popup_reservation_register > table tr td > select[name='rtype']").val();
				var normal_date = split_date[0]+"";
				var normal_time_minute = Number($(".popup_reservation_register > table tr td > select[name='normal_time_minute']").val());
				var normal_rtime = (Number(split_date[1])*60)+normal_time_minute+"";
				var fix_day = $(".popup_reservation_register > table tr > td > select[name='fix_day']").val();
				var fix_rtime1 = Number($(".popup_reservation_register > table tr > td > select[name='fix_rtime1']").val())*60;
				var fix_rtime2 = Number($(".popup_reservation_register > table tr > td > select[name='fix_rtime2']").val());
				var fix_rtime = fix_rtime1+fix_rtime2+"";
				var fix_day_start = $(".popup_reservation_register > table tr > td > input[name='fix_day_start']").val();
				var fix_day_end = $(".popup_reservation_register > table tr > td > input[name='fix_day_end']").val();
				var clinic = $(".popup_reservation_register > table tr td > select[name='clinic']").val();
				var memo = $(".popup_reservation_register > table tr td input[name='memo']").val();
				var writer = $("#session_login_name").val();
				var regdate = get_today();
				var updatewriter = "";
				var updatedate = "";
				var desk_state="";
				var therapist_state="";
				var result = "";
				console.log(jQuery.type(fix_rtime));
				if(rtype == "일반진료"){
					vo = {pno:pno, eno:eno, fix_day:"", fix_rtime:"", fix_day_start:"", fix_day_end:"", rtype:rtype, normal_date:normal_date, normal_rtime:normal_rtime, clinic:clinic, memo:memo, writer:writer, regdate:regdate, updatewriter:updatewriter, updatedate:updatedate, desk_state:"", therapist_state:"", result:result};
				}else if(rtype == "고정진료"){
					vo = {pno:pno, eno:eno, fix_day:fix_day, fix_rtime:fix_rtime, fix_day_start:fix_day_start, fix_day_end:fix_day_end, rtype:rtype, normal_date:"", normal_rtime:"", clinic:clinic, memo:memo, writer:writer, regdate:regdate, updatewriter:updatewriter, updatedate:updatedate, desk_state:"", therapist_state:"", result:result};
				}
			}else{
				var selectDate = $(".popup_reservation_register_date").eq(1).text();
				var split_date = selectDate.split(" ");
				
				var pno = $("#reservation_view_btn > input[name='pno']").val();
				var eno = $(".popup_therapy_reservation_register > table tr td > select[name='eno']").val();
				var rtype = $(".popup_therapy_reservation_register > table tr td > select[name='rtype']").val();
				var normal_date = split_date[0]+"";
				var normal_time_minute = Number($(".popup_therapy_reservation_register > table tr td > select[name='normal_time_minute']").val());
				var normal_rtime = (Number(split_date[1])*60)+normal_time_minute+"";
				var fix_day = $(".popup_therapy_reservation_register > table tr > td > select[name='fix_day']").val();
				var fix_rtime1 = Number($(".popup_reservation_register > table tr > td > select[name='fix_rtime1']").val())*60;
				var fix_rtime2 = Number($(".popup_reservation_register > table tr > td > select[name='fix_rtime2']").val());
				var fix_rtime = fix_rtime1+fix_rtime2;
				var fix_day_start = $(".popup_therapy_reservation_register > table tr > td > input[name='fix_day_start']").val();
				var fix_day_end = $(".popup_therapy_reservation_register > table tr > td > input[name='fix_day_end']").val();
				var clinic = $(".popup_therapy_reservation_register > table tr td > select[name='clinic']").val();
				var memo = $(".popup_therapy_reservation_register > table tr td input[name='memo']").val();
				var writer = $("#session_login_name").val();
				var regdate = get_today();
				var updatewriter = "";
				var updatedate = "";
				var result="";
				
				if(rtype == "일반치료"){
					vo = {pno:pno, eno:eno, fix_day:"", fix_rtime:"", fix_day_start:"", fix_day_end:"", rtype:rtype, normal_date:normal_date, normal_rtime:normal_rtime, clinic:clinic, memo:memo, writer:writer, regdate:regdate, updatewriter:updatewriter, updatedate:updatedate, result:result};
				}else if(rtype == "고정치료"){
					vo = {pno:pno, eno:eno, fix_day:fix_day, fix_rtime:fix_rtime, fix_day_start:fix_day_start, fix_day_end:fix_day_end,  rtype:rtype, normal_date:"", normal_rtime:"", clinic:clinic, memo:memo, writer:writer, regdate:regdate, updatewriter:updatewriter, updatedate:updatedate, result:result};
				}
			}
			post_reservation_register(vo);
			
		}else if(idx == 2){//취소
			
			$(".popup_reservation_register").css("display", "none");
			$(".popup_therapy_reservation_register").css("display", "none");
			$(".popup_wrap").css("display","none");
		}
	});
	
	//주간 select에서 주 변경되었을때 timetable 변경해서 삽입
	$("#sh_week").change(function(){
		draw_week_timetable("doctor");
	})
	//주간 select에서 의사 및 치료사 변경되었을때 timetable 변경해서 삽입
	$(".week_select_box_wrap > select[name='employee']").change(function(){
		draw_week_timetable("doctor");
	});

});
</script> 
</head> 
<body>
	<div class="popup_wrap">
		<jsp:include page="../include/popup.jsp"></jsp:include>
	</div><!-- popup_wrap end -->
	
	
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside_left">
				<div class="al_tbl_wrap_1">
				<input class='calendar_select_date' type="hidden" value=''>
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
					<div class="search_wrap">
						<select name="searchType">
							<option value="name" ${cri.searchType=='t'?'selected':''}>이름</option>
							<option value="cno" ${cri.searchType=='c'?'selected':''}>차트번호</option>
							<option value="maindoctor" ${cri.searchType=='r'?'selected':''}>담당의사</option>
							<option value="maintherapist" ${cri.searchType=='t'?'selected':''}>담당치료사</option>
							<option value="phone" ${cri.searchType=='c'?'selected':''}>연락처</option>
						</select> 
						<input type="text" name="keyword" id="keywordInput" value="">
						<button id="searchBtn">검색</button>
					</div><!-- search_wrap end -->
					<div id="inner_tbl_wrap">
					
					</div>
					
				</div><!-- ar_tbl_wrap_1 end-->
				<div class="ar_tbl_wrap_2">
					<div class="timetable_btn_wrap">
						<ul>
							<li>진료&치료 종합</li>
							<li>진료종합</li>
							<li>주간</li>
							<li>고정</li>
							<li>치료종합</li>
							<li>주간</li>
							<li>고정</li>
							<li>예약이력</li>
							<li>변경이력</li>
							<li>희망예약</li>
							<li></li>
							<li></li>
							<li></li>
						</ul>
					</div><!-- timetable_btn_wrap -->
					<div class="week_select_box_wrap">
						<select name="sh_year" id="sh_year" onchange="makeWeekSelectOptions();">
							<!-- <option value='2018'>2018년</option>
							<option value='2019' selected='selected'>2019년</option>
							<option value='2020'>2020년</option>
							<option value='2021'>2021년</option> -->
						</select>
							 
						<select name="sh_month" id="sh_month" onchange="makeWeekSelectOptions();">
							<option value='01'>01월</option>
							<option value='02'>02월</option>
							<option value='03'>03월</option>
							<option value='04'>04월</option>
							<option value='05'>05월</option>
							<option value='06'>06월</option>
							<option value='07'>07월</option>
							<option value='08'>08월</option>
							<option value='09'>09월</option>
							<option value='10'>10월</option>
							<option value='11'>11월</option>
							<option value='12'>12월</option>
						</select>
						<select name="sh_week" id="sh_week">
						</select>
						<select name="employee">
						</select>
					</div><!-- week_select_box_wrap end -->
					<div class="time_table_wrap">
					
					</div><!-- time_table_wrap -->
				</div><!-- ar_tbl_wrap_2 end -->
				<div class="ar_tbl_wrap_3">
					
					
				</div><!-- ar_tbl_wrap_3 end -->
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div><!-- footer_wrap end -->
	</div><!-- body_wrap end -->
</body>
</html> 