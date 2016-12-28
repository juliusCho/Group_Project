<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="vo" value="${memberVO}"/>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeSkit</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_other.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<fmt:bundle basename="${sessionScope.basename}">
<script type="text/javascript">
function leaveAccount(){
	if(document.getElementById('agree').checked){
		$.ajax({
			method:'POST',
			url:'leave',
			data:{mem_no:'${vo.mem_no}'}
		}).done(function(){
			alert('<fmt:message key="user.leaveDoneMsg"/>');
			location.href='../../';
		});
	}else{
		alert('<fmt:message key="user.leaveCheckMsg"/>');
	}
}

</script>
</fmt:bundle>
</head>
<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>
<!-- 리스트  -->
   <div id="main_center" align="center" style="width:1000px;">
   <fmt:bundle basename="${sessionScope.basename}">
		<div align="left" id="leave_body" >
			<div id="leave_tit" align="center">
				<h1><fmt:message key="user.leaveInfo"/></h1>
			</div>
			<div id="leave_notice">
				<span>${vo.mem_name}<fmt:message key="user.leavePolicy1"/>
				<br/><br/><br/>
				<fmt:message key="user.leavePolicy2"/>${vo.mem_id})<fmt:message key="user.leavePolicy2"/></span>
				<br/>
				
				<strong><span style="color: red"><fmt:message key="user.leavePolicy3"/></span></strong>
				<fmt:message key="user.leavePolicy4"/><br/><fmt:message key="user.leavePolicy5"/>
				<br/><br/>
				<strong><span><fmt:message key="user.leavePolicy6"/></span></strong>
				<br/>
				
				<span><fmt:message key="user.leavePolicy7"/><br/><fmt:message key="user.leavePolicy8"/><br/>
				<fmt:message key="user.leavePolicy9"/></span>
				<br/><br/>
				
				<strong><span style="color: red"><fmt:message key="user.leavePolicy10"/>${vo.mem_id}<fmt:message key="user.leavePolicy11"/><br/><fmt:message key="user.leavePolicy12"/></span></strong>
				<br/><br/>
				<input type="checkbox" id="agree"/> <strong><fmt:message key="user.leavePolicy13"/></strong>
				</br>
				<input class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="user.check"/>" onclick="leaveAccount()"/>
			</div>
		</div>
	</fmt:bundle>
	</div>
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>