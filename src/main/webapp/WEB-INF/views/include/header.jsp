<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<c:if test="${sessionScope.id != null}">
		<a href="${pageContext.request.contextPath}/userInfo">${sessionScope.name}(${sessionScope.id})</a>님 반갑습니다.<br><br>
		<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
	</c:if>
</div>