<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<div class="popup_bg">
	</div>
	<div class="popup_clinic_register popup_content">
		<h2>코드등록</h2>
		<table>
			<tr>
				<th>코드명</th>
				<td><input type="text" name="code_name"></td>
			</tr>
			<tr>
				<th>코드분류</th>
				<td>
					<select>
						<option value="진료">진료</option>
						<option value="치료">치료</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>진행시간</th>
				<td>
					<select name="time">
						<option value="0">00분</option>
						<option value="10">10분</option>
						<option value="20">20분</option>
						<option value="30">30분</option>
						<option value="40">40분</option>
						<option value="50">50분</option>
						<option value="60">60분</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>색깔</th>
				<td><input type="text" name="color" placeholder="ex) #dfdfdf 색상코드표참고"></td>
			</tr>
		</table>
		<div class="popup_clinic_register_submit_wrap">
			<p>저장</p>
			<p>취소</p>
		</div>
	</div><!-- popup_clinic_register end -->
	
	<div class="popup_clinic_update popup_content">
		<h2>코드정보수정</h2>
		<input name="cno" type="hidden" value="">
		<table>
			<tr>
				<th>코드명</th>
				<td><input type="text" name="code_name"></td>
			</tr>
			<tr>
				<th>코드분류</th>
				<td>
					<select name="code_type">
						<option value="진료">진료</option>
						<option value="치료">치료</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>진행시간</th>
				<td>
					<select name="time">
						<option value="0">00분</option>
						<option value="10">10분</option>
						<option value="20">20분</option>
						<option value="30">30분</option>
						<option value="40">40분</option>
						<option value="50">50분</option>
						<option value="60">60분</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>색깔</th>
				<td><input type="text" name="color"></td>
			</tr>
		</table>
		<div class="popup_clinic_update_submit_wrap">
			<p>저장</p>
			<p>취소</p>
		</div>
	</div><!-- popup_clinic_update end -->