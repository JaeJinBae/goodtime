<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<div class="popup_bg">
	</div>
	<div class="popup_employee_register popup_content">
		<h2>직원등록</h2>
		<table>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" name="phone" placeholder="ex)010-1234-1234"></td>
			</tr>
			<tr>
				<th>등급</th>
				<td>
					<select name="type">
						<option value="doctor">의사</option>
						<option value="therapist">치료사</option>
						<option value="manager">관리자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>레벨</th>
				<td>
					<select name="level">
						<option value="lv1">레벨1</option>
						<option value="lv2">레벨2</option>
						<option value="lv3">레벨3</option>
						<option value="lv4">레벨4</option>
						<option value="lv5">레벨5</option>
						<option value="lv6">레벨6</option>
						<option value="lv7">레벨7</option>
						<option value="lv8">레벨8</option>
						<option value="lv9">레벨9</option>
						<option value="lv10">레벨10</option>
						<option value="lv11">레벨11</option>
						<option value="lv12">레벨12</option>
						<option value="lv13">레벨13</option>
						<option value="lv14">레벨14</option>
						<option value="lv15">레벨15</option>
						<option value="lv16">레벨16</option>
						<option value="lv17">레벨17</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>ID</th>
				<td><input type="text" name="id" placeholder="영문, 숫자만 가능"><input type="hidden" name="id_check" value="no"><button class="id_duplication_check_btn">중복확인</button></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<th>비밀번호확인</th>
				<td><input type="password" name="pwconfirm"></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="text" name="birth" value="" placeholder="ex)1988-12-12"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="mail" value="" placeholder="ex)test@domain.com"></td>
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
				<th>메모</th>
				<td><input type="text" name="memo" value=""></td>
			</tr>
		</table>
		<div class="popup_employee_register_submit_wrap">
			<p>저장</p>
			<p>취소</p>
		</div>
	</div><!-- popup_employee_register end -->
	
	<div class="popup_employee_update popup_content">
		<h2>직원정보수정</h2>
		<input name="eno" type="hidden" value="">
		<table>
			<tr>
				<th>이름</th>
				<td><input type="text" value="" name="name"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" value="" name="phone" placeholder="ex)010-1234-1234"></td>
			</tr>
			<tr>
				<th>등급</th>
				<td>
					<select name="type">
						<option value="doctor">의사</option>
						<option value="therapist">치료사</option>
						<option value="manager">관리자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>레벨</th>
				<td>
					<select name="level">
						<option value="lv1">레벨1</option>
						<option value="lv2">레벨2</option>
						<option value="lv3">레벨3</option>
						<option value="lv4">레벨4</option>
						<option value="lv5">레벨5</option>
						<option value="lv6">레벨6</option>
						<option value="lv7">레벨7</option>
						<option value="lv8">레벨8</option>
						<option value="lv9">레벨9</option>
						<option value="lv10">레벨10</option>
						<option value="lv11">레벨11</option>
						<option value="lv12">레벨12</option>
						<option value="lv13">레벨13</option>
						<option value="lv14">레벨14</option>
						<option value="lv15">레벨15</option>
						<option value="lv16">레벨16</option>
						<option value="lv17">레벨17</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>ID</th>
				<td><input type="text" name="id" value="" placeholder="영문, 숫자만 가능"><input type="hidden" name="id_check" value="no"><button class="id_duplication_check_btn">중복확인</button></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<th>비밀번호확인</th>
				<td><input type="password" name="pwconfirm"></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="text" name="birth" value="" placeholder="ex)1988-12-12"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="mail" value="" placeholder="ex)test@domain.com"></td>
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
				<th>메모</th>
				<td><input type="text" name="memo" value=""></td>
			</tr>
		</table>
		<div class="popup_employee_update_submit_wrap">
			<p>저장</p>
			<p>취소</p>
		</div>
	</div><!-- popup_employee_update end -->