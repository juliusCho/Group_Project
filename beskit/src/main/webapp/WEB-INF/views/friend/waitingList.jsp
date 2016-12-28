<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"  src="../../resources/js/jquery-3.1.1.js" ></script>
<script type="text/javascript">

function deleteWaitingFriendDirect(waiting_fri_no){
	var value = confirm('<fmt:message key="friend.rejectReally"/>');
	if(value){
		$.ajax({
			method:'GET',
			url:'deleteWaitingFriend',
			data:{waiting_fri_no:waiting_fri_no}
		}).done(function(data){
			alert('<fmt:message key="friend.rejectDone"/>');
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
</head>
<body>
<fmt:message key="friend.requestlist"/>
<c:if test="${list !=null}">
<table>
<c:forEach var="vo" items="${list}">
<tr>
	<td width="200">
		${vo.mem_name}(${vo.mem_nick})
	</td>	
	<td>
		<input type="button" value="O" onclick="acceptFriend(${vo.mem_no});"/>
		<input type="button" value="X" onclick="deleteWaitingFriendDirect(${vo.mem_no})"/><br/>
	</td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</fmt:bundle>
</html>