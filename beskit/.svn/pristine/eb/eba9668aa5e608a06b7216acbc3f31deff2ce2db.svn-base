<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.png"/>
<script src="<c:url value="/resources/js/jquery-3.1.1.js"/>"></script>
<script>
	var sec = 6;

	$(function() {
		$('#timer').html(sec);
		timerStart();
	})
	
	function timerStart() {
		setTimeout('timerStart()', 1000);
		sec--;
		$(document).ready(function() {
			$('#timer').html(sec);
		});
		
		if(sec == 0) {
			history.back();
		}
	}
</script>
</head>
<body align="center">
<fmt:bundle basename="${sessionScope.basename}">
<h1><fmt:message key="exception.msg1"/><br/>
<span id="timer" style="color:red;"></span><fmt:message key="exception.msg2"/></h1>
<input type="button" value="<fmt:message key="exception.msg3"/>" onclick="javascript:history.back();"/>
</fmt:bundle>
</body>
</html>