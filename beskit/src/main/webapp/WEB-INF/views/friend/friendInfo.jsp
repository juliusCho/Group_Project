<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.chain.sjl.member.MemberVO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"  src="../../../resources/js/jquery-3.1.1.js" ></script>
<script type="text/javascript">
function deleteFriend(){
	var value= confirm('<fmt:message key="friend.reallydelete"/>');
	if(value){
		$.ajax({
			method:'GET',
			url:'./deleteFriend',
			data:{fri_no:'${memberVO.mem_no}'}
		}).done(function(data){
			if(data==2){
				alert('<fmt:message key="friend.deletedone"/>');
				opener.location.href="./";
				self.close();
			}else{
				alert('<fmt:message key="friend.errorMsg"/>');
			}
		});	
	}else{
		return;
	}
	
}

function insertFriend(){
	var myNo=${sessionScope.memberInfo.mem_no};
	var friendNo=${memberVO.mem_no};
	
	if(myNo==friendNo){
		alert('<fmt:message key="friend.noSelfAdd"/>');
		return;
	}else{
		$.ajax({
			method:'GET',
			url:'./insertWaitingFriend',
			data:{waiting_fri_no:$('#waiting_fri_no').val()}
		}).done(function(data){
			if(data.msg=='<fmt:message key="friend.success"/>'){
				alert('<fmt:message key="friend.inputSuccess"/>');
				self.close();
			}else{
				alert(data.msg);
			}
		});		
	}
	
}
</script>
</head>
<body>
<input type="hidden" name="waiting_fri_no" id="waiting_fri_no" value="${memberVO.mem_no}"/>
<table border="1">
	<tr>
		<th width="200" height="250">
			<c:choose>
				<c:when test="${memberVO.mem_pic eq null || memberVO.mem_pic eq ''}">
					<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>"/>				
				</c:when>
				<c:otherwise>
					<img src="<c:url value="/member/${memberVO.mem_pic}"/>"/>
				</c:otherwise>
			</c:choose>
		</th>
	</tr>
	<tr>
		<td>${memberVO.mem_name}(${memberVO.mem_nick })</td>
	</tr>
	<tr>
		<td>${memberVO.mem_email}</td>
	</tr>
</table>
<input type="button" value="ADD" onclick="insertFriend();"/>
<input type="button" value="REMOVE" onclick="deleteFriend()"/>
</body>
</fmt:bundle>
</html>