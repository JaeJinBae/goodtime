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
	
</style> 
<script>
$(function(){
	/* var num=130;
	console.log(parseInt(num/60)+", "+num%60); */
	
	//달력 생성
	buildCalendar();
	
	//환자 list 생성
	get_patient();
	
	//날짜마다 요일 표시
	write_yoil();
	
	//오늘 요일 및 날짜에 해당하는 병원 정보, 진료 예약 정보 GET 
	get_day_reservation_info(get_today());
	
	$(document).on("click", ".patient_update_btn", function(){
		var pno=$(this).parent().parent().find("input[type='hidden']").val()
		alert(pno);
		
	});
	
	
	
	
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
		
	
	$(document).on("click", ".page > ul > li > a", function(e){
		e.preventDefault();
		get_patient($(this).attr("href"));
	});
	
	$("#searchBtn").click(function(){
    	var s=$("select[name='searchType']").val();
		var searchType = encodeURIComponent(s);
		var k=$("input[name='keyword']").val();
		var keyword = encodeURIComponent(k);
		get_patient("page=1&perPageNum=10&searchType="+searchType+"&keyword="+keyword);
		
	});
	
});

function get_patient(info){
	$.ajax({
		url:"${pageContext.request.contextPath}/patientAllGet",
		type: "get",
		data:info,
		dataType:"json",
		success:function(json){
			var str = "";
			
			console.log(json);
			$("#inner_tbl_wrap").empty();
			console.log(json.patientListAll.length);
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
			$(".ar_tbl_wrap_2").html(txt);
			
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
			$(".ar_tbl_wrap_3").html(txt);
			
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
	<div class="popup_wrap">
		<div class="popup_bg">
		</div>
		<div class="popup_content popup_patientUpdate">
			<h2>회원정보수정</h2>
			<table>
				<tr>
					<th>차트번호</th>
					<td></td>
				</tr>
				<tr>
					<th>이름</th>
					<td></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td></td>
				</tr>
				<tr>
					<th>성별</th>
					<td></td>
				</tr>
				<tr>
					<th>담당의사</th>
					<td>
						<select>
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>담당치료사</th>
					<td>
						<select>
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td></td>
				</tr>
				<tr>
					<th>메모</th>
					<td></td>
				</tr>
			</table>
		</div>
	</div>
	
	
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