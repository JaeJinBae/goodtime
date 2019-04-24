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
		display:none;
		width:600px;
		height:700px;
		background:#fff;
		margin:0 auto;
		margin-top:100px;
		position: relative;
		z-index: 999;
	}
	.popup_content > table tr{
		display:block;
		margin-top:30px;
	}
	.popup_content > table tr > th{
		font-size:15px;
		width:100px;
	}
	.popup_content > table tr > td{
		font-size:15px;
	}
	.popup_content > table tr > td > select{
		font-size: 15px;
	}
	
	.aside1{
		width:1000px;
		margin-left:50px;
		margin-top:50px;
		overflow:hidden;
	}
	.aside1 > h2{
		margin-bottom:20px;
		font-size:25px;
	}
	.tbl_wrap{
		width:500px;
	}
	.tbl_wrap > table{
		width:100%;
	}
	.tbl_wrap > table tr{
		border-bottom: 1px solid lightgray;
	}
	.tbl_wrap > table tr:first-child{
		border-top:3px solid lightgray;
		border-bottom:3px solid lightgray;
	}
	.tbl_wrap > table tr:first-child > th{
		font-size:17px;
		font-weight: bold;
		padding-top:10px;
		padding-bottom:10px;
	}
	.tbl_wrap > table tr > th{
		font-size: 17px;
		font-weight: bold;
		vertical-align: middle;
	}
	.tbl_wrap > table tr > td{
		text-align: center;
		font-size:15px;
		padding-top: 10px;
		padding-bottom:10px;
	}
	.tbl_wrap > table tr > td > select{
		font-size:15px;
		padding:2px;
	}

</style>
<script>
function get_hospitalInfo_all(){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/hospitalInfoGetAll",
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

function update_hospitalInfo(list){
	console.log(list);
	$.ajax({
		url:"${pageContext.request.contextPath}/updateHospitalInfo",
		type: "POST",
		dataType:"text",
		data:JSON.stringify(list),
		contentType : "application/json; charset=UTF-8",
		async: false,
		success:function(json){
			console.log("결과는 "+json);
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function setting_time(){
	var json = get_hospitalInfo_all();
	var arrDay = ["mon", "tue", "wed", "thu", "fri", "sat", "week"];
	var st = "";
	var et = "";
	
	for(var i=0; i<arrDay.length; i++){
		st = Number(json[i].start_time)/60;
		et = Number(json[i].end_time)/60;
		$(".tbl_wrap > table tr > td select[name='"+arrDay[i]+"_st'] > option[value='"+st+"']").prop("selected", true);
		$(".tbl_wrap > table tr > td select[name='"+arrDay[i]+"_et'] > option[value='"+et+"']").prop("selected", true);
	}
	
}
$(function(){
	setting_time();
	
	$(".hos_time_btn_wrap").click(function(){
		var dow;
		var st;
		var et;
		var arrDay = ["", "mon", "tue", "wed", "thu", "fri", "sat", "week"];
		var arrVO = [];
		for(var i=1; i<8; i++){
			st = Number($(".tbl_wrap > table tr:eq("+i+") > td > select[name='"+arrDay[i]+"_st']").val())*60;
			et = Number($(".tbl_wrap > table tr:eq("+i+") > td > select[name='"+arrDay[i]+"_et']").val())*60;
			
			
			arrVO.push({day:arrDay[i], start_time:st, end_time:et});
		}
		update_hospitalInfo(arrVO);
	});
	
});
</script>
</head>
<body>
	<div class="popup_wrap">
		
	</div>
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside1">
				<h2>- 요일별 시간 설정</h2>
				<div class="tbl_wrap">
					<table>
						<tr>
							<th>요일</th>
							<th>시작시간</th>
							<th>종료시간</th>
						</tr>
						<tr>
							<th>월</th>
							<td>
								<select name="mon_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="mon_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>화</th>
							<td>
								<select name="tue_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="tue_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>수</th>
							<td>
								<select name="wed_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="wed_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>목</th>
							<td>
								<select name="thu_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="thu_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>금</th>
							<td>
								<select name="fri_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="fri_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>토</th>
							<td>
								<select name="sat_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="sat_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>주간/고정</th>
							<td>
								<select name="week_st">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="week_et">
									<c:forEach var="num" begin="7" end="24" >
										<option value="${num}">${num}시</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
					<div class="hos_time_btn_wrap">
						<button>저장</button>
					</div>
				</div><!-- tbl_wrap end -->
			</div><!-- aside1 end -->
		</div><!-- section end -->
		<div class="footer">
		</div>
	</div><!-- all_wrap end -->
</body>
</html>