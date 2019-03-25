<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	.header_wrap{
		width:100%;
		border-bottom:2px solid lightgray;
	}
	.header_div{
		width:95%;
		padding:20px 0;
		margin: 0 auto;
		overflow:hidden;
	}
	.header_inner1{
		float:left;
	}
	.header_inner2{
		float: right;
	}
	.header_inner, .header_inner > a{
		font-size: 15px;
	}
	.header_inner1 > a{
		font-weight:bold;
	}
	.header_inner2 > a{
		margin-right:15px;
	}
</style>
<script>
	$(function(){
		var session_id=$("#session_value").val();
		
		if(session_id == null || session_id == ""){
			location.replace("${pageContext.request.contextPath}/");
		}
	});
</script>
<div class="header_wrap">
	<input id="session_value" type="hidden" value="${sessionScope.id}">
	<div class="header_div">
		<c:if test="${sessionScope.id != null}">
			<div class="header_inner header_inner1">
				<a href="#none">${sessionScope.name}(${sessionScope.type})</a>님 반갑습니다.
			</div>
			<div class="header_inner header_inner2">
				<a href="${pageContext.request.contextPath}/">마이페이지</a>
				<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
			</div>
		</c:if>
	</div>
	
</div>