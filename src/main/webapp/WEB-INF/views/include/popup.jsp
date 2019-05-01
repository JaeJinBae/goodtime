<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.popup_content > h2{
	width:100%;
	background: #353c46;
	color: #fff;
	letter-spacing: 2px;
	overflow: hidden;
	vertical-align: middle;
}
.popup_content > h2 > button{
	color: #fff;
	font-size: 15px;
	font-weight: bold;
	background: #e63839;
	padding: 11px;
	float: right;
}
.popup_content > table{
	margin: 0 auto;
	margin-bottom:30px;
}
.popup_content > table tr{
	display:block;
	margin-top:30px;
}
.popup_content > table tr > th{
	font-size:16px;
	width:100px;
	color:#057be8;
	font-weight: bold;
	letter-spacing: 0.3px;
}
.popup_content > table tr > td{
	font-size:15px;
}
.popup_content > table tr > td > span{
	vertical-align: middle;
}
.popup_content > table tr > td > input{
	font-size:15px;
}
.popup_content > table tr > td > select{
	font-size: 15px;
}
.popup_content > table tr > td > button{
	font-size: 15px;
	padding:3px 5px;
	border: 1px solid lightgray;
	margin-left:10px;
}
.popup_patient_register{
	display: none;
}
.popup_patientUpdate{
	display:none;
}
.popup_patientUpdate > .popup_patient_update_submit_wrap{
	width:100%;
	margin: 0 auto;
	text-align: center;
}
.popup_patientUpdate > .popup_patient_update_submit_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	border:1px solid lightgray;
}
.popup_clinic_reservation_register{
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
.popup_reservation_info_view{
	display:none;
}
.popup_reservation_info_view > .popup_reservation_info_btn_wrap{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.popup_reservation_info_view > .popup_reservation_info_btn_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	border:1px solid lightgray;
}
.popup_reservation_info_cancel_wrap{
	display:none;
	width:100%;
	margin: 0 auto;
	background: #efefef;
}
.popup_reservation_info_cancel_wrap > table{
	width: 100%;
}
.popup_reservation_update{
	display:none;
}
.popup_reservation_update > .popup_res_update_btn_wrap{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.popup_reservation_update > .popup_res_update_btn_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	cursor: pointer;
	border:1px solid lightgray;
}
.popup_normal_off_register{
	display:none;
}
.popup_normal_off_register > .popup_normalOff_register_btn_wrap{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.popup_normal_off_register > .popup_normalOff_register_btn_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	border:1px solid lightgray;
}
.popup_fix_off_register{
	display:none;
}
.popup_fix_off_register > .popup_fixOff_register_btn_wrap{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.popup_fix_off_register > .popup_fixOff_register_btn_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	border:1px solid lightgray;
}
.popup_normal_off_update{
	display:none;
}
.popup_normal_off_update > .popup_normalOff_update_btn_wrap{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.popup_normal_off_update > .popup_normalOff_update_btn_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	border:1px solid lightgray;
}
.popup_fix_off_update{
	display:none;
}
.popup_fix_off_update > .popup_fixOff_update_btn_wrap{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.popup_fix_off_update > .popup_fixOff_update_btn_wrap > p{
	display: inline-block;
	padding:10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	border:1px solid lightgray;
}
</style>
	<div class="popup_bg">
	</div>
	<div class="popup_patient_register popup_content">
		<h2><span>환자등록 </span><button>X</button></h2>
		<table>
			<tr>
				<th>차트번호</th>
				<td><input type="text" name="cno" value=""><button>중복확인</button></td>
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
				<th>메모</th>
				<td><input type="text" name="memo" value=""></td>
			</tr>
		</table>
		<div class="popup_patient_register_submit_wrap">
			<p>저장</p>
			<p>취소</p>
		</div>
	</div><!-- popup_patient_register end -->
	
	<div class="popup_patientUpdate popup_content">
		<h2>회원정보수정<button>X</button></h2>
		<input name="pno" type="hidden" value="">
		<table>
			<tr>
				<th>차트번호</th>
				<td><input type="text" name="cno" value=""><button>중복확인</button></td>
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
				<th>메모</th>
				<td><input type="text" name="memo" value=""></td>
			</tr>
		</table>
		<div class="popup_patient_update_submit_wrap">
			<p>저장</p>
			<p>취소</p>
		</div>
	</div><!-- popup_patientUpdate end -->
	
	<!-- 진료일정등록 -->
	<div class="popup_clinic_reservation_register popup_content popup_content2">
		<h2><span></span>진료일정등록<button>X</button></h2>
		<table>
			<tr>
				<th>담당의사</th>
				<td>
					<select name="eno">
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
				<th>예약시간</th>
				<td>
					<span class="popup_reservation_register_date"></span>시
					<select name="rtime_minute">
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
						<option value="nc">일반예약</option>
						<option value="fc">고정예약</option>
						<option value="ch">희망예약</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>고정예약요일</th>
				<td>
					<select name="fix_day">
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
						<option value="토">토</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>고정예약시작일</th>
				<td><input type="text" name="fix_day_start" placeholder="ex) 2019-01-01" readonly="readonly"></td>
			</tr>
			<tr>
				<th>고정예약종료일</th>
				<td><input type="text" name="fix_day_end" placeholder="ex) 2019-01-01"></td>
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
	
	<!-- 치료일정등록 -->
	<div class="popup_therapy_reservation_register popup_content popup_content2">
		<h2><span></span>치료일정등록<button>X</button></h2>
		<table>
			<tr>
				<th>치료사</th>
				<td>
					<select name="eno">
						<c:forEach var="item" items="${therapistList}">
							<option value="${item.eno}">${item.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>예약구분</th>
				<td>
					<select name="rtype">
						<option value="nt">일반예약</option>
						<option value="ft">고정예약</option>
						<option value="th">희망예약</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>예약시간</th>
				<td>
					<span class="popup_reservation_register_date"></span>시
					<select name="rtime_minute">
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
				<th>치료종류</th>
				<td>
					<select name="clinic">
						<option value="">선택없음</option>
						<c:forEach var="item" items="${therapyList}"> 
							<option value="${item.cno}">${item.code_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>고정예약요일</th>
				<td>
					<select name="fix_day">
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
						<option value="토">토</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>고정예약시작일</th>
				<td><input type="text" name="fix_day_start" placeholder="ex) 2019-01-01" readonly="readonly"></td>
			</tr>
			<tr>
				<th>고정예약종료일</th>
				<td><input type="text" name="fix_day_end" placeholder="ex) 2019-01-01"></td>
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
	</div><!-- popup_therapy_reservation_register end -->
	
	<div class="popup_reservation_info_view popup_content">
		<h2><button>X</button></h2>
		<table>
			<tr>
				<th>연락처</th>
				<td><span></span><button>문자</button></td>
			</tr>
			<tr>
				<th>일정일시</th>
				<td><span></span><button>변경</button></td>
			</tr>
			<tr>
				<th>치료내용</th>
				<td><span></span></td>
			</tr>
			<tr>
				<th>메모</th>
				<td><span></span></td>
			</tr>
		</table>
		<div class="popup_reservation_info_btn_wrap">
			<p>예약완료</p>
			<p>접수완료</p>
			<p>예약취소</p>
		</div>
		<div class="popup_reservation_info_cancel_wrap">
			<table>
				<tr>
					<th>취소사유</th>
					<td><textarea name="cancel_reason"></textarea></td>
					<td><button>저장</button></td>
				</tr>
			</table>
		</div>
	</div><!-- popup_reservation_info_view -->
	
	<div class="popup_reservation_update popup_content">
		<h2><span></span>일정변경<button>X</button></h2>
		<table>
			<tr>
				<th>변경 전 일시</th>
				<td></td>
			</tr>
			<tr>
				<th>변경 날짜</th>
				<td><input type="date" name="rdate" value=""></td>
			</tr>
			<tr>
				<th>변경 시간</th>
				<td>
					<select name="rtime1">
						<option value="480">08시</option>
						<option value="540">09시</option>
						<option value="600">10시</option>
						<option value="660">11시</option>
						<option value="720">12시</option>
						<option value="780">13시</option>
						<option value="840">14시</option>
						<option value="900">15시</option>
						<option value="960">16시</option>
						<option value="1020">17시</option>
						<option value="1080">18시</option>
						<option value="1140">19시</option>
						<option value="1200">20시</option>
						<option value="1260">21시</option>
						<option value="1320">22시</option>
					</select>
					<select name="rtime2">
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
				<th>의사/치료사</th>
				<td>
					<select name="emp">
						
					</select>
				</td>
			</tr>
			<tr>
				<th>진료종류</th>
				<td>
					<select name="clinic">
					
					</select>
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td><input type="text" name="memo" value=""></td>
			</tr>
			<tr>
				<th>변경사유</th>
				<td><input type="text" name="updateMemo" value=""></td>
			</tr>
		</table>
		<div class="popup_res_update_btn_wrap">
			<p>변경일정저장</p>
		</div>
	</div><!-- popup_normal_reservation_update -->
	
	<div class="popup_normal_off_register popup_content">
		<h2>일반휴무 추가<button>X</button></h2>
		<table>
			<tr>
				<th>휴무자</th>
				<td>
					<select name="emp">
						<option value="">선택해주세요.</option>
						<c:forEach var="list" items="${doctorList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
						<c:forEach var="list" items="${therapistList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>휴무종류</th>
				<td><input type="text" name="offType" value="휴무" placeholder="ex) 휴무"></td>
			</tr>
			<tr>
				<th>시작일</th>
				<td>
					<input type="date" name="startdate" value="">
					<select name="starttime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>종료일</th>
				<td>
					<input type="date" name="enddate" value="">
					<select name="endtime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<div class="popup_normalOff_register_btn_wrap">
			<p>휴무 등록</p>
		</div>
	</div><!-- popup_normal_off_register -->
	
	<div class="popup_normal_off_update popup_content">
		<h2>일반휴무 수정<button>X</button></h2>
		<span><input type="hidden" name="no" value=""></span>
		<table>
			<tr>
				<th>휴무자</th>
				<td>
					<select name="emp" disabled>
						<option value="">선택해주세요.</option>
						<c:forEach var="list" items="${doctorList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
						<c:forEach var="list" items="${therapistList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>휴무종류</th>
				<td><input type="text" name="offType" value="휴무" placeholder="ex) 휴무"></td>
			</tr>
			<tr>
				<th>시작일</th>
				<td>
					<input type="date" name="startdate" value="">
					<select name="starttime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>종료일</th>
				<td>
					<input type="date" name="enddate" value="">
					<select name="endtime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<div class="popup_normalOff_update_btn_wrap">
			<p>수정</p>
			<p>삭제</p>
		</div>
	</div><!-- popup_normal_off_update end -->
	
	<div class="popup_fix_off_register popup_content">
		<h2>고정휴무 추가<button>X</button></h2>
		<span><input type="hidden" name="no" value=""></span>
		<table>
			<tr>
				<th>휴무자</th>
				<td>
					<select name="emp">
						<option value="">선택해주세요.</option>
						<c:forEach var="list" items="${doctorList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
						<c:forEach var="list" items="${therapistList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>휴무종류</th>
				<td><input type="text" name="offType" value="고정휴무" placeholder="ex) 고정휴무"></td>
			</tr>
			<tr>
				<th>요일</th>
				<td>
					<select name="dow">
						<option value="">요일선택</option>
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
						<option value="토">토</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>시작일</th>
				<td>
					<input type="date" name="startdate" value="">
					<select name="starttime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>종료일</th>
				<td>
					<input type="date" name="enddate" value="">
					<select name="endtime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<div class="popup_fixOff_register_btn_wrap">
			<p>휴무 등록</p>
		</div>
	</div><!-- popup_fix_off_register -->
	
	<div class="popup_fix_off_update popup_content">
		<h2>고정휴무 수정<button>X</button></h2>
		<span><input type="hidden" name="no" value=""></span>
		<table>
			<tr>
				<th>휴무자</th>
				<td>
					<select name="emp" disabled>
						<option value="">선택해주세요.</option>
						<c:forEach var="list" items="${doctorList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
						<c:forEach var="list" items="${therapistList}">
							<option value="${list.eno}_${list.type}">${list.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>휴무종류</th>
				<td><input type="text" name="offType" value="고정휴무" placeholder="ex) 고정휴무"></td>
			</tr>
			<tr>
				<th>요일</th>
				<td>
					<select name="dow">
						<option value="">요일선택</option>
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
						<option value="토">토</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>시작일</th>
				<td>
					<input type="date" name="startdate" value="">
					<select name="starttime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>종료일</th>
				<td>
					<input type="date" name="enddate" value="">
					<select name="endtime">
						<c:forEach var="idx" begin="8" end="23">
							<option value="${idx}">${idx}시</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<div class="popup_fixOff_update_btn_wrap">
			<p>수정</p>
			<p>삭제</p>
		</div>
	</div><!-- popup_fix_off_update end -->