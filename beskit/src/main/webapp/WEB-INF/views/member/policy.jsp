<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>
<!-- 리스트  -->
   <div id="main_center" align="center" style="width:1000px;">
   <fmt:bundle basename="${sessionScope.basename}">
		<div align="left" id="leave_body" >
			<div id="leave_tit" align="center">
				<h1>BeSkit <fmt:message key="join.policytitle"/></h1>
			</div>
			<br/>
			<div id="leave_notice" align="center">
				<strong><span><fmt:message key="join.policycontent"/></span></strong>
				<br/><br/>
				<input class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="join.backBtn"/>" onclick="javascript:history.back();"/>
			</div>
		</div>
	</fmt:bundle>
	</div>
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>