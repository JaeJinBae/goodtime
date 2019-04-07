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
	.aside1 > .select_btn_wrap{
		float:left;
	}
	.clinic_register_btn_wrap{
		float:right;
	}
	.aside1 > .table_wrap > table {
		width:100%;
		border-top: 2px solid gray;
	}
	.aside1 > .table_wrap > table tr th{
		font-size:15px;
		text-align: center;
		font-weight: bold;
		border-bottom: 2px solid #efefef;
		padding: 7px 0;
	}
	.aside1 > .table_wrap > table tr > td{
		font-size:15px;
		text-align: center;
		padding-top: 15px;
	}
	.aside1 > .table_wrap > table tr > th:first-child{
		width:0;
	}
	.aside1 > .table_wrap > table tr > td > p{
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
		float:right;
		/* width:626px; */ 
		margin:15px;
		margin-bottom:80px;
	}
	.page > ul{
		text-align: center;
	}
	.page ul li{
		
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
		display:inline-block;
		width:35px;
		height:30px;
		font-size:1.1em;
		line-height: 30px;
	}
</style>
<script>
function get_clinic_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/clinicAllGet",
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

function draw_clinic_table(info){
	var json = get_clinic_all(info);
	
	var str = "";

	$(".aside1 > .table_wrap").empty();
	
	str ="<table><tr><th></th><th>코드명</th><th><p class='clinic_table_update_btn'>설정</p></th><th>코드분류</th><th>진행시간(분)</th><th>색깔</th></tr>";
	
	if(json.clinicListAll.length == 0){
		str += "<tr><td colspan='8'>등록된 회원이 없습니다.</td></tr>";
	}else{
		$(json.clinicListAll).each(function(){
			str += "<tr><td><input type='hidden' name='cno' value='"+this.cno+"'></td><td>"+this.code_name+"</td><td><p class='clinic_update_btn'>수정</p></td>"
				+"<td>"+this.code_type+"</td><td>"+this.time+"</td><td style='background:"+this.color+";'>"+this.color+"</td></tr>";
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
	$(".aside1 > .table_wrap").append(str);
}


function get_clinic_by_cno(cno){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/clinicGetByCno/"+cno,
		type:"get",
		dataType:"json",
		async:false,
		success:function(json){
			dt = json;
		}
	}) 
	return dt;
}



//환자 정보 수정view에 정보 기입
function draw_clinic_update_view(cno){
	var json = get_clinic_by_cno(cno);

	$(".popup_clinic_update > input[name='cno']").val(json.cno); 
	$(".popup_clinic_update > table tr > td > input[name='code_name']").val(json.code_name);
	$(".popup_clinic_update > table tr > td > select[name='code_type'] > option[value='"+json.code_type+"']").prop("selected", true);
	$(".popup_clinic_update > table tr > td > select[name='time'] > option[value='"+json.time+"']").prop("selected", true);
	$(".popup_clinic_update > table tr > td > input[name='color']").val(json.color);
	
	$(".popup_wrap").css("display","block");
	$(".popup_clinic_update").css("display", "block");
}

function post_clinic_register(vo){
	console.log(vo);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/clinicRegister",
		type:"post",
		dataType:"text",
		data:vo,
		async:false,
		success:function(json){
			$(".popup_clinic_register").css("display", "none");
			$(".popup_wrap").css("display","none");
			alert("코드등록이 완료되었습니다.");
			draw_clinic_table();
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function post_clinic_update(vo){
	$.ajax({
		url:"${pageContext.request.contextPath}/clinicUpdate",
		type:"post",
		dataType:"text",
		data:vo,
		async:false,
		success:function(json){
			$(".popup_clinic_update").css("display", "none");
			$(".popup_wrap").css("display","none");
			draw_clinic_table();
		}
	});
}

$(function(){
	draw_clinic_table();
	
	//코드 검색
	$("#searchBtn").click(function(){
    	var s=$("select[name='searchType']").val();
		var searchType = encodeURIComponent(s);
		var k=$("input[name='keyword']").val();
		var keyword = encodeURIComponent(k);
		draw_clinic_table("page=1&perPageNum=10&searchType="+searchType+"&keyword="+keyword);
	});
	
	//코드table에서 페이지 클릭
	$(document).on("click", ".page > ul > li > a", function(e){
		e.preventDefault();
		draw_clinic_table($(this).attr("href"));
	});
	
	//코드추가 버튼 클릭
	$(".clinic_register_btn_wrap > button").click(function(){
		$(".popup_wrap").css("display", "block");
		$(".popup_clinic_register").css("display", "block");
	});
		
	//코드 등록popup에서 버튼 클릭
	$(".popup_clinic_register_submit_wrap > p").click(function(){
		var idx = $(this).index();
		if(idx == 0){
			var cno = "0";
			var code_name = $(".popup_clinic_register > table tr > td > input[name='code_name']").val();
			var code_type = $(".popup_clinic_register > table tr > td > select[name='code_type']").val();
			var time = $(".popup_clinic_register > table tr > td > select[name='time']").val();
			var color = $(".popup_clinic_register > table tr > td > input[name='color']").val();

			if(code_name == ""){
				alert("코드명을 입력해주세요.");
				return false;
			}else if(color == ""){
				alert("색깔을 입력해주세요.");
				return false;
			}else{
				var vo = {cno:cno, code_name:code_name, code_type:code_type, time:time, color:color}
				
				post_clinic_register(vo);
			}

		}else{
			$(".popup_clinic_register").css("display", "none");
			$(".popup_wrap").css("display", "none");
		}
	});
		
	//코드 수정버튼 클릭
	$(document).on("click", ".clinic_update_btn", function(){
		var cno = $(this).parent().parent().find("input[name='cno']").val();
		console.log("click");
		draw_clinic_update_view(cno);
	});
	
	//직원 수정 popup에서 버튼 클릭
	$(".popup_clinic_update_submit_wrap > p").click(function(){
		var idx = $(this).index();
		if(idx == 0){
			var cno = $(".popup_clinic_update > input[name='cno']").val();
			var code_name = $(".popup_clinic_update > table tr > td > input[name='code_name']").val();
			var code_type = $(".popup_clinic_update > table tr > td > select[name='code_type']").val();
			var time = $(".popup_clinic_update > table tr > td > select[name='time']").val();
			var color = $(".popup_clinic_update > table tr > td > input[name='color']").val();
			
			if(code_name == ""){
				alert("코드명을 입력해주세요.");
				return false;
			}else if(color == ""){
				alert("색깔을 입력해주세요.");
				return false;
			}else{
				var vo = {cno:cno, code_name:code_name, code_type:code_type, time:time, color:color}
				
				post_clinic_update(vo);
			}
			
		}else{
			$(".popup_clinic_update").css("display", "none");
			$(".popup_wrap").css("display", "none");
		}
	});
	
});
</script>
</head>
<body>
	<div class="popup_wrap">
		<jsp:include page="../include/clinicPopup.jsp"></jsp:include>
	</div>
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside1">
				<div class="select_btn_wrap">
					<select name="searchType">
						<option value="ct" ${cri.searchType=='ct'?'selected':''}>코드분류</option>
						<option value="cn" ${cri.searchType=='cn'?'selected':''}>코드명</option>
						<option value="t" ${cri.searchType=='t'?'selected':''}>진행시간</option>
					</select> 
					<input type="text" name="keyword" id="keywordInput" value="">
					<button id="searchBtn">검색</button>
				</div><!-- select_btn_wrap -->
				<div class="clinic_register_btn_wrap">
					<button>코드추가</button>
				</div>
				<div class="table_wrap">
				
				</div><!-- table_wrap end -->
			</div>
		</div>
		<div class="footer">
		</div>
	</div>
</body>
</html>