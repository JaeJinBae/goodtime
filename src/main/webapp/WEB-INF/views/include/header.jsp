<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	.header_wrap{
		width:100%;
		background: #353c46;
		/* border-bottom:2px solid lightgray; */
	}
	.header_div{
		width:95%;
		/* padding:20px 0; */
		margin: 0 auto;
		overflow:hidden;
	}
	.header_inner1{
		float:left;
	}
	.header_inner2{
		float:left;
		margin-left:80px;
	}
	.header_inner3{
		float: right;
	}
	.header_inner, .header_inner > a{
		font-size: 15px;
	}
	.header_inner1 > a{
		font-weight:bold;
		color: #fff;
		font-size:20px;
		line-height: 62px;
		letter-spacing: 24px;
	}
	.header_inner2 > ul{
		overflow: hidden;
	}
	.header_inner2 > ul > li{
		float: left;
		line-height:62px;
		padding: 0 15px;
	}
	.header_inner2 > ul > li > a{
		color: #fff;
		font-size:17px;
	}
	#reservation_view_btn{
		display:none;
	}
	.header_inner3 > ul{
		text-align: center;
	}
	.header_inner3 > ul > li{
		font-size:15px;
		color: #fff;
		line-height: 30px;
	}
	.header_inner3 > ul > li > span{
		/* font-weight: bold; */
	}
	.header_inner3 > ul > li > a{
		color: #fff;	
	}
	.header_inner3 > ul > li > a > img{
		width: 20px;
		vertical-align: text-bottom;
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
	<input id="session_eno" type="hidden" value="${sessionScope.eno}">
	<input id="session_login_name" type="hidden" value="${sessionScope.name}">
	<div class="header_div">
		<c:if test="${sessionScope.id != null}">
			<div class="header_inner header_inner1">
				<%-- <a href="#none">${sessionScope.name}(${sessionScope.type})</a>님 반갑습니다. --%>
				<a href="${pageContext.request.contextPath}/sub_main">LOGO</a>
			</div>
			<div class="header_inner header_inner2">
				<ul>
					<li><a href="${pageContext.request.contextPath}/sub_main">예약관리</a></li>
					<li><a href="${pageContext.request.contextPath}/employeeView">직원관리</a></li>
					<li><a href="${pageContext.request.contextPath}/clinicView">코드관리</a></li>
					<li><a href="${pageContext.request.contextPath}/hospitalInfo">병원시간관리</a></li>
					<li><a href="${pageContext.request.contextPath}/statistic">통계관리</a></li>
					<li><a href="${pageContext.request.contextPath}/">홈페이지</a></li>
				</ul>
			</div>
			<div class="header_inner header_inner3">
				<ul>
					<li><span>${sessionScope.name}(${sessionScope.type})</span>님 반갑습니다.</li>
					<li><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/icon_info_white.png"> MyPage</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/logout"><img src="${pageContext.request.contextPath}/resources/images/icon_logout_white.png"> Logout</a></li>
				</ul>
			</div>
		</c:if>
	</div>
	
</div>