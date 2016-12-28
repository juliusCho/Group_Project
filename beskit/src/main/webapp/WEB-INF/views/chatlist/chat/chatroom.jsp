<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<c:set var="no" value="${chatListVO.cha_list_no}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/chat.css" />" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<script type="text/javascript">
function checkMateChatRoom(){
	$.ajax({
		method:'POST',
		url:'./checkMateChatRoom',
		data:{cha_list_no:'${chatListVO.cha_list_no}', mem_no:'${chatListVO.mem_no}', 
				mem_nick:'${chatListVO.mem_nick}', cha_mate_no:'${chatListVO.cha_mate_no}',
				mem_pic:'${chatListVO.mem_pic}'}
	});
}

function loadChat(){
	setTimeout("loadChat()", 1000);
	$.getJSON('./loadChat', function(data){	
		var items='';
		$.each(data,function(key,val){
			items+='';
			if(val['mem_no']=='${sessionScope.memberInfo.mem_no}'){
				items +='<div id="my_content">';
				items+= val['cha_content'] + '<br/>';
				items+='<div id="my_read_text">'+val['cha_regdate']+'</div>';
				if(val['cha_confirm']==1){
					items+='<div id="my_read_text">[<fmt:message key="chat.read"/>]</div>';
				}else{
					items+='<div id="my_read_text">[<fmt:message key="chat.noread"/>]</div>';
				}
				items+='</div>';
			}else{
				items +='<div id="your_content"> ' + val['cha_content'] +'</div><div id="your_read_text">'+val['cha_regdate']+'</div><br/>';
			}
		});	
		$('#display').html(items);
	});
}
	
function insertContent(){
		//checkMateChatRoom();
		$.ajax({
			method:'POST',
			url:'./insert',
			data:{cha_content:$('#cha_content').val(), cha_list_no:'${no}'}
		}).done(function(data){
			$('#cha_content').val('');
			loadChat();
		});
}

$(function(){
	$('#cha_content').keypress(function(e){
		if(e.which==13){
			$(this).blur();
			$('#insert_text').focus().click();
			$('#cha_content').focus();
		}
	});
});
 
window.onload= function(){
	loadChat();
}
</script>
</head>
<body id="chat_room_body">
	<div id="chat_title">${chatListVO.mem_nick}<fmt:message key="chat.title"/>
	</div>
	<div id="display"></div>
	<div id="insert_msg"> 
		<input type="hidden" value="${no}"/>
		<table id="text_box" style="width:100%;">
			<tr>
				<td>
					<textarea type="text" id="cha_content" style="width:100%; border:1px solid white; height:50px;" name="cha_content" required="required"></textarea>
				</td>
				<td style="width:60px;" align="center"><input id="insert_text" class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="chat.transmit"/>" onclick="insertContent();"/></td>
			</tr>
		</table>
	</div>
</body>
</fmt:bundle>
</html>