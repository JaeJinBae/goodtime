<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		
		<!-- 진료일정등록 -->
		<div class="popup_reservation_register popup_content popup_content2">
			<h2><span></span>진료일정등록</h2>
			<table>
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
					<th>예약시간</th>
					<td>
						<span class="popup_reservation_register_date"></span>시
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
							<option value="일반진료">일반예약</option>
							<option value="고정진료">고정예약</option>
							<option value="희망예약">희망예약</option>
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
					<th>고정예약시간</th>
					<td>
						<select name="fix_rtime1">
							
						</select>
					</td>
					<td>
						<select name="fix_rtime2">
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
					<th>고정예약시작일</th>
					<td><input type="text" name="fix_day_start" placeholder="ex) 2019-01-01"></td>
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
			<h2><span></span>치료일정등록</h2>
			<table>
				<tr>
					<th>치료사</th>
					<td>
						<select name="main_therapist">
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
							<option value="일반치료">일반예약</option>
							<option value="고정치료">고정예약</option>
							<option value="희망예약">희망예약</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>예약시간</th>
					<td>
						<span class="popup_reservation_register_date"></span>시
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
					<th>고정예약시간</th>
					<td>
						<select name="fix_rtime1">
							
						</select>
					</td>
					<td>
						<select name="fix_rtime2">
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
					<th>고정예약시작일</th>
					<td><input type="text" name="fix_day_start" placeholder="ex) 2019-01-01"></td>
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