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
<%@ include file="/resources/jsp/script/add_friend.jsp" %>
<fmt:bundle basename="${sessionScope.basename}">
<script type="text/javascript">

//왼쪽메뉴 제어
function confirm_pw(mem_no){
	window.open('../../user/' + mem_no + '/confirm_pw','','toolbar=no,location=no,status=no,menubar=no,scrollbar=yes,' +
	'resizable=no,width=400,height=120')
}


function deleteWaitingFriendDirect(waiting_fri_no){
	var value = confirm('<fmt:message key="friend.rejectMsg"/>');
	if(value){
		$.ajax({
			method:'GET',
			url:'deleteWaitingFriend',
			data:{waiting_fri_no:waiting_fri_no}
		}).done(function(data){
			alert('<fmt:message key="friend.rejectComplete"/>');
			location.href="../../profile/"+${sessionScope.memberInfo.mem_no}+"/";
		});
	}else{
		return;
	}	
}

function deleteWaitingFriend(waiting_fri_no){
	$.ajax({
		method:'GET',
		url:'deleteWaitingFriend',
		data:{waiting_fri_no:waiting_fri_no}
	}).done(function(data){
	});
}

function acceptFriend(waiting_fri_no){
 	$.ajax({
		method:'GET',
		url:'acceptFriend',
		data:{waiting_fri_no:waiting_fri_no}
	}).done(function(data){
		if(data==2){
			alert('<fmt:message key="friend.success"/>');
			deleteWaitingFriend(waiting_fri_no);
			location.href="../../profile/"+${sessionScope.memberInfo.mem_no}+"/";
		}else{
			alert('<fmt:message key="friend.fail"/>');
		}
	}); 
}
</script>
</fmt:bundle>
</head>
