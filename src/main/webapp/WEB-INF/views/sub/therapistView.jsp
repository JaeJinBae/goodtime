<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원마취통증의학과 예약관리</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/week_calendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/patient_week_calendar.js"></script>
<meta name="viewport" content="width=1400px, initial-scale=1.0">
<style>
	html{
		overflow: hidden;
	}
	.popup_wrap{
		width:100%;
		position:fixed;
		top:0;
		left:0;
		display:none;
		z-index: 9999;
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
	
	.all_wrap{
		width: 100%;
		height: 100%;
		padding-bottom:50px;
		position: relative;
	}
	.header{
		width:100%;
		position: fixed;
		top:0;
		background: #fff;
	}
	.header_inner2 > ul > li:first-child{
		background: #0068b8;
	}
	.header_inner2 > ul > li:first-child > a{
		color: #fff; 
		font-weight: bold;
	}
	.section{
		margin-top:70px;
		width:100%;
		min-width: 1400px;
		height: 100%;
		/* overflow: scroll; */
		position: relative;
	}
	.aside_left{
		position:fixed;
		left:0;
		width: 265px;
		height:100%;
		float:left;
		border-right: 1px solid lightgray; 
		padding-top:12px;
	}
	.topView_btn{
		margin: 0 auto;
		margin-bottom: 20px;
		text-align: center;
	}
	.topView_btn > p{
		cursor: pointer;
		display:inline-block;
		font-size:15px;
		background: #3294c6;
		color: #fff;
		border-radius: 3px;
		padding:5px;
	}
	.topView_btn > p:nth-child(3){
		background: #1e866a;
	}
	.topView_btn > p > img{
		width:17px;
		margin-right: 2px;
	}
	.aside_left > .al_tbl_wrap_1{
		width: 100%;
	}
	.aside_left > .al_tbl_wrap_1 > .today_btn{
		font-size: 14px;
		width:70px;
		margin: 0 auto;
		text-align: center;
		cursor: pointer;
		background: #494949;
		color: #fff;
		padding: 3px 0;
		border-radius: 3px;
		letter-spacing: 1px;
	}
	.aside_left > .al_tbl_wrap_1 > #calendar{
		margin: 0 auto;
	}
	.aside_left > .al_tbl_wrap_1 > #calendar td{
		width:30px;
		height:30px;
		font-size:16px;
		font-weight: bold;
		text-align: center;
		cursor: pointer;
		border-radius: 5px;
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
		margin-top:30px;
		display:none;
	}
	.al_tbl_wrap2_title{
		width: 260px;
		text-align: center;
		margin: 0 auto;
		background: #de5e5d;
		color: #fff;
		font-size:18px;
		font-weight: bold;
		text-align: center;
		padding: 11px 0;
		letter-spacing: 5px;
		position: relative;
	}
	.al_tbl_wrap2 > .al_tbl_wrap2_title > span{
		cursor: pointer;
		position: absolute;
		top: 0px;
		right: 0px;
		width: 43px;
		height: 100%;
		padding-top: 9px;
		font-size: 24px;
		font-weight: bold; 
		background: red;
		color: #fff;
	}
	.al_tbl_wrap2 > .simple_tbl_wrap{
		width: 260px;
		margin: 0 auto;
		border: 1px solid lightgray;
		padding:15px 0px 15px 7px;
		background: #fff; 
	}
	#tbl_simple_reservation{
		width:100%;
	}
	#tbl_simple_reservation tr{
		
	}
	#tbl_simple_reservation th, #tbl_simple_reservation td{
		font-size:14px;
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
		font-size:14px;
	}
	#tbl_simple_reservation tr > td .patient_simple_record{
		width: 100%;
		max-height:100px;
		overflow: auto;
	}
	#tbl_simple_reservation tr > td .patient_simple_record > p{
		margin-bottom:5px;
	}
	#tbl_simple_reservation tr > td .patient_simple_record > p > span{
		font-size: 14px;
		font-weight: bold; 
	}
	.aside_right {
		position:fixed;
		left: 275px;
		float:left;
		min-width:1000px;
		height:100%;
		overflow: auto;
		padding-bottom:100px;
		padding-right:15px;
		padding-top:20px; 
	}
	
	.ar_tbl_wrap_1{
		width:100%;
	}
	.search_wrap{
		float:left;
		margin-bottom:20px;
	}
	.search_wrap > select{
		font-size: 15px;
		padding: 3px 5px;
	}
	.search_wrap > input {
		font-size: 15px;
		padding: 3px 5px;
	}
	.search_wrap > button{
		font-size:15px;
		padding: 5px 10px;
		margin-left:10px;
		letter-spacing: 1px;
		background: #1e866a;
		border-radius: 3px;
		color: #fff;
	}
	.patient_register_btn_wrap{
		float:right;
	}
	.patient_register_btn_wrap > button{
		font-size:15px;
		border: 1px solid lightgray;
		padding: 5px 10px;
		letter-spacing: 1px;
		background: #1e866a;
		border-radius: 4px;
		color: #fff;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap{
		clear: both;
		overflow:hidden;
	}
	.week_select_box_wrap{
		display:none;
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
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child{
		background: #f5f5f5;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:first-child{
		width:0;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(2){
		width:70px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(3){
		width:80px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(4){
		width:80px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(5){
		width:120px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(6){
		width:110px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(7){
		
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(8){
		width:70px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(9){
		width:70px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:nth-child(10){
		width:80px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr:first-child > th:last-child{
		width:80px;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr td{
		font-size: 14px;
		text-align: center;
		border-bottom: 1px solid lightgray;
		padding: 2px 0;
	}
	.ar_tbl_wrap_1 > #inner_tbl_wrap > table tr td > p > img{
		width: 20px;
	}
	.patient_update_btn, .sms_open_btn, .reservation_select_btn{
		width:60px;
		margin: 0 auto;
		padding: 2px 0;
		font-size:14px;
		background: #f3f3f3;
		color: #777;
		cursor: pointer;
		border: 1px solid #a0a0a0;
		border-radius: 6px;
		text-align: center;
	}
	.page{
		margin: 15px auto;
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
		border-radius: 8px;
		margin: 0 1px;
		background: #fafafa;
	}
	.active1{
		background: #e02c4f !important;
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
		margin-top:50px;
		margin-bottom:50px;
	}
	.ar_tbl_wrap_2 > .selectBox_wrap{
		margin-bottom:20px;
	}
	.ar_tbl_wrap_2 > .selectBox_wrap > select{
		font-size: 15px;
		padding: 3px 5px;
	}
	.ar_tbl_wrap_2 > .selectBox_wrap > input {
		font-size: 15px;
		padding: 3px 5px;
	}
	.ar_tbl_wrap_2 > .selectBox_wrap > button{
		font-size:15px;
		padding: 5px 10px;
		margin-left:10px;
		letter-spacing: 1px;
		background: #1e866a;
		border-radius: 3px;
		color: #fff;
	}
	.ar_tbl_wrap_2 > .time_table_wrap > table tr:first-child{
		background: #f3f3f3;
	}
	.ar_tbl_wrap_2 > .time_table_wrap > table tr th{
		font-size: 15px;
	}
	.ar_tbl_wrap_2 > .time_table_wrap > table tr > td{
		padding:5px 3px;
	}
	.tbl_reservation_record tr > th{
		border-top:2px solid #5e5e5e;
		border-bottom:2px solid #5e5e5e;
		padding:8px 3px;
		font-weight: bold;
	}
	.tbl_reservation_record tr > th:first-child{
		width:90px;
	}
	.tbl_reservation_record tr > th:nth-child(2){
		width:90px;
	}
	.tbl_reservation_record tr > th:nth-child(3){
		width:90px;
	}
	.tbl_reservation_record tr > th:nth-child(4){
		width:135px;
	}
	.tbl_reservation_record tr > th:nth-child(5){
		width:150px;
	}
	.tbl_reservation_record tr > th:nth-child(6){
		width:190px;
	}
	.tbl_reservation_record tr > th:nth-child(7){
		width:225px;
	}
	.tbl_reservation_record tr > th:nth-child(8){
		width:190px;
	}
	.tbl_reservation_record tr > td{
		text-align: center;
		padding: 8px 3px !important;
		border: 0 !important;
		border-bottom: 1px solid lightgray !important;
	}
	.reservation_record_page{
		margin: 15px auto;
	}
	.reservation_record_page > ul{
		text-align: center;
	}
	.reservation_record_page ul li{
		margin:0 auto;
		list-style: none;
		display: inline-block;
		text-align:center;
		border:1px solid #e9e9e9;
		border-radius: 8px;
		margin: 0 1px;
		background: #fafafa;
	}
	.reservation_record_page ul li a{
		display:inline-block;
		width:35px;
		height:30px;
		font-size:1.1em;
		line-height: 30px;
	}
	
	.tbl_reservation_update_record tr > th{
		border-top:2px solid #5e5e5e;
		border-bottom:2px solid #5e5e5e;
		padding:8px 3px;
		font-weight: bold;
	}
	.tbl_reservation_update_record tr > th:first-child{
		width:90px;
	}
	.tbl_reservation_update_record tr > th:last-child{
		max-width:280px;
	}
	.tbl_reservation_update_record tr > td{
		text-align: center;
		padding: 8px 3px !important;
		border: 0 !important;
		border-bottom: 1px solid lightgray !important;
	}
	.reservation_update_record_page{
		margin: 15px auto;
	}
	.reservation_update_record_page > ul{
		text-align: center;
	}
	.reservation_update_record_page ul li{
		margin:0 auto;
		list-style: none;
		display: inline-block;
		text-align:center;
		border:1px solid #e9e9e9;
		border-radius: 8px;
		margin: 0 1px;
		background: #fafafa;
	}
	.reservation_update_record_page ul li a{
		display:inline-block;
		width:35px;
		height:30px;
		font-size:1.1em;
		line-height: 30px;
	}
	
	.tbl_normal_off tr > th{
		border-top:2px solid #5e5e5e;
		border-bottom:2px solid #5e5e5e;
		padding:8px 3px;
		font-weight: bold;
	}
	.tbl_normal_off tr > td{
		text-align: center;
		padding: 5px 3px !important;
		border: 0 !important;
		border-bottom: 1px solid lightgray !important;
	}
	.tbl_normal_off tr > td > button{
		font-size:15px;
		border:1px solid lightgray;
		border-radius: 3px;
		background: gray;
		color:#fff;
		padding:5px 10px;
	}
	.normal_off_page{
		margin: 15px auto;
	}
	.normal_off_page > ul{
		text-align: center;
	}
	.normal_off_page ul li{
		margin:0 auto;
		list-style: none;
		display: inline-block;
		text-align:center;
		border:1px solid #e9e9e9;
		border-radius: 8px;
		margin: 0 1px;
		background: #fafafa;
	}
	.normal_off_page ul li a{
		display:inline-block;
		width:35px;
		height:30px;
		font-size:1.1em;
		line-height: 30px;
	}
	
	.tbl_fix_off tr > th{
		border-top:2px solid #5e5e5e;
		border-bottom:2px solid #5e5e5e;
		padding:8px 3px;
		font-weight: bold;
	}
	.tbl_fix_off tr > th:nth-child(3){
		width:100px;
	}
	.tbl_fix_off tr > td{
		text-align: center;
		padding: 5px 3px !important;
		border: 0 !important;
		border-bottom: 1px solid lightgray !important;
	}
	.tbl_fix_off tr > td > button{
		font-size:15px;
		border:1px solid lightgray;
		border-radius: 3px;
		background: gray;
		color:#fff;
		padding:5px 10px;
	}
	.fix_off_page{
		margin: 15px auto;
	}
	.fix_off_page > ul{
		text-align: center;
	}
	.fix_off_page ul li{
		margin:0 auto;
		list-style: none;
		display: inline-block;
		text-align:center;
		border:1px solid #e9e9e9;
		border-radius: 8px;
		margin: 0 1px;
		background: #fafafa;
	}
	.fix_off_page ul li a{
		display:inline-block;
		width:35px;
		height:30px;
		font-size:1.1em;
		line-height: 30px;
	}
	
	
	
	.timetable_btn_wrap{
		width:645px;
		margin-bottom:20px;
	}
	.timetable_btn_wrap > ul{
		width: 100%;
		margin-right:30px;
		overflow:hidden;
		background: #353c46;
	}
	.timetable_btn_wrap > ul > li{
		float:left;
		font-size:15px;
		color: #fff;
		padding:8px 12px; 
		cursor: pointer;
		border-right: 1px solid lightgray;
	}
	.timetable_btn_wrap > ul > li:first-child{
		font-size:15px;
		font-weight: bold;
		background: #0068b8;
	}
	.timetable_btn_wrap > ul > li:last-child{
		border-right: 0;
	}
	
	
	
	.time_table_wrap > table{
		width:100%;
	}
	.time_table_wrap table tr > td{
		border: 1px solid lightgray;
		font-size:15px;
	}
	.time_table_wrap table tr > td:first-child{
		text-align: center;
		width: 80px;
	}
	.patient_p_tag{
		font-size:14px;
		cursor: pointer;
		line-height: 22px;
		padding: 4px 3px;
		color: #fff;
		border-radius: 3px;
	}
	.patient_p_tag > img{
		margin-left:1px;
	}
	.footImg, .handImg{
		width:12px;
		vertical-align: middle;
	}
	
	.res_no{
		font-size:14px;
		padding: 4px 3px;
		border-radius: 3px;
		line-height: 22px;
	}
	
	.patient_waitingRes_tag{
		font-size:14px;
		cursor: pointer;
		line-height: 22px;
		padding: 4px 3px;
		color: #fff;
		border-radius: 3px;
	}
	.patient_waitingRes_tag > img{
		margin-left:1px;
		width: 20px;
		vertical-align: middle;
	}
	.reservation_register_btn{
		display:none;
		width:20px;
		height:20px;
		color:#fff;
		font-weight: bold;
		text-align:center;
		font-size:20px;
		background: #5f5f5f;
		border-radius: 7px;
		cursor:pointer;
	}
	.reservation_record_selectBox_wrap{
		display:none;
	}
	.reservation_update_record_selectBox_wrap{
		display:none;
	}
	.normal_off_selectBox_wrap{
		display:none;
	}
	.fix_off_selectBox_wrap{
		display:none;
	}
	.normal_off, .fix_off{
		width:100%;
		font-size:15px;
		text-align: center;
		padding:3px 0;
		font-weight: bold;
		letter-spacing: 1px;
	}
	.ar_tbl_wrap_3{
		width:100%;
		margin-top:50px;
		margin-bottom:50px;
	}
	
	.ar_tbl_wrap_3 > .timetable_btn_wrap2{
		display:none;
		width:309px;
		margin-bottom:20px;
	}
	.timetable_btn_wrap2 > ul{
		width: 100%;
		margin-right:30px;
		overflow:hidden;
		background: #353c46;
	}
	.timetable_btn_wrap2 > ul > li{
		float:left;
		font-size:15px;
		color: #fff;
		padding:8px 12px; 
		cursor: pointer;
		border-right: 1px solid lightgray;
	}
	.timetable_btn_wrap2 > ul > li:first-child{
		font-size:15px;
		font-weight: bold;
		background: #0068b8;
	}
	.timetable_btn_wrap2 > ul > li:last-child{
		border-right: 0;
	}
	
	.ar_tbl_wrap_3 > .patient_week_tbl_selectBox_wrap{
		display: none;
		margin-bottom: 20px;
	}
	.ar_tbl_wrap_3 > .patient_week_tbl_selectBox_wrap > select{
		font-size: 15px;
		padding: 3px 5px;
	}
	.ar_tbl_wrap_3 > .patient_time_table_wrap{
		width:100%;
	}
	.patient_time_table_wrap > table{
		width:100%;
	}
	.patient_time_table_wrap > table tr:first-child{
		background: #f3f3f3;
	}
	.patient_time_table_wrap table tr > td{
		border: 1px solid lightgray;
		font-size:15px;
		padding: 5px 3px;
	}
	.patient_time_table_wrap table tr > td:first-child{
		text-align: center;
		width: 80px;
	}
	.patient_res_record_wrap{
		width:100%;
		height:300px;
		overflow: auto;
		overflow-x:hidden;
	}
	.tbl_patient_reservation_record{
		width:100%;
	}
	.tbl_patient_reservation_record tr > th{
		border-top:2px solid #5e5e5e;
		border-bottom:2px solid #5e5e5e;
		padding:8px 3px;
		font-weight: bold;
		font-size:15px;
	}
	.tbl_patient_reservation_record tr > th:first-child{
		width:90px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(2){
		width:90px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(3){
		width:90px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(4){
		width:135px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(5){
		width:150px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(6){
		width:180px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(7){
		width:180px;
	}
	.tbl_patient_reservation_record tr > th:nth-child(8){
		width:180px;
	}
	.tbl_patient_reservation_record tr > td{
		text-align: center;
		padding: 8px 3px !important;
		border: 0 !important;
		border-bottom: 1px solid lightgray !important;
	}
	.tbl_patient_reservation_update_record{
		width:100%;
	}
	.tbl_patient_reservation_update_record tr > th{
		border-top:2px solid #5e5e5e;
		border-bottom:2px solid #5e5e5e;
		padding:8px 3px;
		font-weight: bold;
		font-size: 15px;
	}
	.tbl_patient_reservation_update_record tr > th:first-child{
		width:90px;
	}
	.tbl_patient_reservation_update_record tr > th:last-child{
		max-width:280px;
	}
	.tbl_patient_reservation_update_record tr > td{
		text-align: center;
		padding: 8px 3px !important;
		border: 0 !important;
		border-bottom: 1px solid lightgray !important;
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
		type:"post",
		data:JSON.stringify(info),
		contentType : "application/json; charset=UTF-8",
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

function draw_patient_table(info){
	var json = get_patient_all(info);
	
	var str = "";

	$("#inner_tbl_wrap").empty();
	
	str ="<table><tr><th></th><th>차트번호</th><th>이름</th><th>예약</th><th>연락처</th><th>생년월일</th><th>메모</th><th>담당의사</th><th>회원등급</th><th>문자</th><th>설정</th></tr>";
	
	if(json.patientListAll.length == 0){
		str += "<tr><td colspan='11'>등록된 회원이 없습니다.</td></tr>";
	}else{
		$(json.patientListAll).each(function(){
			str += "<tr class='patientTblTr'><td><input type='hidden' value='"+this.pno+"'></td>"
			+ "<td>"+this.cno+"</td>"
			+ "<td>"+this.name+"</td>"
			+ "<td><p class='reservation_select_btn'><img src='${pageContext.request.contextPath}/resources/images/icon_res.png'> 선택</p></td>"
			+ "<td>"+this.phone+"</td>"
			+ "<td>"+this.birth+"</td>"
			+ "<td>"+this.memo+"</td>"
			+ "<td>"+this.main_doctor_name+"</td>"
			+ "<td>환자</td>"
			+ "<td><p class='sms_open_btn'><img src='${pageContext.request.contextPath}/resources/images/icon_sms.png'></p></td>"
			+ "<td><p class='patient_update_btn'><img src='${pageContext.request.contextPath}/resources/images/icon_update.png'> 수정</p></td></tr>";
		});
	}
	str += "</table>";
	
	str += "<div class='page'><ul>";
	if(json.pageMaker5.prev){
		str += "<li><a href='page="+(json.pageMaker5.startPage-1)+"&perPageNum=5&searchType="+json.pageMaker5.cri.searchType+"&keyword="+json.pageMaker5.cri.keyword+"'>&laquo;</a></li>";
	}
	for(var i=json.pageMaker5.startPage; i<=json.pageMaker5.endPage; i++){
		
		if(json.pageMaker5.cri.page == i){
			str += "<li class='active1'><a class='active2' href='page="+i+"&perPageNum=5&searchType="+json.pageMaker5.cri.searchType+"&keyword="+json.pageMaker5.cri.keyword+"'>"+i+"</a></li>";
		}else{
			str += "<li><a href='page="+i+"&perPageNum=5&searchType="+json.pageMaker5.cri.searchType+"&keyword="+json.pageMaker5.cri.keyword+"'>"+i+"</a></li>"
		}
	}
	if(json.pageMaker5.next){
		str += "<li><a href='page="+(json.pageMaker5.endPage+1)+"&perPageNum=5&searchType="+json.pageMaker5.cri.searchType+"&keyword="+json.pageMaker5.cri.keyword+"'>&raquo;</a></li>";
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
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	return dt;
}

function patient_cno_duplication_check(cno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/patientCnoDuplicationChk/"+cno,
		type:"get",
		dataType:"text",
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

function post_patient_register(patient){
	$.ajax({
		url:"${pageContext.request.contextPath}/patientRegister",
		type:"post",
		dataType:"text",
		data:patient,
		async:false,
		success:function(json){
			$(".popup_patient_register").css("display", "none");
			$(".popup_wrap").css("display","none");
			alert("환자등록이 완료되었습니다.");
			
			$(".popup_patient_register > table tr td > input[name='cno']").val("");
			$(".popup_patient_register > table tr td > input[name='dupliChkNum']").val(0);
			$(".popup_patient_register > table tr td > input[name='name']").val("");
			$(".popup_patient_register > table tr td > input[name='phone']").val("");
			$(".popup_patient_register > table tr td > input[name='birth']").val("");
			$(".popup_patient_register > table tr td > select[name='main_doctor'] option[value='']").prop("selected",true);
			$(".popup_patient_register > table tr td > input[name='memo']").val("");
			var o={};
			draw_patient_table(o);
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
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
			var o={};
			draw_patient_table(o);
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	
	return dt;
}

function get_employee_byEno(eno){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeGetByEno/"+eno,
		type:"get",
		dataTyp:"json",
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
			txt += "<td class='"+this.type+"_"+this.eno+"_"+i+" timetable_inner_content'>";
			txt += "<p class='reservation_register_btn'>+</p></td>";
		}
		txt += "</tr>";
	});
	txt+="</table>";
	return txt;
}

function draw_time_table_by_case(idx){
	var select_date = $(".calendar_select_date").val();
	var table_txt;
	$(".reservation_record_selectBox_wrap").css("display","none");
	$(".reservation_update_record_selectBox_wrap").css("display","none");
	$(".normal_off_selectBox_wrap").css("display","none");
	$(".fix_off_selectBox_wrap").css("display","none");
	var o={};
	
	switch (idx){
		case 0:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			table_txt = draw_total_time_table(select_date, "doctor");
			table_txt += "<br><br><br>";
			table_txt += draw_total_time_table(select_date, "therapist");
			$(".time_table_wrap").append(table_txt);
			draw_reservation(select_date);
			draw_normalOff_in_timetable(select_date);
			draw_fixOff_in_timetable(select_date);
			break;
		case 1:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			table_txt = draw_total_time_table(select_date, "doctor");
			$(".time_table_wrap").append(table_txt);
			draw_reservation(select_date);
			draw_normalOff_in_timetable(select_date);
			draw_fixOff_in_timetable(select_date);
			break;
		case 2:
			$(".time_table_wrap").html("");
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("doctor"), "doctor", idx);
			break;
		case 3:
			$(".time_table_wrap").html("");
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("doctor"), "doctor", idx);
			break;
		case 4:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			table_txt = draw_total_time_table(select_date, "therapist");
			$(".time_table_wrap").append(table_txt);
			draw_reservation(select_date);
			draw_normalOff_in_timetable(select_date);
			draw_fixOff_in_timetable(select_date);
			break;
		case 5:
			$(".time_table_wrap").html("");
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("therapist"), "therapist", idx);
			break;
		case 6:
			$(".time_table_wrap").html("");
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("therapist"), "therapist", idx);
			break;
		case 7:
			$(".week_select_box_wrap").css("display","none");
			$(".reservation_record_selectBox_wrap").css("display","block");
			$(".time_table_wrap").html("");
			draw_reservation_record_table(o);
			break;
		case 8:
			$(".week_select_box_wrap").css("display","none");
			$(".reservation_update_record_selectBox_wrap").css("display", "block");
			$(".time_table_wrap").html("");
			draw_reservation_update_record_table(o);
			break;
		case 9:
			$(".week_select_box_wrap").css("display","none");
			$(".normal_off_selectBox_wrap").css("display","block");
			$(".time_table_wrap").html("");
			draw_normalOff_table(o);
			var todayArr = select_date.split("-");
			
			$(".normal_off_selectBox_wrap > select[name='year'] > option[value='"+todayArr[0]+"']").prop("selected", true);
			$(".normal_off_selectBox_wrap > select[name='month'] > option[value='"+todayArr[1]+"']").prop("selected", true);
			break;
		case 10:
			$(".week_select_box_wrap").css("display","none");
			$(".fix_off_selectBox_wrap").css("display","block");
			$(".time_table_wrap").html("");
			draw_fixOff_table(o);
			var todayArr = select_date.split("-");
			
			$(".fix_off_selectBox_wrap > select[name='year'] > option[value='"+todayArr[0]+"']").prop("selected", true);
			$(".fix_off_selectBox_wrap > select[name='month'] > option[value='"+todayArr[1]+"']").prop("selected", true);
			break;
		case 11:
			$(".week_select_box_wrap").css("display","none");
			$(".time_table_wrap").html("");
			
			break;
		default:
			console.log(idx);
	}
	
	if($("#reservation_view_btn").css("display") == "inline-block"){
		$(".reservation_register_btn").css("display","block");
	}
}

//예약
function get_reservationList_byDate(date){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListGetByDate/"+date,
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

function get_reservationList_byDate_byEmployee(type, eno, week){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListByDateEno/"+type+"/"+eno+"/"+week,
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

function get_fixReservationList_byDate_byEmployee(type, eno, week){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/fixReservationListByDateEno/"+type+"/"+eno+"/"+week,
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

//대기예약날짜별 list Get
function get_waitingReservationList_byDate(date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/waitingReservationListGetByDate/"+date,
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
	
	var waitingRes = get_waitingReservationList_byDate(date);
	$(waitingRes).each(function(){
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.rtime);
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
		if(this.rtype == 'nc'){
			target_tag = ".doctor_"+this.eno+"_"+hour;
		}else{
			target_tag = ".therapist_"+this.eno+"_"+hour;
		}
		
		txt = "<p class='patient_waitingRes_tag' style='background: #8e08f6; color:#fff;'>"+minute+"~"+end_time+" "+this.pname;
		txt += "<img class='checkImg' src='${pageContext.request.contextPath}/resources/images/icon_check_white.png'>";
		txt += "<input type='hidden' name='no' value='"+this.no+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
		
		$(target_tag).append(txt);
	});
	
	//일반진료
	$(json.ncReservationList).each(function(){
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.rtime);
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
		
		if(this.result == "예약취소"){
			target_tag = ".doctor_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
				+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='nc'></p>";
			
			$(target_tag).append(txt);
		}else{
			target_tag = ".doctor_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:"+clinic.color+";'>"+minute+"~"+end_time+" "+this.pname;
			if(this.desk_state == "접수완료"){
				txt += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
			}
			txt += "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='nc'></p>";
			
			$(target_tag).append(txt);
			
			if(overMinute > 0){
				target_tag = ".doctor_"+this.eno+"_"+(hour+1);
				txt = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
				$(target_tag).append(txt);
			}
		}
		
		
	});
	
	//일반치료
	$(json.ntReservationList).each(function(){
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.rtime);
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
		
		if(this.result == "예약취소"){
			target_tag = ".therapist_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
				+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='nt'></p>";
			
			$(target_tag).append(txt);
		}else{
			target_tag = ".therapist_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:"+clinic.color+";'>"+minute+"~"+end_time+" "+this.pname;
			if(this.desk_state == "접수완료"){
				txt += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
			}
			if(this.result == "치료완료"){
				txt += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
			}
			txt	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='nt'></p>";
			$(target_tag).append(txt);
			
			if(overMinute > 0){
				target_tag = ".therapist_"+this.eno+"_"+(hour+1);
				txt = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
				$(target_tag).append(txt);
			}
		}
		
	});
	
	//고정진료
	$(json.fcReservationList).each(function(){
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.rtime);
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
		
		if(this.result == "예약취소"){
			target_tag = ".doctor_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
				+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='fc'></p>";
			
			$(target_tag).append(txt);
		}else{
			target_tag = ".doctor_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+this.pname;
			if(this.desk_state == "접수완료"){
				txt += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
			}
			txt	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='fc'></p>";
			$(target_tag).append(txt);
			
			if(overMinute > 0){
				target_tag = ".doctor_"+this.eno+"_"+(hour+1);
				txt = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
				$(target_tag).append(txt);
			}
		}
		
		
	});
	
	//고정치료
	$(json.ftReservationList).each(function(){
		clinic = get_clinic_by_cno(this.clinic);
		clinic_time = Number(clinic.time);
		time = Number(this.rtime);
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
		
		if(this.result == "예약취소"){
			target_tag = ".therapist_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
				+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='ft'></p>";
			
			$(target_tag).append(txt);
		}else{
			target_tag = ".therapist_"+this.eno+"_"+hour;
			txt = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+this.pname;
			if(this.desk_state == "접수완료"){
				txt += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
			}
			if(this.result == "치료완료"){
				txt += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
			}
			txt	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='ft'></p>";
			$(target_tag).append(txt);
			
			if(overMinute > 0){
				target_tag = ".therapist_"+this.eno+"_"+(hour+1);
				txt = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
				$(target_tag).append(txt);
			}
		}
		
		
	});
}

//대기예약 no별 get
function get_waitingReservation_byNo(no){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/waitingReservationInfoByNo/"+no,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;
}

//일반진료
function get_ncReservation_byRno(rno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/ncReservationInfoByRno/"+rno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;
}
//일반치료
function get_ntReservation_byRno(rno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/ntReservationInfoByRno/"+rno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;
}

//고정진료
function get_fcReservation_byRno(rno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/fcReservationInfoByRno/"+rno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;
}

//고정치료
function get_ftReservation_byRno(rno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/ftReservationInfoByRno/"+rno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;
}

function get_clinic_by_type(type){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/clinicGetByType/"+type,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;
}


//진료, 치료 테이블에서 예약된환자 이름에 마우스 올리면 좌측하단에 예약정보 나타내는 함수
function draw_simple_reservation_view(type, rno){
	var json;
	var res_record;
	if(type=="nc"){
		json = get_ncReservation_byRno(rno);
	}else if(type == "nt"){
		json = get_ntReservation_byRno(rno);
	}else if(type == "fc"){
		json = get_fcReservation_byRno(rno);
	}else{
		json = get_ftReservation_byRno(rno);
	}
	res_record = get_reservation_record_complete_byPno(json.pno);
	
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
	var rtype;
	if(json.rtype=="nc"){
		rtype = "일반진료";
	}else if(json.rtype == "nt"){
		rtype="일반치료"
	}else if(json.rtype == "fc"){
		rtype="고정진료"
	}else if(json.rtype == "ft"){
		rtype="고정치료"
	}
	var str="";
	str = "<p class='al_tbl_wrap2_title'>"+rtype+"예약 &nbsp;&nbsp;<span>X</span></p><div class='simple_tbl_wrap'><table id='tbl_simple_reservation'>"
		+ "<tr><td class='tbl_content_pName'>"+json.pname+"("+json.chart_no+")님 ▶"+ employee.name+"</td></tr>"
		+"<tr><th class='tbl_content_title'>- 예약일시</th></tr>";
		
	if(json.rtype == 'nc' || json.rtype == 'nt'){
		rtime = Number(json.rtime);
		hour = parseInt(rtime/60);
		minute = rtime%60;
		overMinute = (minute+clinic_time)-60;
		
		if(overMinute >= 0){
			if(overMinute < 10){
				overMinute = "0"+overMinute;
			}
			end_time = (hour+1)+":"+overMinute;
		}else{
			end_time = hour+":"+(minute+clinic_time);
		}
		
		if(minute == 0){
			minute = "0"+minute;
		}
		start_time = hour+":"+minute;
		
		str += "<tr><td class='tbl_content'>"+json.rdate+" "+start_time+"~"+end_time+"</td></tr>"
			+"<tr><th class='tbl_content_title'>- 진료종류</th></tr>";
	}else if(json.rtype == 'fc' || json.rtype == 'ft'){
		rtime = Number(json.rtime);
		hour = parseInt(rtime/60);
		minute = rtime%60;
		overMinute = (minute+clinic_time)-60;
		if(overMinute >= 0){
			if(overMinute < 10){
				overMinute = "0"+overMinute;
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
	str += "<tr><td class='tbl_content'><span class='simple_code_name' style='background:"+clinic.color+";padding:3px 5px;border-radius:3px;'>"+clinic.code_name+"</span></td></tr>"
		+"<tr><th class='tbl_content_title'>- 등록정보</th></tr>"
		+"<tr><td class='tbl_content'>"+json.regdate+" by "+json.writer+"</td></tr>";
		
	if(json.desk_state == "접수완료"){
		str += "<tr><th class='tbl_content_title'>- 접수정보</th></tr>"
			+"<tr><td class='tbl_content'>"+json.desk_state_regdate+" by "+json.desk_state_writer+"</td></tr>";
	}
	if(json.desk_state == "예약취소"){
		str += "<tr><th class='tbl_content_title'>- 취소정보</th></tr>"
			+"<tr><td class='tbl_content'>"+json.desk_state_regdate+" by "+json.desk_state_writer+"</td></tr>";
		
		str += "<tr><th class='tbl_content_title'>- 취소사유</th></tr>"
			+"<tr><td class='tbl_content'>"+json.result_memo+"</td></tr>";
	}
	if(json.memo != ""){
		str +=  "<tr><th class='tbl_content_title'>- 메모</th></tr>"
			+"<tr><td class='tbl_content'>"+json.memo+"</td></tr>";
	}
	if(res_record.length != 0){
		str += "<tr><th class='tbl_content_title'>- 이력</th></tr><tr><td class='tbl_content'><div class='patient_simple_record'>";
		for(var k=res_record.length-1; k>=0; k--){
			str += "<p><span>"+res_record[k].rdate+"</span>&nbsp;&nbsp;<span>"+res_record[k].cname+"/"+res_record[k].ename+"</span></p>";
		}
		str += "</div></td></tr>";
	}
	
	str+="</table></div>";
		
	$(".al_tbl_wrap2").html(str);
		
	$(".al_tbl_wrap2").css("display","block");
}

//주간 선택하면 select 태그에 값 설정
function draw_week_calendar(date, emp, type, idxx){
	
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
	
	makeWeekSelectOptions(type, idxx);
	
}

function draw_week_timetable(etype, idxx){
	var week_time=get_hospitalInfo_byDay("7");
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
		str += "<tr class='"+employee+"_"+arrDate[i]+"'><td>"+arrDay[i]+"("+arrDate[i].split("-")[2]+"일)<input type='hidden' name='day' value='"+arrDay[i]+"'></td>";
		for(n=week_sTime; n < week_eTime; n++){
			str += "<td class='"+employee+"_"+arrDate[i]+"_"+n+"'><p class='reservation_register_btn'>+</p></td>";
		}
		str += "</tr>";
	}
	str += "</table>";
	
	$(".time_table_wrap").html(str);
	
	draw_week_reservation(arrDate, etype, employee, idxx);
}

function draw_week_reservation(week, etype, eno, idxx){
	var json;
	var str="";
	var target_tag = "";
	var week_sDate = week[1];
	var week_eDate = week[6];
	var date;
	var rtype;
	var clinic;
	var clinic_time;
	var time;
	var hour;
	var minute;
	var overMinute;
	if(idxx == 3 || idxx == 6){//고정 View
		json = get_fixReservationList_byDate_byEmployee(etype, eno, week);
		if(etype == "doctor"){//진료고정 view
			$(json).each(function(){
				$($(this.vo)).each(function(){
					clinic = get_clinic_by_cno(this.clinic);
					clinic_time = Number(clinic.time);
					time = Number(this.rtime);
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
					var cs = $(".time_table_wrap > table tr > td > input[value='"+this.fix_day+"']").parent().parent().prop("class");
					
					if(this.result == "예약취소"){
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#e9e9e9; color:gray;'>"+minute+"~"+end_time+" "+this.pname
							+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
					}else{
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+this.pname;
						if(this.desk_state == "접수완료"){
							str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
						}
						str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
						
						if(overMinute > 0){
							target_tag = "."+cs+"_"+(hour+1);
							str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
							$(target_tag).append(str);
						}
					}
					
					
				})
			});
		}else if(etype == "therapist"){//치료고정 view
			$(json).each(function(){
				$($(this.vo)).each(function(){
					clinic = get_clinic_by_cno(this.clinic);
					clinic_time = Number(clinic.time);
					time = Number(this.rtime);
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
					var cs = $(".time_table_wrap > table tr > td > input[value='"+this.fix_day+"']").parent().parent().prop("class");
					
					if(this.result == "예약취소"){
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#e9e9e9; color:gray;'>"+minute+"~"+end_time+" "+this.pname
							+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
					}else{
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+this.pname;
						if(this.desk_state == "접수완료"){
							str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
						}
						if(this.result == "치료완료"){
							str += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
						}
						str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
						
						if(overMinute > 0){
							target_tag = "."+cs+"_"+(hour+1);
							str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
							$(target_tag).append(str);
						}
					}
					
					
				})
			});
		}
	}else{//주간 view
		json = get_reservationList_byDate_byEmployee(etype, eno, week);
		if(etype == "doctor"){//진료주간 view
			$(json).each(function(){
				$($(this.ncr)).each(function(){
					clinic = get_clinic_by_cno(this.clinic);
					clinic_time = Number(clinic.time);
					time = Number(this.rtime);
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
					
					if(this.result == "예약취소"){
						target_tag = "."+eno+"_"+this.rdate+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
							+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
					}else{
						target_tag = "."+eno+"_"+this.rdate+"_"+hour;
						str = "<p class='patient_p_tag' style='background:"+clinic.color+";'>"+minute+"~"+end_time+" "+this.pname;
						if(this.desk_state == "접수완료"){
							str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
						}
						str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
						
						if(overMinute > 0){
							target_tag = "."+eno+"_"+this.rdate+"_"+(hour+1);
							str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
							$(target_tag).append(str);
						}
					}
					
					
				})
				$($(this.fcr)).each(function(){
					clinic = get_clinic_by_cno(this.clinic);
					clinic_time = Number(clinic.time);
					time = Number(this.rtime);
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
					var cs = $(".time_table_wrap > table tr > td > input[value='"+this.fix_day+"']").parent().parent().prop("class");
					
					if(this.result == "예약취소"){
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
							+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
					}else{
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+this.pname;
						if(this.desk_state == "접수완료"){
							str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
						}
						str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
						
						if(overMinute > 0){
							target_tag = "."+cs+"_"+(hour+1);
							str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
							$(target_tag).append(str);
						}
					}

				})
			});
		}else if(etype == "therapist"){//치료주간 view
			$(json).each(function(){
				$($(this.ntr)).each(function(){
					clinic = get_clinic_by_cno(this.clinic);
					clinic_time = Number(clinic.time);
					time = Number(this.rtime);
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
					
					if(this.result == "예약취소"){
						target_tag = "."+eno+"_"+this.rdate+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+this.pname
							+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
					}else{
						target_tag = "."+eno+"_"+this.rdate+"_"+hour;
						str = "<p class='patient_p_tag' style='background:"+clinic.color+";'>"+minute+"~"+end_time+" "+this.pname;
						if(this.desk_state == "접수완료"){
							str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
						}
						if(this.result == "치료완료"){
							str += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
						}
						str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
						
						if(overMinute > 0){
							target_tag = "."+eno+"_"+this.rdate+"_"+(hour+1);
							str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
							$(target_tag).append(str);
						}
					}
				})
				$($(this.ftr)).each(function(){
					clinic = get_clinic_by_cno(this.clinic);
					clinic_time = Number(clinic.time);
					time = Number(this.rtime);
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
					var cs = $(".time_table_wrap > table tr > td > input[value='"+this.fix_day+"']").parent().parent().prop("class");
					
					if(this.result == "예약취소"){
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#e9e9e9; color:gray;'>"+minute+"~"+end_time+" "+this.pname
							+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
					}else{
						target_tag = "."+cs+"_"+hour;
						str = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+this.pname;
						if(this.desk_state == "접수완료"){
							str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
						}
						if(this.result == "치료완료"){
							str += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
						}
						str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
						$(target_tag).append(str);
						
						if(overMinute > 0){
							target_tag = "."+cs+"_"+(hour+1);
							str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
							$(target_tag).append(str);
						}
					}
				})
			});
		}
	}

	
}

//시작날짜 종료날짜 사이 매주 요일의 날짜 반환
function get_between_date(date1, date2){
	var arrDate = [];
	var sDate = new Date(date1).getTime();
	var eDate = new Date(date2).getTime();
	var today = new Date(date1).getTime();
	var nextWeekDate = sDate;
	
	var year;
	var month;
	var day;
	var result_date;
	
	while(nextWeekDate <= eDate){
		arrDate.push(nextWeekDate);
		nextWeekDate = nextWeekDate+(1000*60*60*24*7);
	}
	
	for(var i=0; i<arrDate.length; i++){
		year=new Date(arrDate[i]).getFullYear();
		month=new Date(arrDate[i]).getMonth()+1;
		month = month >= 10 ? month : '0' + month;
		day=new Date(arrDate[i]).getDate();
		day = day >= 10 ? day : '0' + day;
		
		arrDate[i]= year+"-"+month+"-"+day;
	}
	return arrDate;
}

function get_reservationList_byPnoDate(pno, date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListGetByDatePno/"+date+"/"+pno,
		type: "get",
		dataType:"json", 
		async: false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return dt;	
}

function open_reservation_info_view(type, rno){
	var rData;
	var pData;
	var eData;
	var cData;
	var time;
	var rtype;
	if(type == "nc"){
		rData = get_ncReservation_byRno(rno);
		rtype="일반진료예약";
	}else if(type == "nt"){
		rData = get_ntReservation_byRno(rno);
		rtype="일반치료예약";
	}else if(type == "fc"){
		rData = get_fcReservation_byRno(rno);
		rtype="고정진료예약";
	}else if(type == "ft"){
		rData = get_ftReservation_byRno(rno);
		rtype="고정치료예약";
	}
	
	$(".popup_reservation_info_btn_wrap > p").css({"background":"#353c46", "color":"#fff"});
	if($("#session_eno").val() == rData.eno && rData.result == "접수완료"){
		$('.complete_therapy_btn').css("display","inline-block");
	}else{
		$('.complete_therapy_btn').css("display","none");
	}
	
	pData = get_patient_by_pno(rData.pno);
	eData = get_employee_byEno(rData.eno);
	cData = get_clinic_by_cno(rData.clinic);
	var hour = parseInt(Number(rData.rtime)/60);
	var minute = Number(rData.rtime)%60;
	minute = (minute>9?'':'0')+minute;
	
	var str = rtype+"<span> "+pData.name+"("+pData.cno+")님</span><input type='hidden' name='rtype' value='"+rData.rtype+"'>"
			+"<input type='hidden' name='rno' value='"+rData.rno+"'>";
	$(".popup_reservation_info_view > h2").html(str);
	$(".popup_reservation_info_view > table tr:first-child > td > span").html(pData.phone);
	$(".popup_reservation_info_view > table tr:nth-child(2) > td > span").html(rData.rdate+" "+hour+":"+minute);
	$(".popup_reservation_info_view > table tr:nth-child(3) > td > span").html(cData.code_name+" / "+eData.name);
	$(".popup_reservation_info_view > table tr:nth-child(3) > td > span").css({"background":cData.color, "padding":"2px 4px", "color":"#fefefe"});
	$(".popup_reservation_info_view > table tr:nth-child(4) > td > span").html(rData.memo);
	
	var other_res = get_reservationList_byPnoDate(rData.pno, rData.rdate);
	str = "";
	var resArr = [];
	
	$(other_res.ncrList).each(function(){
		if(this.result != "예약취소"){
			resArr.push(this);
		}
	});
	$(other_res.fcrList).each(function(){
		if(this.result != "예약취소"){
			resArr.push(this);
		}
	});
	$(other_res.ntrList).each(function(){
		if(this.result != "예약취소"){
			resArr.push(this);
		}
	});
	$(other_res.ftrList).each(function(){
		if(this.result != "예약취소"){
			resArr.push(this);
		}
	});
	
	//예약 시간순서 정렬
	resArr.sort(function(a,b){
		return a.rtime < b.rtime ? -1: a.rtime>b.rtime?1:0;
	});
	
	$(resArr).each(function(){
		cData = get_clinic_by_cno(this.clinic);
		hour = parseInt(Number(this.rtime)/60);
		minute = (Number(this.rtime)%60 >9?'':'0')+Number(this.rtime)%60;
		eData = get_employee_byEno(this.eno);
		if(this.rtype == "fc" || this.rtype == "ft"){
			str += "<p class='res_info_view_today_list' style='background:#ffaf7a;padding:3px 4px; color:#fefefe;'>"+this.rdate+" "+hour+":"+minute+" "
				+this.clinic_name+"/"+eData.name+"<input type='hidden' name='rtype' value='"+this.rtype+"'><input type='hidden' name='rno' value='"+this.rno+"'></p>";
		}else{
			str += "<p class='res_info_view_today_list' style='background:"+cData.color+"; color:#fefefe;padding:3px 4px;'>"+this.rdate+" "+hour+":"+minute+" "
				+this.clinic_name+"/"+eData.name+"<input type='hidden' name='rtype' value='"+this.rtype+"'><input type='hidden' name='rno' value='"+this.rno+"'></p>";
		}
		
	});
	
	$(".popup_reservation_info_view > table tr:nth-child(5) > td").html(str);
	
	$(".popup_reservation_info_view").css("display", "block");
	$(".popup_wrap").css("display", "block");
}


function update_reservation_therapistState(rtype, rno, state, writer, regdate, stbn){
	var reason = $(".cancel_reason > td > textarea[name='cancel_reason']").val();
	
	var info = {rtype:rtype, rno:rno, state:state, writer:writer, regdate:regdate};
	$.ajax({
		url:"${pageContext.request.contextPath}/updateReservationTherapistState",
		type:"post",
		data:JSON.stringify(info),
		dataType:"text",
		contentType : "application/json; charset=UTF-8",
		async:false,
		success:function(json){
			if(json == "ok"){	
				$(".popup_reservation_info_view").css("display", "none");
				$(".popup_wrap").css("display","none");
				
				draw_time_table_by_case(stbn);
			}else{
				alert("예약등록이 정상적으로 등록되지 않았습니다. 다시 한번 등록하세요.");
			}
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function update_reservation_state(idxx, rtype, rno, state, writer, regdate, stbn){
	update_reservation_therapistState(rtype, rno, state, writer, regdate, stbn);
	
}

function get_reservation_record_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationRecordGetAll",
		type:"post",
		data:JSON.stringify(info),
		contentType : "application/json; charset=UTF-8",
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

function get_reservation_record_complete_byPno(pno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationRecordGetCompleteByPno/"+pno,
		type:"get",
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

//변경이력 Get All
function get_reservation_update_record_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationUpdateRecordGetAll",
		type:"post",
		data:JSON.stringify(info),
		contentType : "application/json; charset=UTF-8",
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


function get_normalOff_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/normalOffGetAll",
		type:"post",
		data:JSON.stringify(info),
		contentType : "application/json; charset=UTF-8",
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

function get_normalOff_byNo(no){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/normalOffGetByNo/"+no,
		type:"get",
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
function get_normalOff_byDate(date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/selectNormalOffByDate/"+date,
		type:"get",
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

//주간, 고정 휴무GET
function get_normalOff_byWeek(week, eno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/selectNormalOffByWeek/"+week+"/"+eno,
		type:"get",
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

//일반휴무 선택날짜별 그리기(진료&치료종합, 진료종합, 치료종합)
function draw_normalOff_in_timetable(date){
	var offData = get_normalOff_byDate(date);
	var timeTableClass = "";
	var sTime;
	var eTime;
	
	$(offData).each(function(){
		sTime = Number(this.starttime)/60;
		eTime = Number(this.endtime)/60;
		
		if(this.startdate == date && this.enddate == date){
			for(var i=sTime; i<eTime; i++){
				timeTableClass = "."+this.etype+"_"+this.eno+"_"+i;
				$(timeTableClass).html("");
				$(timeTableClass).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
			}
		}else{
			if(this.startdate == date){
				for(var i=sTime; i<23; i++){
					timeTableClass = "."+this.etype+"_"+this.eno+"_"+i;
					$(timeTableClass).html("");
					$(timeTableClass).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
				}
			}else if(this.enddate == date){
				for(var i=7; i<eTime; i++){
					timeTableClass = "."+this.etype+"_"+this.eno+"_"+i;
					$(timeTableClass).html("");
					$(timeTableClass).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
				}
			}else{
				for(var i=7; i<23; i++){
					timeTableClass = "."+this.etype+"_"+this.eno+"_"+i;
					$(timeTableClass).html("");
					$(timeTableClass).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
				}
			}
		}
	});
}



function draw_normalOff_in_weektable(){
	var select_week = $("#sh_week").val();
	var eno = $(".week_select_box_wrap > select[name='employee']").val();
	var sWeek =select_week.split("|")[0];
	var arrWeek=[];
	var strDate;
	arrWeek.push(sWeek);
	var date = new Date(sWeek);
	for(var i=1; i<7; i++){
		date.setDate(date.getDate()+1);
		strDate = date.getFullYear()+"-"+(((date.getMonth()+1)>9?'':'0')+(date.getMonth()+1))+"-"+((date.getDate()>9?'':'0')+date.getDate());
		arrWeek.push(strDate);
	}
	
	var offData = get_normalOff_byWeek(arrWeek, eno);

	var target_class;
	var sTime;
	var eTime;
	
	for(var i=1; i<arrWeek.length; i++){
		$(offData[arrWeek[i]]).each(function(){
			sTime = Number(this.starttime)/60;
			eTime = Number(this.endtime)/60;
			/* for(var n = sTime; n < eTime; n++){
				target_class = "."+this.eno+"_"+arrWeek[i]+"_"+n;
				$(target_class).html("");
				$(target_class).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
			} */
			
			if(this.startdate == arrWeek[i] && this.enddate == arrWeek[i]){
				for(var n=sTime; n<eTime; n++){
					target_class = "."+this.eno+"_"+arrWeek[i]+"_"+n;
					$(target_class).html("");
					$(target_class).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
				}
			}else{
				if(this.startdate == arrWeek[i]){
					for(var n=sTime; n<23; n++){
						target_class = "."+this.eno+"_"+arrWeek[i]+"_"+n;
						$(target_class).html("");
						$(target_class).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
					}
				}else if(this.enddate == arrWeek[i]){
					for(var n=7; n<eTime; n++){
						target_class = "."+this.eno+"_"+arrWeek[i]+"_"+n;
						$(target_class).html("");
						$(target_class).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
					}
				}else{
					for(var n=7; n<23; n++){
						target_class = "."+this.eno+"_"+arrWeek[i]+"_"+n;
						$(target_class).html("");
						$(target_class).append("<p class='normal_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
					}
				}
			}
		});
	}
}


function get_fixOff_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/fixOffGetAll",
		type:"post",
		data:JSON.stringify(info),
		contentType : "application/json; charset=UTF-8",
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

function get_fixOff_byNo(no){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/fixOffGetByNo/"+no,
		type:"get",
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

function get_fixOff_byDate(date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/selectFixOffByDate/"+date,
		type:"get",
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

function get_fixOff_byWeek(week, eno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/selectFixOffByWeek/"+week+"/"+eno,
		type:"get",
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

function draw_fixOff_in_timetable(date){
	var offData = get_fixOff_byDate(date);
	var timeTableClass = "";
	var sTime;
	var eTime;
	$(offData).each(function(){
		sTime = Number(this.starttime)/60;
		eTime = Number(this.endtime)/60;
		for(var i= sTime; i<eTime ; i++){
			timeTableClass = "."+this.etype+"_"+this.eno+"_"+i;
			//$(timeTableClass).html("");
			$(timeTableClass).prepend("<p class='fix_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>")
		}
	});
}



function draw_fixOff_in_weektable(){
	var select_week = $("#sh_week").val();
	var eno = $(".week_select_box_wrap > select[name='employee']").val();
	var sWeek =select_week.split("|")[0];
	var arrWeek=[];
	var strDate;
	arrWeek.push(sWeek);
	var date = new Date(sWeek);
	for(var i=1; i<7; i++){
		date.setDate(date.getDate()+1);
		strDate = date.getFullYear()+"-"+(((date.getMonth()+1)>9?'':'0')+(date.getMonth()+1))+"-"+((date.getDate()>9?'':'0')+date.getDate());
		arrWeek.push(strDate);
	}
	
	var offData = get_fixOff_byWeek(arrWeek, eno);

	var target_class;
	var sTime;
	var eTime;
	for(var i=1; i<arrWeek.length; i++){
		$(offData[arrWeek[i]]).each(function(){
			sTime = Number(this.starttime)/60;
			eTime = Number(this.endtime)/60;
			for(var n=sTime; n<eTime; n++){
				target_class = "."+this.eno+"_"+arrWeek[i]+"_"+n;
				//$(target_class).html("");
				$(target_class).prepend("<p class='fix_off' style='background:#e8f5e9; color:#acb1b4;'>"+this.offtype+"</p>");
			}
		});
	}
}


function draw_patient_week_calendar(type, idxx){
	
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
	$("#pwt_year").html(str);
	str = "";
	$("#pwt_month > option[value='"+month+"']").prop("selected","selected");
	
	$(".patient_week_tbl_selectBox_wrap").css("display","block");
	$(".timetable_btn_wrap2").css("display","block");
	makePatientWeekSelectOptions(type, idxx);
	
}

function draw_patient_week_timetable(type, idxx){
	
	var week_time=get_hospitalInfo_byDay("7");
	var week_sTime=Number(week_time.start_time)/60;
	var week_eTime=Number(week_time.end_time)/60;
	var select_week = $("#pwt_week").val();
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
		str += "<tr class='"+arrDate[i]+"'><td>"+arrDay[i]+"("+arrDate[i].split("-")[2]+"일)<input type='hidden' name='day' value='"+arrDay[i]+"'></td>";
		for(n=week_sTime; n < week_eTime; n++){
			str += "<td class='"+arrDate[i]+"_"+n+"'></td>";
		}
		str += "</tr>";
	}
	str += "</table>";
	
	$(".patient_time_table_wrap").html(str); 
	
	var pno = $("#reservation_view_btn").find("input[name='pno']").val();

	draw_patient_week_reservation(pno, arrDate, type);
}

function get_reservationList_byWeekPno(pno, week, rtype){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListByPno/"+pno+"/"+week+"/"+rtype,
		type:"get",
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

function draw_patient_week_reservation(pno, week, rtype){
	var json = get_reservationList_byWeekPno(pno, week, rtype)
	var target_tag;
	var str;
	var empvo;
	
	//일반 진료, 치료
	$(json.nr).each(function(){
		empvo = get_employee_byEno(this.eno);
		var clinic = get_clinic_by_cno(this.clinic);
		var clinic_time = Number(clinic.time);
		var time = Number(this.rtime);
		var hour = parseInt(time/60);
		var minute = time%60;
		var overMinute = (minute+clinic_time)-60;
		var end_time;
		
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
	
		target_tag = "."+this.rdate+"_"+parseInt(Number(this.rtime)/60);
		if(this.result == "예약취소"){
			str = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+empvo.name
				+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
			$(target_tag).append(str);
		}else{
			str = "<p class='patient_p_tag' style='background:"+clinic.color+";'>"+minute+"~"+end_time+" "+empvo.name;
			if(this.desk_state == "접수완료"){
				str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
			}
			if(this.result == "치료완료"){
				str += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
			}
			str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
			$(target_tag).append(str);
			
			if(overMinute > 0){
				target_tag = "."+this.rdate+"_"+(hour+1);
				str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
				$(target_tag).append(str);
			}
		}
	});
	//고정 진료/치료
	$(json.fr).each(function(){
		empvo = get_employee_byEno(this.eno);
		var clinic = get_clinic_by_cno(this.clinic);
		var clinic_time = Number(clinic.time);
		var time = Number(this.rtime);
		var hour = parseInt(time/60);
		var minute = time%60;
		var overMinute = (minute+clinic_time)-60;
		var end_time;
		
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
	
		target_tag = "."+this.rdate+"_"+parseInt(Number(this.rtime)/60);
		if(this.result == "예약취소"){
			str = "<p class='patient_p_tag' style='background:#e9e9e9;color:gray;'>"+minute+"~"+end_time+" "+empvo.name
				+ "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
			$(target_tag).append(str);
		}else{
			str = "<p class='patient_p_tag' style='background:#ffaf7a;'>"+minute+"~"+end_time+" "+empvo.name;
			if(this.desk_state == "접수완료"){
				str += "<img class='footImg' src='${pageContext.request.contextPath}/resources/images/foot.png'>";
			}
			if(this.result == "치료완료"){
				str += "<img class='handImg' src='${pageContext.request.contextPath}/resources/images/hand.png'>";
			}
			str	+= "<input type='hidden' name='rno' value='"+this.rno+"'><input type='hidden' name='type' value='"+this.rtype+"'></p>";
			$(target_tag).append(str);
			
			if(overMinute > 0){
				target_tag = "."+this.rdate+"_"+(hour+1);
				str = "<p class='res_no' style='background:black;color:#fff;'>~"+end_time+"예약불가</p>";
				$(target_tag).append(str);
			}
		}
	});
}

function get_reservation_record_byPno(pno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationRecordByPno/"+pno,
		type:"get",
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

function draw_patient_reservation_record(){
	var pno = $("#reservation_view_btn").find("input[name='pno']").val();
	json = get_reservation_record_byPno(pno);
	var str="";
	var str = "";
	var time;
	var hour;
	var minute;
	var overMinute;
	
	str = "<div class='patient_res_record_wrap'><table class='tbl_patient_reservation_record'><tr><th>환자명</th><th>담당자</th><th>분류</th><th>종류</th><th>예정일시</th><th>최초등록일시</th><th>접수일시</th><th>치료완료일시</th><th>예약메모</th><th>취소사유</th></tr>";
	if(json.length == 0){
		str += "<tr><td colspan='9'>등록된 정보가 없습니다.</td></tr>";
	}else{
		$(json).each(function(){
			time = Number(this.rtime);
			hour = parseInt(time/60);
			minute = time%60;

			if(minute < 10){
				minute = "0"+minute;
			}
			if(hour < 10){
				hour = "0"+hour;
			}
			
			str += "<tr><td>"+this.pname+"</td><td>"+this.ename+"</td>";
			if(this.rtype == "nc"){
				str += "<td>일반진료</td>";
			}else if(this.rtype == "fc"){
				str += "<td>고정진료</td>";
			}else if(this.rtype == "nt"){
				str += "<td>일반치료</td>";
			}else if(this.rtype == "ft"){
				str += "<td>고정진료</td>";
			}
			str += "<td>"+this.cname+"</td><td>"+this.rdate+" "+hour+":"+minute+"</td><td>"+this.register_info+"</td><td>"+this.reception_info+"</td><td>"+this.therapy_info+"</td><td>"+this.reception_memo+"</td><td>"+this.result_memo+"</td></tr>";
		});
		str += "</table></div>";
		
	}
	$(".patient_time_table_wrap").html(str);
	
}

function get_reservation_update_record_byPno(pno){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationUpdateRecordByPno/"+pno,
		type:"get",
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

function draw_patient_reservation_update_record(){
	var pno = $("#reservation_view_btn").find("input[name='pno']").val();
	var json = get_reservation_update_record_byPno(pno);
	var str = "";
	var time;
	var hour;
	var minute;
	var overMinute;
	
	str = "<div class='patient_res_record_wrap'><table class='tbl_patient_reservation_update_record'><tr><th>환자명</th><th>예정시간</th><th>변경종류</th><th>변경내용</th><th>변경등록일시</th><th>변경메모</th></tr>";
	if(json.length == 0){
		str += "<tr><td colspan='6'>등록된 정보가 없습니다.</td></tr>";
	}else{
		$(json).each(function(){
			time = Number(this.rtime);
			hour = parseInt(time/60);
			minute = time%60;

			if(minute < 10){
				minute = "0"+minute;
			}
			if(hour < 10){
				hour = "0"+hour;
			}
			
			str += "<tr><td>"+this.pname+"</td><td>"+this.before_info+"</td>";
			if(this.rtype == "nc"){
				str += "<td>일반진료 일정변경</td>";
			}else if(this.rtype == "fc"){
				str += "<td>고정진료 일정변경</td>";
			}else if(this.rtype == "nt"){
				str += "<td>일반치료 일정변경</td>";
			}else if(this.rtype == "ft"){
				str += "<td>고정치료 일정변경</td>";
			}
			str += "<td>"+this.after_info+"</td><td>"+this.update_info+"</td><td>"+this.update_memo+"</td></tr>";
		});
		str += "</table></div>";
		
	}
	$(".patient_time_table_wrap").html(str);
}

function draw_patient_reservation_byCase(idx){ 
	switch(idx){
	case 0:
		draw_patient_week_calendar("clinic", idx);
		break;
	case 1:
		
		draw_patient_week_calendar("therapy", idx);
		break;
	case 2:
		$(".patient_time_table_wrap").html("");
		$(".patient_week_tbl_selectBox_wrap").css("display","none");
		draw_patient_reservation_record();
		break;
	case 3:
		$(".patient_time_table_wrap").html("");
		$(".patient_week_tbl_selectBox_wrap").css("display","none");
		draw_patient_reservation_update_record();
		break;
	default:
		break;
	}
}
$(function(){
	//진료view에서 무슨 탭 눌러졌는지 기억하기 위한 변수
	var storage_timetable_btn_num = 0;
	var storage_timetable2_btn_num = 0;
	
	
	//달력 생성
	var nDate = new Date();

	if(nDate.getDay() == 0){
		nDate.setDate(nDate.getDate()+1);
		buildCalendar(nDate);
		$(".calendar_select_date").val(nDate.getFullYear()+"-"+(((nDate.getMonth()+1)>9?'':'0')+(nDate.getMonth()+1))+"-"+((nDate.getDate()>9?'':'0')+nDate.getDate()));
	}else{
		buildCalendar(new Date());
		$(".calendar_select_date").val(get_today());
	}
	
	//날짜마다 요일 표시
	write_yoil();
	
	//TODAY 클릭
	$(".today_btn").click(function(){
		var today = new Date();
		if(today.getDay() == 0){
			today.setDate(today.getDate()+1);
			buildCalendar(today);
			$(".calendar_select_date").val(today.getFullYear()+"-"+(((today.getMonth()+1)>9?'':'0')+(today.getMonth()+1))+"-"+((today.getDate()>9?'':'0')+today.getDate()));
			draw_time_table_by_case(storage_timetable_btn_num);
		}else{
			buildCalendar(new Date());
			$(".calendar_select_date").val(get_today());
			draw_time_table_by_case(storage_timetable_btn_num);
		}
		/* buildCalendar(today);
		$(".calendar_select_date").val(get_today());
		draw_time_table_by_case(storage_timetable_btn_num); */
	});
	
	//이전달 클릭
	$("#prevCalendar").click(function(){
		var today = new Date($("#select_year_month").val());
		prevCalendar(today);
	});
	
	//다음달 클릭
	$("#nextCalendar").click(function(){
		var today = new Date($("#select_year_month").val());
		nextCalendar(today);
	});
	
	//환자table 생성
	var o={};
	draw_patient_table(o);
	
	draw_time_table_by_case(0); 
	
	$(".topView_btn > #patient_view_btn").click(function(){
		if($(this).css("color") == "rgb(255, 255, 255)"){
			$(this).css({"background":"#fff", "color":"#105340", "border":"1px solid lightgray"});
			$(this).find("img").prop("src","${pageContext.request.contextPath}/resources/images/icon_person.png");
			$(".ar_tbl_wrap_1").css("display","none");
		}else{
			$(this).css({"background":"#3294c6", "color":"#fff"});
			$(this).find("img").prop("src","${pageContext.request.contextPath}/resources/images/icon_person_white.png");
			$(".ar_tbl_wrap_1").css("display","block");
		}
	});
	
	$(".topView_btn > #reservation1_view_btn").click(function(){
		if($(this).css("color") == "rgb(255, 255, 255)"){
			$(this).css({"background":"#fff", "color":"#105340", "border":"1px solid lightgray"});
			$(this).find("img").prop("src","${pageContext.request.contextPath}/resources/images/icon_clock.png");
			$(".ar_tbl_wrap_2").css("display","none");
		}else{
			$(this).css({"background":"#3294c6", "color":"#fff"});
			$(this).find("img").prop("src","${pageContext.request.contextPath}/resources/images/icon_clock_white.png");
			$(".ar_tbl_wrap_2").css("display","block");
		}
	});
	
	//달력 날짜 클릭 시 해당 정보GET
	$(document).on("click", "#calendar td:not(.tr_not > td)", function(){
		//날짜마다 요일 표시
		write_yoil();
		
		//클릭한 td 붉은색 네모
		$("#calendar td").css("border","0");
		$(this).not(".tr_not > td").css({"border":"1px solid #8f8f8f"});
		
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
		$(".time_table_wrap").html("");
		
		draw_time_table_by_case(storage_timetable_btn_num);
	 });
	
	//환자table에서 페이지 클릭
	$(document).on("click", ".page > ul > li > a", function(e){
		e.preventDefault();
		var page="";
		var perPageNum="";
		var searchType="";
		var keyword="";
		
		var href_txt = $(this).attr("href");
		var splitList = href_txt.split("&");
		
		for(var i=0; i<splitList.length; i++){
			console.log(splitList[i].split("=")[1]);
			if(i==0){
				page=splitList[i].split("=")[1];
			}else if(i==1){
				perPageNum=splitList[i].split("=")[1];
			}else if(i==2){
				searchType = splitList[i].split("=")[1];
			}else if(i==3){
				keyword = splitList[i].split("=")[1];
			}
		}
		
		var info = {page:page, perPageNum:perPageNum, searchType:searchType, keyword:keyword};
		
		draw_patient_table(info);
	});
	
	$(document).on("click", ".reservation_record_page > ul > li > a", function(e){
		e.preventDefault();

		var page="";
		var perPageNum="";
		var searchType="";
		var keyword1="";
		var keyword2="";
		var keyword3="";
		var keyword4="";
		
		var href_txt = $(this).attr("href");
		var splitList = href_txt.split("&");
		
		for(var i=0; i<splitList.length; i++){
			console.log(splitList[i].split("=")[1]);
			if(i==0){
				page=splitList[i].split("=")[1];
			}else if(i==1){
				perPageNum=splitList[i].split("=")[1];
			}else if(i==2){
				keyword1 = splitList[i].split("=")[1];
			}else if(i==3){
				keyword2 = splitList[i].split("=")[1];
			}else if(i==4){
				keyword3 = splitList[i].split("=")[1];
			}else if(i==5){
				keyword4 = splitList[i].split("=")[1];
			}
		}
		
		var info = {page:page, perPageNum:perPageNum, keyword1:keyword1, keyword2:keyword2, keyword3:keyword3, keyword4:keyword4};
		draw_reservation_record_table(info);
	});
	
	//환자table 환자 검색
	$("#searchBtn").click(function(){
		var s=$("select[name='searchType']").val();
		var k=$("input[name='keyword']").val();
		
		var page=1;
		var perPageNum=5;
		var searchType=s;
		var keyword=k;
		
		var info = {page:page, perPageNum:perPageNum, searchType:searchType, keyword:keyword};
		draw_patient_table(info);
	});
	
	//환자검색에서 엔터키 눌렀을 때
	$("#keywordInput").keyup(function(e){
		if(e.keyCode == 13){
			var s=$(".ar_tbl_wrap_1 > .search_wrap > select[name='searchType']").val();
			var k=$(".ar_tbl_wrap_1 > .search_wrap > input[name='keyword']").val(); 
			
			var page=1;
			var perPageNum=5;
			var searchType=s;
			var keyword=k;
			
			var info = {page:page, perPageNum:perPageNum, searchType:searchType, keyword:keyword};
			draw_patient_table(info);
		}
	});	
	
	//헤더에 있는 환자이름 버튼
	$("#reservation_view_btn").click(function(){
		$(this).css("display", "none");
		$("#reservation_view_btn").html("");
		$(".reservation_register_btn").css("display", "none");
		$(".ar_tbl_wrap_1 > #inner_tbl_wrap > table .patientTblTr").css("background", "#fff"); 
		//ar_tbl_wrap_3 지우기
		$(".patient_week_tbl_selectBox_wrap").css("display","none");
		$(".patient_time_table_wrap").html("");
		$(".timetable_btn_wrap2").css("display","none");
	});

	//진료, 치료 테이블에서 예약에 마우스 올리고 치웠을때
	$(document).on({
		mouseenter:function(){
			var rno = $(this).find("input[name='rno']").val();
			var type = $(this).find("input[name='type']").val();
			draw_simple_reservation_view(type, rno);
			
		},
		mouseleave:function(){}
		}, ".patient_p_tag");
		
	$(document).on("click", ".al_tbl_wrap2 > .al_tbl_wrap2_title", function(){
		$(".al_tbl_wrap2").css("display","none");
		$(".al_tbl_wrap2").html("");
	});
		
	//환자 리스트에서 예약-선택 버튼 클릭
	$(document).on("click", ".reservation_select_btn", function(){
		$(".ar_tbl_wrap_1 > #inner_tbl_wrap > table .patientTblTr").css("background", "#fff"); 
		$(this).parent().parent().css("background", "#a5d1de");
		var reservation_click_pno = $(this).parent().parent().find("input[type='hidden']").val();
		var reservation_click_cno = $(this).parent().parent().find("td").eq(1).html();
		$("#reservation_view_btn").html($(this).parent().parent().find("td").eq(2).html()+"<input type='hidden' name='pno' value='"+reservation_click_pno+"'><input type='hidden' name='cno' value='"+reservation_click_cno+"'>");
		$("#reservation_view_btn").css("display", "inline-block");
		//ar_tbl_wrap_3 그리기
		$(".timetable_btn_wrap2 > ul > li").css({"background":"none", "font-weight":"500"});
		$(".timetable_btn_wrap2 > ul > li:first-child").css({"font-weight":"bold", "background":"#0068b8"});
		draw_patient_reservation_byCase(0);
		
	});
	 
	$(".timetable_btn_wrap2 > ul > li").click(function(){
		var idx = $(this).index();
		storage_timetable2_btn_num = idx;
		$(".timetable_btn_wrap2 > ul > li").css({"background":"none", "font-weight":"500"});
		$(this).css({"font-weight":"bold", "background":"#0068b8"});
		
		draw_patient_reservation_byCase(idx);
	});
	
	$(document).on("change", "#pwt_month, #pwt_year", function(){
		var type;
		if(storage_timetable2_btn_num == 0){
			type = "clinic";
		}else if(storage_timetable2_btn_num == 1){
			type = "therapy";
		}
		makePatientWeekSelectOptions(type, storage_timetable2_btn_num);
	});
	
	$(document).on("change", "#pwt_week", function(){
		var type;
		if(storage_timetable2_btn_num == 0){
			type = "clinic";
		}else if(storage_timetable2_btn_num == 1){
			type = "therapy";
		}
		draw_patient_week_timetable(type, storage_timetable2_btn_num);
	});
	
	
	
	//table 선택 버튼(진료&치료종합, 진료종합, 주간, 고정 등등)
	$(".timetable_btn_wrap > ul > li").click(function(){
		var idx = $(this).index();
		$(".timetable_btn_wrap > ul > li").css({"background":"none", "font-weight":"500"});
		$(this).css({"font-weight":"bold", "background":"#0068b8"});
		
		draw_time_table_by_case(idx);
		storage_timetable_btn_num = idx;
	});
	
	//주간 select에서 주 변경되었을때 timetable 변경해서 삽입
	$("#sh_week").change(function(){
		if(storage_timetable_btn_num == 2 || storage_timetable_btn_num == 3){
			draw_week_timetable("doctor", storage_timetable_btn_num);
			draw_normalOff_in_weektable();
			draw_fixOff_in_weektable();
		}else if(storage_timetable_btn_num == 5 || storage_timetable_btn_num == 6){
			draw_week_timetable("therapist", storage_timetable_btn_num);
			draw_normalOff_in_weektable();
			draw_fixOff_in_weektable();
		}
		
	})
	//주간 select에서 의사 및 치료사 변경되었을때 timetable 변경해서 삽입
	$(document).on("change",".week_select_box_wrap > select[name='employee']",function(){
		if(storage_timetable_btn_num == 2 || storage_timetable_btn_num == 3){
			draw_week_timetable("doctor", storage_timetable_btn_num);
			draw_normalOff_in_weektable();
			draw_fixOff_in_weektable();
		}else if(storage_timetable_btn_num == 5 || storage_timetable_btn_num == 6){
			draw_week_timetable("therapist", storage_timetable_btn_num);
			draw_normalOff_in_weektable();
			draw_fixOff_in_weektable();
		} 
	});
	
	$(document).on("click", ".patient_p_tag", function(){
		var type = $(this).find("input[name='type']").val();
		var rno = $(this).find("input[name='rno']").val();
		open_reservation_info_view(type, rno);
	})	
	
	//시간표에 있는 대기예약 클릭
	$(document).on("click", ".patient_waitingRes_tag", function(){
		var no = $(this).find("input[name='no']").val();
		var wrVO = get_waitingReservation_byNo(no);
		var patientVO =  get_patient_by_pno(wrVO.pno);
		if(wrVO.rtype == 'nc'){
			$(".popup_clinic_reservation_register > h2 > span").html(wrVO.pname+"("+wrVO.chart_no+")님");
			$(".popup_clinic_reservation_register > h2").append("<input type='hidden' name='pno' value='"+wrVO.pno+"'><input type='hidden' name='pname' value='"+wrVO.pname+"'><input type='hidden' name='chart_no' value='"+wrVO.chart_no+"'>");
			$(".popup_clinic_reservation_register > table td > select[name='clinic'] > option[value='"+wrVO.clinic+"']").prop("selected", true);
			$(".popup_clinic_reservation_register > table td > select[name='eno'] > option[value='"+wrVO.eno+"']").prop("selected", true);
			$(".popup_clinic_reservation_register > table td > select[name='rtype'] > option[value='nc']").prop("selected", true);
			$(".popup_clinic_reservation_register > table tr > td > .popup_reservation_register_date").text(wrVO.rdate+" "+parseInt(wrVO.rtime/60));
			$(".popup_clinic_reservation_register > table td > select[name='rtime_minute'] > option[value='"+wrVO.rtime%60+"']").prop("selected", true);
			$(".popup_clinic_reservation_register > table tr > td > input[name='memo']").val(wrVO.memo);
			
			$(".popup_wrap").css("display", "block");
			$(".popup_clinic_reservation_register").css("display", "block");
		}else if(wrVO.rtype == 'nt'){
			$(".popup_therapy_reservation_register > h2 > span").html(wrVO.pname+"("+wrVO.chart_no+")님");
			$(".popup_therapy_reservation_register > h2").append("<input type='hidden' name='pno' value='"+wrVO.pno+"'><input type='hidden' name='pname' value='"+wrVO.pname+"'><input type='hidden' name='chart_no' value='"+wrVO.chart_no+"'>");
			$(".popup_therapy_reservation_register > table td > select[name='clinic'] > option[value='"+wrVO.clinic+"']").prop("selected", true);
			$(".popup_therapy_reservation_register > table td > select[name='eno'] > option[value='"+wrVO.eno+"']").prop("selected", true);
			$(".popup_therapy_reservation_register > table td > select[name='rtype'] > option[value='nt']").prop("selected", true);
			$(".popup_therapy_reservation_register > table tr > td > .popup_reservation_register_date").text(wrVO.rdate+" "+parseInt(wrVO.rtime/60));
			$(".popup_therapy_reservation_register > table td > select[name='rtime_minute'] > option[value='"+wrVO.rtime%60+"']").prop("selected", true);
			$(".popup_therapy_reservation_register > table tr > td > input[name='memo']").val(wrVO.memo);
			
			$(".popup_wrap").css("display", "block");
			$(".popup_therapy_reservation_register").css("display", "block");
		}
	});
	
	$(document).on("click", ".popup_content2 .popup_reservation_register_btn_wrap > p", function(){
		$(".popup_clinic_reservation_register").css("display", "none");
		$(".popup_therapy_reservation_register").css("display", "none");
		$(".popup_content").css("display", "none");
		$(".popup_wrap").css("display","none");
	});
	
	//예약완료, 접수완료, 예약취소 눌렀을 때
	$(".popup_reservation_info_btn_wrap > p").click(function(){
		var btn_idx = $(this).index();
		if($(this).text() == '닫기'){
			$(".popup_reservation_info_view").css("display","none");
			$(".popup_wrap").css("display", "none");
			return false;
		}else{
			var rtype = $(".popup_reservation_info_view > h2 > input[name='rtype']").val();
			var rno = $(".popup_reservation_info_view > h2 > input[name='rno']").val();
			var state = $(this).text();
			var writer = $("#session_login_name").val();
			var nowDate = new Date();
			var regdate = nowDate.getFullYear()+"-"+(((nowDate.getMonth()+1)>9?'':'0')+(nowDate.getMonth()+1))+"-"+((nowDate.getDate()>9?'':'0')+nowDate.getDate())
						+" "+nowDate.getHours()+":"+((nowDate.getMinutes()>9?'':'0')+nowDate.getMinutes());
			
			update_reservation_state(btn_idx, rtype, rno, state, writer, regdate, storage_timetable_btn_num);
		}
		
	});	
	
	$(document).on("click", ".popup_reservation_info_view > table tr:nth-child(5) > td > .res_info_view_today_list", function(){
		var rno = $(this).find("input[name='rno']").val();
		var rtype = $(this).find("input[name='rtype']").val();
		
		open_reservation_info_view(rtype, rno);
	});
	
	//모든 페이징에서 선택된 페이지 클릭 막음
	$(document).on("click", ".active2", function(e){
		e.preventDefault(); 
		return false;
	})
});
</script>
</head> 
<body>
	<div class="popup_wrap">
		<jsp:include page="../include/therapistViewPopup.jsp"></jsp:include>
	</div><!-- popup_wrap end -->
	
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside_left">
				<div class="topView_btn">
					<p id="patient_view_btn"><img src="${pageContext.request.contextPath}/resources/images/icon_person_white.png">환자VIEW</p>
					<p id="reservation1_view_btn"><img src="${pageContext.request.contextPath}/resources/images/icon_clock_white.png">예약VIEW</p>
					<p id="reservation_view_btn"><img src="${pageContext.request.contextPath}/resources/images/icon_person_white.png"></p>
				</div>
				<div class="al_tbl_wrap_1">
					<input class='calendar_select_date' type="hidden" value=''>
					<h5 class="today_btn">Today</h5>
					<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
					    <tr class="tr_not"><!-- label은 마우스로 클릭을 편하게 해줌 -->
					        <td><label id="prevCalendar"><</label></td>
					        <td align="center" id="tbCalendarYM" colspan="5"> 
					        yyyy년 m월</td>
					        <td><label id="nextCalendar">></label></td>
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
							<li>예약종합</li>
							<li>진료예약</li>
							<li>진료주간예약</li>
							<li>진료고정예약</li>
							<li>치료예약</li>
							<li>치료주간예약</li>
							<li>치료고정예약</li>
						</ul>
					</div><!-- timetable_btn_wrap -->
					<div class="week_select_box_wrap selectBox_wrap">
						<select name="sh_year" id="sh_year" onchange="makeWeekSelectOptions();">
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
					<div class="reservation_record_selectBox_wrap selectBox_wrap">
						<input name="rdate" type="text" value="" placeholder="ex) 2019-01-01">
						<select name="employee">
							<option value="">직원 전체</option>
							<c:forEach var="list" items="${doctorList}">
								<option value="${list.name}">${list.name}</option>
							</c:forEach>
							<c:forEach var="list" items="${therapistList}">
								<option value="${list.name}">${list.name}</option>
							</c:forEach>
						</select>
						<select name="rtype">
							<option value="">분류전체보기</option>
							<option value="nc">일반진료</option>
							<option value="fc">고정진료</option>
							<option value="nt">일반치료</option>
							<option value="ft">고정치료</option>
						</select>
						<select name="result">
							<option value="">전체보기</option>
							<option value="예약완료">예약완료(미접수)</option>
							<option value="접수완료">접수완료</option>
							<option value="예약취소">예약취소</option>
							<option value="치료완료">치료완료</option>
						</select>
						<button>검색</button>
					</div><!-- reservation_record_selectBox_wrap -->
					<div class="reservation_update_record_selectBox_wrap selectBox_wrap">
						<select name="rtype">
							<option value="">변경전체보기</option>
							<option value="nc">일반진료 일정변경</option>
							<option value="fc">고정진료 일정변경</option>
							<option value="nt">일반치료 일정변경</option>
							<option value="ft">고정치료 일정변경</option>
						</select>
						<button>검색</button>
					</div><!-- reservation_update_record_selectBox_wrap end -->
					<div class="normal_off_selectBox_wrap selectBox_wrap">
						<select name="year">
							<option value="2019">2019년</option>
							<option value="2020">2020년</option>
							<option value="2021">2021년</option>
							<option value="2022">2022년</option>
							<option value="2023">2023년</option>
							<option value="2024">2024년</option>
							<option value="2025">2025년</option>
							<option value="2026">2026년</option>
							<option value="2027">2027년</option>
							<option value="2028">2028년</option>
							<option value="2029">2029년</option>
							<option value="2030">2030년</option>
						</select>
						<select name="month">
							<option value="01">1월</option>
							<option value="02">2월</option>
							<option value="03">3월</option>
							<option value="04">4월</option>
							<option value="05">5월</option>
							<option value="06">6월</option>
							<option value="07">7월</option>
							<option value="08">8월</option>
							<option value="09">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>
						</select>
						<select name="emp">
							<option value="">직원전체</option>
							<c:forEach var="dList" items="${doctorList}">
								<option value="${dList.eno}">${dList.name}</option>
							</c:forEach>
							<c:forEach var="tList" items="${therapistList}">
								<option value="${tList.eno}">${tList.name}</option>
							</c:forEach>
						</select>
						<button class="normal_off_search_btn">검색</button>
						<button class="normal_off_register_btn">추가</button>
					</div><!-- normal_off_selectBox_wrap end -->
					<div class="fix_off_selectBox_wrap selectBox_wrap">
						<select name="year">
							<option value="2019">2019년</option>
							<option value="2020">2020년</option>
							<option value="2021">2021년</option>
							<option value="2022">2022년</option>
							<option value="2023">2023년</option>
							<option value="2024">2024년</option>
							<option value="2025">2025년</option>
							<option value="2026">2026년</option>
							<option value="2027">2027년</option>
							<option value="2028">2028년</option>
							<option value="2029">2029년</option>
							<option value="2030">2030년</option>
						</select>
						<select name="month">
							<option value="01">1월</option>
							<option value="02">2월</option>
							<option value="03">3월</option>
							<option value="04">4월</option>
							<option value="05">5월</option>
							<option value="06">6월</option>
							<option value="07">7월</option>
							<option value="08">8월</option>
							<option value="09">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>
						</select>
						<select name="dow">
							<option value="">전체요일</option>
							<option value="월">월</option>
							<option value="화">화</option>
							<option value="수">수</option>
							<option value="목">목</option>
							<option value="금">금</option>
							<option value="토">토</option>
						</select>
						<select name="emp">
							<option value="">직원전체</option>
							<c:forEach var="dList" items="${doctorList}">
								<option value="${dList.eno}">${dList.name}</option>
							</c:forEach>
							<c:forEach var="tList" items="${therapistList}">
								<option value="${tList.eno}">${tList.name}</option>
							</c:forEach>
						</select>
						<button class="fix_off_search_btn">검색</button>
						<button class="fix_off_register_btn">추가</button>
					</div><!-- fix_off_selectBox_wrap end -->
					<div class="time_table_wrap">
					
					</div><!-- time_table_wrap -->
				</div><!-- ar_tbl_wrap_2 end -->
				<div class="ar_tbl_wrap_3">
					<div class="timetable_btn_wrap2">
						<ul>
							<li>진료일정</li>
							<li>치료일정</li>
							<li>예약이력</li>
							<li>변경이력</li>
						</ul>
					</div><!-- timetable_btn_wrap2 -->
					<div class="patient_week_tbl_selectBox_wrap">
						<select name="pwt_year" id="pwt_year">
						</select>
						<select name="pwt_month" id="pwt_month">
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
						<select name="pwt_week" id="pwt_week">
						</select>
					</div>
					<div class="patient_time_table_wrap">
					
					</div>
				</div><!-- ar_tbl_wrap_3 end -->
			</div><!-- aside_right end -->
		</div><!-- section end -->
		<div class="footer">
			
		</div><!-- footer_wrap end -->
	</div><!-- body_wrap end -->
</body>
</html> 