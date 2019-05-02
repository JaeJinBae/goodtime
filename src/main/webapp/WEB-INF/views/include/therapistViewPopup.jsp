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
.popup_reservation_info_view{
	display:none;
}
.popup_reservation_info_view > .popup_reservation_info_btn_wrap{
	width: 100%;
	margin: 15px auto;
}
.popup_reservation_info_view > .popup_reservation_info_btn_wrap > p{
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
</style>
<script>
$(function(){
	
});
</script>
<div class="popup_bg">
</div>
	
<div class="popup_reservation_info_view popup_content">
	<h2></h2>
	<table>
		<tr>
			<th>연락처</th>
			<td><span></span><button>문자</button></td>
		</tr>
		<tr>
			<th>일정일시</th>
			<td><span></span></td>
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
		<p>치료완료</p>
		<p>닫기</p>
	</div>
</div><!-- popup_reservation_info_view -->

