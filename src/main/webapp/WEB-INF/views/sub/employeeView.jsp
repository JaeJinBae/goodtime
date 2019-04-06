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
	.employee_register_btn_wrap{
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
function get_employee_all(info){
	var dt;
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeAllGet",
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

function draw_employee_table(info){
	var json = get_employee_all(info);
	
	var str = "";

	$(".aside1 > .table_wrap").empty();
	
	str ="<table><tr><th></th><th>이름</th><th><p class='employee_table_update_btn'>설정</p></th><th>직원등급</th><th>생년월일</th><th>연락처</th><th>ID</th><th>메모</th></tr>";
	
	if(json.employeeListAll.length == 0){
		str += "<tr><td colspan='8'>등록된 회원이 없습니다.</td></tr>";
	}else{
		$(json.employeeListAll).each(function(){
			str += "<tr><td><input type='hidden' name='eno' value='"+this.eno+"'></td><td>"+this.name+"</td><td><p class='employee_update_btn'>수정</p></td>"
				+"<td>"+this.type+"</td><td>"+this.birth+"</td><td>"+this.phone+"</td><td>"+this.id+"</td><td>"+this.memo+"</td>";
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


function get_employee_by_eno(eno){
	var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeGetByEno/"+eno,
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
function draw_employee_update_view(eno){
	var json = get_employee_by_eno(eno);
	
	$(".popup_employee_update > input[name='eno']").val(json.eno);
	$(".popup_employee_update > table tr td > input[name='name']").val(json.name);
	$(".popup_employee_update > table tr td > input[name='phone']").val(json.phone);
	$(".popup_employee_update > table tr td > select[name='type'] option[value='"+json.type+"']").prop("selected", true);
	$(".popup_employee_update > table tr td > select[name='level'] option[value='"+json.level+"']").prop("selected", true);
	$(".popup_employee_update > table tr td > input[name='id']").val(json.id);
	$(".popup_employee_update > table tr td > input[name='birth']").val(json.birth);
	$(".popup_employee_update > table tr td > input[name='mail']").val(json.mail);
	$(".popup_employee_update > table tr td > select[name='gender'] option[value='"+json.gender+"']").prop("selected", true);
	$(".popup_employee_update > table tr td > input[name='memo']").val(json.memo);
	
	$(".popup_wrap").css("display","block");
	$(".popup_employee_update").css("display", "block");
}

function post_employee_register(vo){
	console.log(vo);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeRegister",
		type:"post",
		dataType:"text",
		data:vo,
		async:false,
		success:function(json){
			$(".popup_employee_register").css("display", "none");
			$(".popup_wrap").css("display","none");
			alert("직원등록이 완료되었습니다.");
			draw_employee_table();
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function post_employee_update(employee){
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeUpdate",
		type:"post",
		dataType:"text",
		data:employee,
		async:false,
		success:function(json){
			$(".popup_employee_update").css("display", "none");
			$(".popup_wrap").css("display","none");
			draw_employee_table();
		}
	});
}

function id_duplication_check(id){
var dt;
	
	$.ajax({
		url:"${pageContext.request.contextPath}/employeeIdCheck/"+id,
		type:"get",
		dataType:"text",
		async:false,
		success:function(json){
			dt = json;
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	}) 
	return dt;
}

$(function(){
	draw_employee_table();
	
	//직원 검색
	$("#searchBtn").click(function(){
    	var s=$("select[name='searchType']").val();
		var searchType = encodeURIComponent(s);
		var k=$("input[name='keyword']").val();
		var keyword = encodeURIComponent(k);
		draw_employee_table("page=1&perPageNum=10&searchType="+searchType+"&keyword="+keyword);
	});
	
	//직원table에서 페이지 클릭
	$(document).on("click", ".page > ul > li > a", function(e){
		e.preventDefault();
		draw_employee_table($(this).attr("href"));
	});
	
	//직원추가 버튼 클릭
	$(".employee_register_btn_wrap > button").click(function(){
		$(".popup_wrap").css("display", "block");
		$(".popup_employee_register").css("display", "block");
	});
		
	//직원 등록popup에서 버튼 클릭
	$(".popup_employee_register_submit_wrap > p").click(function(){
		var idx = $(this).index();
		if(idx == 0){
			var eno = "0";
			var name = $(".popup_employee_register > table tr > td > input[name='name']").val();
			var phone = $(".popup_employee_register > table tr > td > input[name='phone']").val();
			var type = $(".popup_employee_register > table tr > td > select[name='type']").val();
			var level = $(".popup_employee_register > table tr > td > select[name='level']").val();
			var id = $(".popup_employee_register > table tr > td > input[name='id']").val();
			var pw = $(".popup_employee_register > table tr > td > input[name='pw']").val();
			var birth = $(".popup_employee_register > table tr > td > input[name='birth']").val();
			var mail = $(".popup_employee_register > table tr > td > input[name='mail']").val();
			var gender = $(".popup_employee_register > table tr > td > select[name='gender']").val();
			var memo = $(".popup_employee_register > table tr > td > input[name='memo']").val();
			
			var vo = {eno:eno, name:name, phone:phone, type:type, level:level, id:id, pw:pw, birth:birth, mail:mail, gender:gender, memo:memo, offday_fix:"", offday_normal:""}
			
			post_employee_register(vo);
		}else{
			$(".popup_employee_register").css("display", "none");
			$(".popup_wrap").css("display", "none");
		}
	});
	
	//id 중복확인
	$(".id_duplication_check_btn").click(function(){
		var id=$(this).parent().find("input[name='id']").val();
		
		var id_duplication = id_duplication_check(id);

		$(this).parent().find("input[name='id_check']").val(id_duplication);
		if(id_duplication == "ok"){
			alert("사용가능한 아이디입니다.");
		}else{
			alert("이미 존재하는 아이디입니다.");
		}
	});
	
	//직원 수정버튼 클릭
	$(".employee_update_btn").click(function(){
		var eno = $(this).parent().parent().find("input[name='eno']").val();
		console.log("click");
		draw_employee_update_view(eno);
	})
	
	//직원 수정 popup에서 버튼 클릭
	$(".popup_employee_update_submit_wrap > p").click(function(){
		var idx = $(this).index();
		if(idx == 0){
			var eno = $(".popup_employee_update > input[name='eno']").val();
			var name = $(".popup_employee_update > table tr > td > input[name='name']").val();
			var phone = $(".popup_employee_update > table tr > td > input[name='phone']").val();
			var type = $(".popup_employee_update > table tr > td > select[name='type']").val();
			var level = $(".popup_employee_update > table tr > td > select[name='level']").val();
			var id = $(".popup_employee_update > table tr > td > input[name='id']").val();
			var pw = $(".popup_employee_update > table tr > td > input[name='pw']").val();
			var pw_confirm = $(".popup_employee_update > table tr > td > input[name='pwconfirm']").val();
			var birth = $(".popup_employee_update > table tr > td > input[name='birth']").val();
			var mail = $(".popup_employee_update > table tr > td > input[name='mail']").val();
			var gender = $(".popup_employee_update > table tr > td > select[name='gender']").val();
			var memo = $(".popup_employee_update > table tr > td > input[name='memo']").val();
			
			var vo = {eno:eno, name:name, phone:phone, type:type, level:level, id:id, pw:pw, birth:birth, mail:mail, gender:gender, memo:memo, offday_fix:"", offday_normal:""}
			
			post_employee_update(vo);
		}else{
			$(".popup_employee_update").css("display", "none");
			$(".popup_wrap").css("display", "none");
		}
	});
	
});
</script>
</head>
<body>
	<div class="popup_wrap">
		<jsp:include page="../include/employeePopup.jsp"></jsp:include>
	</div>
	<div class="all_wrap">
		<div class="header">
			<jsp:include page="../include/header.jsp"></jsp:include>
		</div>
		<div class="section">
			<div class="aside1">
				<div class="select_btn_wrap">
					<select name="searchType">
						<option value="name" ${cri.searchType=='t'?'selected':''}>이름</option>
						<option value="id" ${cri.searchType=='c'?'selected':''}>ID</option>
						<option value="phone" ${cri.searchType=='c'?'selected':''}>연락처</option>
					</select> 
					<input type="text" name="keyword" id="keywordInput" value="">
					<button id="searchBtn">검색</button>
				</div><!-- select_btn_wrap -->
				<div class="employee_register_btn_wrap">
					<button>직원추가</button>
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