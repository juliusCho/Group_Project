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
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/chat.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<fmt:bundle basename="${sessionScope.basename}">
<script type="text/javascript">
function startChat(cha_list_no, cha_mate_no, mem_nick, mem_pic){
	$.ajax({
		method:'POST',
		url:'../../chatlist/${sessionScope.memberInfo.mem_no}/insert',
		data:{mem_no:'${sessionScope.memberInfo.mem_no}', mem_nick:mem_nick, cha_mate_no:cha_mate_no, mem_pic:mem_pic}
	}).done(function (data){
		if(data!==''){
		}else{
			alert('에러발생입니다');
		}
	}); 
} 

function openChatRoom(cha_list_no, cha_mate_no, mem_nick, mem_pic){
	startChat(cha_list_no, cha_mate_no, mem_nick, mem_pic);
	
	var myForm = document.getElementById(cha_mate_no);
	var title = 'popForm';
	var url ='../../chat/${sessionScope.memberInfo.mem_no}/'+cha_list_no+'/';
		window.open('' ,title, 
			 'toolbar=no,location=no,status=no,menubar=no,scrollbar=yes,resizable=no,width=400,height=600'); 
	 	myForm.action =url;
	 	myForm.method='post';
	 	myForm.target=title;
	 	myForm.cha_list_no.value=cha_list_no;
	 	myForm.cha_mate_no.value=cha_mate_no;
	 	myForm.mem_nick.value=mem_nick;
	 	myForm.mem_pic.value=mem_pic;
		myForm.submit();
	/*var settings ='toolbar=no,location=no,status=no,menubar=no,scrollbar=yes,' +
	 'resizable=no,width=400,height=600';
	var path = window.open('../../chat/${sessionScope.memberInfo.mem_no}/'+cha_list_no+'/?mem_nick='+mem_nick,'',settings);*/	
	
}
function updateConfirm(cha_mate_no){
	$.ajax({
		method:'GET',
		url:'./updateConfirm',
		data:{cha_mate_no:cha_mate_no}
	}).done(function(){});	
}

function removeChatRoom(cha_mate_no){
	if(confirm('정말로 삭제하시겠습니까?')){
		updateConfirm(cha_mate_no);
		
		$.ajax({
			method:'GET',
			url:'./removeChatRoom',
			data:{cha_mate_no:cha_mate_no}
		}).done(function(){
			location.href='./';
		});
	}else{
		return;
	}
}
</script>
</fmt:bundle>
</head>