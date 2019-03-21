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

</style>
<script>
	$(function(){
		$("#btn_login").click(function(){
			//alert("btn_login click!!");
			var userId= $("input[name='id']").val();
			var userPw= $("input[name='pw']").val();
			var user={
					id:userId,
					pw:userPw,
			};
			
			$.ajax({
				url:"${pageContext.request.contextPath}/login_idpw_check",
				type: "post",
				dataType:"text",
				data: user,
				success:function(json){
					console.log(json);
					if(json == 'ok'){
						location.href="${pageContext.request.contextPath}/sub_main";
					}else{
						alert("아이디와 비밀번호가 맞지 않습니다.");
						return false;
					}
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="bodyWrap">
		<div class="logo">
			<%-- <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/"></a> --%>
		</div>
		<div class="login_wrap">
			<ul>
				<li><input type="text" name="id" placeholder="아이디"></li>
				<li><input type="password" name="pw" placeholder="비밀번호"></li>
				<li id="btn_login">Login</li>
			</ul>
		</div>
	</div>
</body>
</html>