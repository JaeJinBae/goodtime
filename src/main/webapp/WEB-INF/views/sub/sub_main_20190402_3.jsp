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
	.popup_patientUpdate{
		display:none;
	}
	.popup_reservation_register{
		display:none;
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
	}
	.ar_tbl_wrap_1{
		width:100%;
		margin-top:100px;
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
		padding: 10px 0;
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
		padding: 5px 0;
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
		clear:both;
		width:626px; 
		margin:70px auto;
		margin-bottom:50px;
	}
	.page > ul{
		text-align: center;
	}
	.page ul li{
		width:45px;
		height:40px;
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
		font-size:1.1em;
		line-height: 40px;
	}
	.ar_tbl_wrap_2 {
		width:100%;
	}
	.ar_tbl_wrap_2 > table{
		width:100%;
	}
	.ar_tbl_wrap_2 table td{
		border: 1px solid black;
	}
	.doctor_name{
		text-align: center;
	}
	.ar_tbl_wrap_3 {
		width:100%;
		margin-top: 100px;
	}
	.ar_tbl_wrap_3 > table{
		width:100%;
	}
	.ar_tbl_wrap_3 table td{
		border: 1px solid black;
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
$(function(){
	
	
	
	
	
	
	
	
	
	

	
	
		
});





</script> 
</head> 
<body>
	<div class="popup_wrap">
		<div class="popup_bg">
		</div>
		<div class="popup_patientUpdate popup_content">
			<h2>회원정보수정</h2>
			<input name="pno" type="hidden" value="">
			<table>
				<tr>
					<th>차트번호</th>
					<td><input type="text" name="cno" value=""></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" value=""></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="phone" value=""></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="birth" value=""></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<select name="gender">
							<option value="남">남</option>
							<option value="여">여</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>담당의사</th>
					<td>
						<select name="main_doctor">
							<option value="">선택해주세요.</option>
							<c:forEach var="list" items="${doctorList}">
								<option value="${list.eno}">${list.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>담당치료사</th>
					<td>
						<select name="main_therapist">
							<option value="">선택해주세요.</option>
							<c:forEach var="list" items="${therapistList}">
								<option value="${list.eno}">${list.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="mail" value=""></td>
				</tr>
				<tr>
					<th>메모</th>
					<td><input type="text" name="memo" value=""></td>
				</tr>
			</table>
			<div class="popup_patient_update_submit_wrap">
				<p>저장</p>
				<p>취소</p>
			</div>
		</div><!-- popup_patientUpdate end -->
		<div class="popup_reservation_register popup_content">
			<h2><span></span>진료일정등록</h2>
			<table>
				<tr>
					<th>예약시간</th>
					<td>
						<span id="popup_reservation_register_date"></span>시
						<select name="time">
							<option value="0">00분</option>
							<option value="10">10분</option>
							<option value="20">20분</option>
							<option value="30">30분</option>
							<option value="40">40분</option>
							<option value="50">50분</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>예약구분</th>
					<td>
						<select name="rtype">
							<option value="일반진료">일반진료</option>
							<option value="희망예약">희망예약</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>담당의사</th>
					<td>
						<select name="main_doctor">
							<c:forEach var="item" items="${doctorList}">
								<option value="${item.eno}">${item.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>진료종류</th>
					<td>
						<select name="clinic">
							<option value="">선택없음</option>
							<c:forEach var="item" items="${clinicList}">
								<option value="${item.cno}">${item.code_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>메모</th>
					<td><input type="text" name="memo" value=""></td>
				</tr>
			</table>
			<div class="popup_reservation_register_btn_wrap">
				<p>예약추가</p>
				<p>진료접수</p>
				<p>취소</p>
			</div>
		</div><!-- popup_reservation_register -->
		
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