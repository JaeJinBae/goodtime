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
	
	.all_wrap{
		width:100%;
		text-align:center;
		font-size:20px;
	}
	.header{
		width:100%;
		height:60px;
		background: #353c46;
	}
	.section{
		width: 300px;
		position: absolute;
		left:50%;
		top: 50%;
		margin-left: -150px;
		margin-top: -350px; 
	}
	.logo{
		width:300px;
		margin: 0 auto;
	}
	.logo > a{
		width:100%;
	}
	.logo > a > img{
		width:100%;
	}
	.login_wrap{
		width:250px;
		margin: 0 auto;
		margin-top: 50px;
	}
	.login_wrap > ul{
		width: 100%;
	}
	.login_wrap > ul > li{
		width:100%;
	}
	.login_wrap > ul > li > input {
		width:100%;
		font-size:18px;
		letter-spacing: 1px;
		padding: 10px;
		font-weight: bold;
		margin-bottom:5px;
	}
	.login_wrap > ul > li:last-child{
		margin-top:20px;
		font-size: 18px;
		font-weight: bold;
		padding: 10px 0;
		border: 1px solid lightgray; 
		letter-spacing: 2px;
		cursor: pointer;
	}
	#btn_login{
		background: #efefef; 
	}
	.footer{
		width:100%;
		height:60px;
		position: absolute;
		bottom: 0;
		background: #353c46;
	}
</style>
<script>
	$(function(){
		$("#btn_login").click(function(){
			login();
		});
		
		$("#pw_input").keyup(function(e){
			if(e.keyCode == 13){
				login();
			}
		});
		
		
		function login(){
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
					if(json == 'therapist'){
						location.href="${pageContext.request.contextPath}/therapist";
					}else if(json == "manager" || json == "doctor"){
						location.href="${pageContext.request.contextPath}/sub_main";
					}else{
						alert("아이디와 비밀번호가 맞지 않습니다.");
						return false;
					}
				}
			});
		}
	});
</script>
</head>
<body>
	<div class="all_wrap">
		<div class="header">
		</div>
		<div class="section">
			<div class="logo">
				<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/oneLogo.PNG"></a>
			</div>
			<div class="login_wrap">
				<ul>
					<li><input type="text" name="id" placeholder="아이디"></li>
					<li><input id="pw_input" type="password" name="pw" placeholder="비밀번호"></li>
					<li id="btn_login">Login</li>
				</ul>
			</div>
		</div><!-- section end -->
		<div class="footer">
		</div>
	</div><!-- all_wrap end -->
</body>
</html>