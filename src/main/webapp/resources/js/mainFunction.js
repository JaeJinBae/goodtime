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
			draw_patient_table();
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
		url:"${pageContext.request.contextPath}/employeeGetByEno/"+eno,
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

function get_reservationList_byDate_byEmployee(date, type, eno, week){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationListByDateEno/"+date+"/"+type+"/"+eno+"/"+week,
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
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("doctor"), "doctor", idx);
			break;
		case 3:
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 3;
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("doctor"), "doctor", idx);
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
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("therapist"), "therapist", idx);
			break;
		case 6:
			$(".time_table_wrap").html("");
			storage_timetable_btn_num = 6;
			$(".week_select_box_wrap").css("display","block");
			draw_week_calendar($(".calendar_select_date").val(), get_employeeList_byType("therapist"), "therapist", idx);
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

function post_reservation_register(vo, stbn){
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
				
				draw_time_table_by_case(stbn);
			}else{
				alert("예약등록이 정상적으로 등록되지 않았습니다. 다시 한번 등록하세요.");
			}
		}
	});
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
		str += "<tr class='"+employee+"_"+arrDate[i]+"'><td>"+arrDay[i]+"("+arrDate[i].split("-")[2]+"일)<input type='hidden' name='day' value='"+arrDay[i]+"'></td>";
		for(n=8; n < 20; n++){
			str += "<td class='"+employee+"_"+arrDate[i]+"_"+n+"'></td>";
		}
		str += "</tr>";
	}
	str += "</table>";
	
	$(".time_table_wrap").html(str);
	
	draw_week_reservation(arrDate, etype, employee, idxx);
}

function draw_week_reservation(week, etype, eno, idxx){
	var week_reservation = [];
	var json;
	var str="";
	var target_tag = "";
	var week_sDate = week[1];
	var week_eDate = week[6];
	console.log(idxx);
	for(var i=1; i < week.length; i++){
		json = get_reservationList_byDate_byEmployee(week[i], etype, eno, week) 
		week_reservation.push(json);
	}
	if(idxx == 3 || idxx == 6){
		$(week_reservation).each(function(){
			$($(this)[0].fixVO).each(function(){
				console.log(this);
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
				var cs = $(".time_table_wrap > table tr > td > input[value='"+this.fix_day+"']").parent().parent().prop("class");
				//console.log(cs);
				target_tag = "."+cs+"_"+parseInt(Number(this.fix_rtime)/60);
				str = "<p class='patient_p_tag' style='background:#ffaf7a;border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
				$(target_tag).append(str);
			})
		});
		
	}else{
		$(week_reservation).each(function(){
			$($(this)[0].normalVO).each(function(){
				//console.log(this);
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
				
				target_tag = "."+eno+"_"+this.normal_date+"_"+parseInt(Number(this.normal_rtime)/60);
				str = "<p class='patient_p_tag' style='background:"+clinic.color+";border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
				$(target_tag).append(str);
			})
			
			$($(this)[0].fixVO).each(function(){
				console.log(this);
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
				var cs = $(".time_table_wrap > table tr > td > input[value='"+this.fix_day+"']").parent().parent().prop("class");
				console.log(cs);
				target_tag = "."+cs+"_"+parseInt(Number(this.fix_rtime)/60);
				str = "<p class='patient_p_tag' style='background:#ffaf7a;border:1px solid gray;'>"+minute+"~"+end_time+" "+patient.name+"<input type='hidden' value='"+this.rno+"'></p>";
				$(target_tag).append(str);
			})
		});
	}
}