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

</style>
<script>
function get_reservationCount_byDate(date){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/reservationCountByDate/"+date,
		type:"get",
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

function draw_cureCnt(date){
	var json = get_reservationCount_byDate(date);
	var splitStr;
	var target;
	var ntrTotal = 0;
	var ftrTotal = 0;
	var ntrNum;
	var ftrNum;
	var totalNum;
	
	//각 tr에 ntr, ftr 값 넣기
	$(json).each(function(){
		splitStr = this.split("_");
		target = "."+splitStr[0]+"_"+splitStr[1];
		$(target).text(splitStr[2]);
		
		if(splitStr[1] == "ntr"){
			ntrTotal += Number(splitStr[2]);
		}else if(splitStr[1] == "ftr"){
			ftrTotal += Number(splitStr[2])
		}
		
		$("."+splitStr[0]+"_total").text();
	});
	
	//전체 ntr, ftr total값
	 $(".total_ntr").text(ntrTotal);
	 $(".total_ftr").text(ftrTotal);
	
	 //각 tr의 total값 계산해서 넣기
	 $(".table_wrap > table tr").each(function(){
		if($(this).index() > 0){
			ntrNum = Number($(this).find("td").eq(1).text());
			ftrNum = Number($(this).find("td").eq(2).text());
			totalNum = ntrNum+ftrNum;
			$(this).find("td").eq(3).text(totalNum);
		}
	 });
}

function statistic_base_setting(){
	var nowDate = new Date();
	var nowYear = nowDate.getFullYear();
	var nowMonth = nowDate.getMonth()+1;
	$(".aside1_selectBox_wrap > select[name='sb_year'] > option[value='"+nowYear+"']").prop("selected", true);
	$(".aside1_selectBox_wrap > select[name='sb_month'] > option[value='"+nowMonth+"']").prop("selected", true);
	nowMonth=(nowMonth>9?'':'0')+nowMonth;
	
	draw_cureCnt(nowYear+"-"+nowMonth);
}

function excelDown(eno, date){
	console.log(eno+"/"+date);
	$.ajax({
		url:"${pageContext.request.contextPath}/statisticDown/"+eno+"/"+date,
		type:"post",
		dataType:"text",
		async:false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

$(function(){
	statistic_base_setting();
	
	$(document).on("click", ".aside1_selectBox_wrap > button", function(){
		var selYear = $(".aside1_selectBox_wrap > select[name='sb_year']").val();
		var selMonth = $(".aside1_selectBox_wrap > select[name='sb_month']").val();
		selMonth=(selMonth>9?'':'0')+selMonth;
		
		draw_cureCnt(selYear+"-"+selMonth);
	});
	
	$(document).on("click", ".aside1 > .table_wrap > table tr > td > button", function(){
		var eno = $(this).parent().parent().find("input[name='eno']").val();
		var selYear = $(".aside1_selectBox_wrap > select[name='sb_year']").val();
		var selMonth = $(".aside1_selectBox_wrap > select[name='sb_month']").val();
		selMonth=(selMonth>9?'':'0')+selMonth;
		
		excelDown(eno, selYear+"-"+selMonth);
		//window.open('data:application/vnd.ms-excel,'+$(".table_wrap").html());

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
				<div class="aside1_selectBox_wrap">
					<select name="sb_year">
						<option value="2019">2019년</option>
						<c:forEach var="idx" begin="2019" end="2080">
							<option value="${idx}">${idx}년</option>
						</c:forEach>
					</select>
					<select name="sb_month">
						<c:forEach var="idx" begin="1" end="12">
							<option value="${idx}">${idx}월</option>
						</c:forEach>
					</select>
					<button>검색</button>
				</div>
				<div class="table_wrap">
					<table>
						<tr>
							<th>치료사</th>
							<th>일반치료</th>
							<th>고정치료</th>
							<th>Total</th>
							<th>엑셀</th>
						</tr>
						<tr>
							<td>Total</td>
							<td class="total_ntr"></td>
							<td class="total_ftr"></td>
							<td class="totalAll"></td>
							<td>-</td>
						</tr>
						<c:forEach var="item" items="${list}">
							<tr class="${item.eno}_tr">
								<td class="${item.eno}_name">${item.name}<input type="hidden" name="eno" value="${item.eno}"></td>
								<td class="${item.eno}_ntr"></td>
								<td class="${item.eno}_ftr"></td>
								<td class="${item.eno}_total"></td>
								<td><button>내려받기</button></td>
							</tr>
						</c:forEach>
						
					</table>
				</div><!-- table_wrap end -->
			</div>
		</div>
		<div class="footer">
		</div>
	</div>
</body>
</html>