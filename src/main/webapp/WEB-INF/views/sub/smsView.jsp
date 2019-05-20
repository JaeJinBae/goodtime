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
	.header_inner2 > ul > li:nth-child(5){
		background: #fff;
	}
	.header_inner2 > ul > li:nth-child(5) > a{
		color: #5c5c5c; 
		font-weight: bold;
	}
	.aside1{
		width:1000px;
		margin-left:50px;
		margin-top:50px;
		overflow:hidden;
	}
	.aside_title{
		width: 100%;
		margin-bottom: 50px;
	}
	.aside_title > img {
		width:30px;
		vertical-align: middle;
	}
	.aside_title > span{
		font-size:22px;
		font-weight: bold;
		margin: 0 30px 0 5px;
		vertical-align: middle;
	}
	.aside_title > .line{
		width:600px;
		height:3px;
		background: #353c46;
		display: inline-block;
		vertical-align: middle;
	}
	.formWrap{
		width: 100%;
		padding-left: 80px;
	}
	.templateWrap{
		width: 100%;
		margin-bottom: 60px;
	}
	.templateWrap > h4{
		
	}
	.templateWrap > h4 > button{
		font-size: 15px;
		padding: 5px 10px;
		background: #1e866a;
		color: #fff;
		border-radius: 5px;
		margin-left: 345px;
	}
	.tempTitle{
		width: 100%;
		overflow: hidden;
	}
	.tempTitle > p{
		width: 230px;
		float:left;
		font-size: 15px;
		text-align: center;
		/* font-weight: bold; */
		margin-right: 15px;
		padding: 15px;
	}
	.templateWrap > ul{
		width: 100%;
		overflow: hidden;
	}
	.templateWrap > ul > li{
		width: 230px;
		height: 411px;
		float:left;
		margin-right: 15px;
		background: url("${pageContext.request.contextPath}/resources/images/icon_phoneFrame.png") no-repeat;
		background-size: contain;
	}
	.templateWrap > ul > li > textarea {
		display: block;
		width: 206px;
		height: 280px;
		margin: 0 auto;
		margin-top: 39px;
		padding: 5px;
		font-size: 14px;
		resize: none;
		scroll-x: none;
	}
	.templateWrap > ul > li > p{
		width: 206px;
		font-size: 14px;
		background: #fff;
		margin: 0 auto;
		padding: 6px 20px;
		text-align: right;
	}
	
	
	
</style>
<script>
function post_smsTamplate_update(vo){
	console.log(vo);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/smsUpdate",
		type:"post",
		dataType:"text",
		data:vo,
		async:false,
		success:function(json){
			alert("문자 탬플릿이 변경되었습니다.");
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function getTextLength(str) {
	var len = 0;

	for (var i = 0; i < str.length; i++) {
		if (escape(str.charAt(i)).length == 6) {
			len++;
		}
		len++;
	}
	return len;
}

function bytesHandler(obj){
	var text = $(obj).val();
	var numByte = getTextLength(text)
	$(obj).parent().find("p > span").text(numByte);
	$(obj).parent().parent().find(".preview").parent().find("p > span").text(numByte);
}

$(function(){
	
	//진료, 치료 저장내용 byte 표기
	for(var i=1; i<3; i++){
		var obj = $(".templateWrap:nth-child("+i+") > ul > li > textarea");
		var objText = obj.text();
		objText = objText.replace("[병원명]","ABCD병원");
		objText = objText.replace("[환자명]","홍길동");
		objText = objText.replace("[진료명]","초진");
		objText = objText.replace("[예약날짜]","2019-01-01");
		objText = objText.replace("[시작시간]","14:50");
		
		$(obj).parent().parent().find(".preview").html(objText);
		bytesHandler(obj);
	}
	
	//키 누를때마다 byte값, 미리보기 내용과 byte 값 변경 
	$('.templateWrap > ul > li > textarea').keyup(function(){
		var text = $(this).val();
		text = text.replace("[병원명]","ABCD병원");
		text = text.replace("[환자명]","홍길동");
		text = text.replace("[진료명]","초진");
		text = text.replace("[예약날짜]","2019-01-01");
		text = text.replace("[시작시간]","14:50");
		
		$(this).parent().parent().find(".preview").html(text);
		bytesHandler(this);
	});
	
	
	
	//문자 탬플릿 변경
	$(".templateWrap > h4 > button").click(function(){
		var num = $(this).parent().find("input[name='no']").val();
		var content = "";
		if(num == 1){
			content = $(".templateWrap:nth-child(1) > ul > li > textarea").val();
		}else{
			content = $(".templateWrap:nth-child(2) > ul > li > textarea").val();
		}
		var vo = {no:num, content:content};
		post_smsTamplate_update(vo);
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
				<div class="aside_title">
					<img src="${pageContext.request.contextPath}/resources/images/icon_wheel.png">
					<span>문자관리</span>
					<div class="line"></div> 
				</div>
				<div class="formWrap">
					<div class="templateWrap">
						<h4>진료예약<input type="hidden" name="no" value="1"> <button>저 장</button></h4>
						<div class="tempTitle">
							<p>-탬플릿-</p>
							<p>-미리보기-</p>
						</div>
						<ul>
							<li>
								<textarea>${smsClinic.content}</textarea>
								<p><span>0</span>/2000 Byte</p>
							</li>
							<li>
								<textarea class="preview" readonly></textarea>
								<p><span>0</span>/2000 Byte</p>
							</li>
						</ul>
					</div><!-- templateWrap end -->
					<div class="templateWrap">
						<h4>치료예약<input type="hidden" name="no" value="2"> <button>저 장</button></h4>
						<div class="tempTitle">
							<p>-탬플릿-</p>
							<p>-미리보기-</p>
						</div>
						<ul>
							<li>
								<textarea>${smsTherapy.content}</textarea>
								<p><span>195</span>/2000 Byte</p>
							</li>
							<li>
								<textarea class="preview" readonly></textarea>
								<p><span>195</span>/2000 Byte</p>
							</li>
						</ul>
					</div><!-- templateWrap end -->
				</div><!-- table_wrap end -->
			</div>
		</div>
		<div class="footer">
		</div>
	</div>
</body>
</html>