<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.popup_content{
		width:450px;
		background: #f3f3f3;
		margin:0 auto;
		margin-top:100px;
		position: relative;
		z-index: 999;
		text-align: center;
		padding-bottom: 1px;
	}
.popup_content > h2{
	width:100%;
	padding: 10px 0;
	background: #353c46;
	color: #fff;
	letter-spacing: 2px;
	overflow: hidden;
	vertical-align: middle;
	font-size: 25px;
	font-weight: bold;
}
.popup_content > table{
	width:100%;
	margin: 0 auto;
	border-bottom: 2px solid lightgray;
}
.popup_content > table tr{
	display:block;
}
.popup_content > table tr > th{
	font-size:16px;
	width:145px;
	background: #e9e9e9;
	color: #494949; 
	font-weight: bold;
	letter-spacing: 0.3px;
	padding: 15px 0;
	padding-left: 10px;
	text-align: left;
}
.popup_content > table tr > td{
	font-size:15px;
	padding-left: 20px;
}
.popup_content > table tr > td > span{
	vertical-align: middle;
}
.popup_content > table tr > td > input{
	font-size:15px;
	padding: 3px;
}
.popup_content > table tr > td > select{
	font-size: 15px;
	padding: 3px;
}
.popup_content > table tr > td > button{
	font-size: 15px;
	background: #353c46;
	color: #fff;
	letter-spacing: 1px;
	padding:4px;
	border-radius: 4px;
	margin-left:10px;
}
.popup_mypage{
	display:none;
}
.popup_mypage > .popup_mypage_btn_wrap{
	width: 100%;
	margin: 15px auto;
}
.popup_mypage > .popup_mypage_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #595959;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_patient_register{
	display: none;
}
.popup_patient_register > .popup_patient_register_submit_wrap{
	width: 100%;
	margin: 15px auto;
}
.popup_patient_register > .popup_patient_register_submit_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #595959;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_patientUpdate{
	display:none;
}
.popup_patientUpdate > .popup_patient_update_submit_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_patientUpdate > .popup_patient_update_submit_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #595959;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_clinic_reservation_register{
	display:none;
}
.popup_clinic_reservation_register .fix_clinic_res_tr{
	display:none;
}
.popup_therapy_reservation_register{
	display: none;
}
.popup_therapy_reservation_register .fix_therapy_res_tr{
	display: none;
}
.popup_reservation_register_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_reservation_register_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #595959;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_reservation_info_view{
	display:none;
	width: 510px;
}
.popup_reservation_info_view > table tr:nth-child(5) > td{
	text-align: left;
}
.popup_reservation_info_view > table tr:nth-child(5) > td > p{
	font-size: 15px;
	margin-bottom: 5px;
	cursor: pointer;
}
.popup_reservation_info_view > table tr:nth-child(5) > td > p:hover{
	font-weight: bold;
}
.popup_reservation_info_view > .popup_reservation_info_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_reservation_info_view > .popup_reservation_info_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #353c46;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_reservation_info_view > table .cancel_reason{
	display:none;
}
.popup_reservation_info_cancel_wrap > table{
	width: 100%;
}
.popup_reservation_update{
	display:none;
}
.popup_reservation_update > .popup_res_update_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_reservation_update > .popup_res_update_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #353c46;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_normal_off_register{
	display:none;
}
.popup_normal_off_register > .popup_normalOff_register_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_normal_off_register > .popup_normalOff_register_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #353c46;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_fix_off_register{
	display:none;
}
.popup_fix_off_register > .popup_fixOff_register_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_fix_off_register > .popup_fixOff_register_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #353c46;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_normal_off_update{
	display:none;
}
.popup_normal_off_update > .popup_normalOff_update_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_normal_off_update > .popup_normalOff_update_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #353c46;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
.popup_fix_off_update{
	display:none;
}
.popup_fix_off_update > .popup_fixOff_update_btn_wrap{
	width:100%;
	margin: 15px auto;
}
.popup_fix_off_update > .popup_fixOff_update_btn_wrap > p{
	display: inline-block;
	padding:8px 10px;
	font-size:15px;
	margin-left:20px;
	cursor: pointer;
	background: #353c46;
	color: #fff;
	border-radius: 4px;
	letter-spacing: 1px;
}
</style>
<script>
	$(function(){
		
	});
</script>
	<div class="popup_bg">
	</div>
	<div class="popup_mypage popup_content">
		<h2>내정보 수정</h2>
		<table>
			<tr>
				<th>▶ 이름</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>▶ 생년월일</th>
				<td><input type="text" name="birth"></td>
			</tr>
			<tr>
				<th>▶ 연락처</th>
				<td><input type="text" name="phone"></td>
			</tr>
			<tr>
				<th>▶ 아이디</th>
				<td><input type="text" name="id" readonly="readonly"></td>
			</tr>
			<tr>
				<th>▶ 변경 비밀번호</th>
				<td><input type="password" name="pw" placeholder="변경 시 입력해주세요."></td>
			</tr>
			<tr>
				<th>▶  비밀번호 확인</th>
				<td><input type="password" name="pwConfirm" placeholder="변경 시 입력해주세요."></td>
			</tr>
		</table>
		<div class="popup_mypage_btn_wrap">
			<p>저장</p>
			<p>닫기</p>
		</div>
	</div>
	
	<div class="popup_reservation_info_view popup_content">
		<h2></h2>
		<table>
			<tr>
				<th>▶ 연락처</th>
				<td><span></span><button>문자</button></td>
			</tr>
			<tr>
				<th>▶ 일정일시</th>
				<td><span></span><button>변경</button></td>
			</tr>
			<tr>
				<th>▶ 치료내용</th>
				<td><span></span></td>
			</tr>
			<tr>
				<th>▶ 메모</th>
				<td><span></span></td>
			</tr>
			<tr>
				<th>▶ 당일 예약 현황</th>
				<td></td>
			</tr>
			<tr class="cancel_reason">
				<th>▶ 취소사유</th>
				<td><textarea name="cancel_reason"></textarea><button>저장</button></td>
			</tr>
		</table>
		<div class="popup_reservation_info_btn_wrap">
			<p>닫기</p>
		</div>
	</div><!-- popup_reservation_info_view -->
	
	<div class="popup_normal_off_register popup_content">
		<h2>일반휴무 추가</h2>
		<table>
			<tr>
				<th>▶ 휴무자</th>
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
				<th>▶ 휴무종류</th>
				<td><input type="text" name="offType" value="휴무" placeholder="ex) 휴무"></td>
			</tr>
			<tr>
				<th>▶ 시작일</th>
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
				<th>▶ 종료일</th>
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
			<p>닫기</p>
		</div>
	</div><!-- popup_normal_off_register -->
	
	<div class="popup_normal_off_update popup_content">
		<h2>일반휴무 수정</h2>
		<span><input type="hidden" name="no" value=""></span>
		<table>
			<tr>
				<th>▶ 휴무자</th>
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
				<th>▶ 휴무종류</th>
				<td><input type="text" name="offType" value="휴무" placeholder="ex) 휴무"></td>
			</tr>
			<tr>
				<th>▶ 시작일</th>
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
				<th>▶ 종료일</th>
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
			<p>닫기</p>
		</div>
	</div><!-- popup_normal_off_update end -->
	
	<div class="popup_fix_off_register popup_content">
		<h2>고정휴무 추가</h2>
		<span><input type="hidden" name="no" value=""></span>
		<table>
			<tr>
				<th>▶ 휴무자</th>
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
				<th>▶ 휴무종류</th>
				<td><input type="text" name="offType" value="고정휴무" placeholder="ex) 고정휴무"></td>
			</tr>
			<tr>
				<th>▶ 요일</th>
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
				<th>▶ 시작일</th>
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
				<th>▶ 종료일</th>
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
			<p>닫기</p>
		</div>
	</div><!-- popup_fix_off_register -->
	
	<div class="popup_fix_off_update popup_content">
		<h2>고정휴무 수정</h2>
		<span><input type="hidden" name="no" value=""></span>
		<table>
			<tr>
				<th>▶ 휴무자</th>
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
				<th>▶ 휴무종류</th>
				<td><input type="text" name="offType" value="고정휴무" placeholder="ex) 고정휴무"></td>
			</tr>
			<tr>
				<th>▶ 요일</th>
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
				<th>▶ 시작일</th>
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
				<th>▶ 종료일</th>
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
			<p>닫기</p>
		</div>
	</div><!-- popup_fix_off_update end -->