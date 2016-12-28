<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	if('${sessionScope.memberInfo}'!=''){
		$.ajax({
			method:'POST',
			url:'/sjl/member/newMessage',
			data:{mem_no:'${sessionScope.memberInfo.mem_no}'}
		}).done(function(data){
			document.getElementById('newMsg').innerHTML=data;
		});
	}
});
</script>
<body>
<fmt:bundle basename="${sessionScope.basename}">
<div id="sub_main">
      <table align="center" id="header_menu">
         <tr>
            <td align="left" width="350">
	            <a style="cursor:pointer;" onclick="location.href='/sjl/article/${sessionScope.memberInfo.mem_no}/'" id="head_menu_Font"><fmt:message key="header.home"/></a> | 
	            <a style="cursor:pointer;" onclick="location.href='/sjl/profile/${sessionScope.memberInfo.mem_no}/'" id="head_menu_Font"><fmt:message key="header.mypage"/></a> | 
	            <a style="cursor:pointer;" onclick="location.href='/sjl/square/${sessionScope.memberInfo.mem_no}/'" id="head_menu_Font"><fmt:message key="header.square"/></a>
            </td>
            <td align="center"><a style="cursor:pointer;" onclick="location.href='/sjl/article/${sessionScope.memberInfo.mem_no}/'"><img src="<c:url value="/resources/img/main/logo_head.jpg" />"></a></td>
            <td align="right" width="350">
	            <a style="cursor:pointer;" onclick="window.open('/sjl/friend/${sessionScope.memberInfo.mem_no}/findFriend', '_blank', 'width=400,height=300,toolbars=no,scrollbars=no'); return false;" id="head_menu_Font"><fmt:message key="header.findfriend"/></a> |
	            <a style="cursor:pointer;" onclick="location.href='/sjl/chatlist/${sessionScope.memberInfo.mem_no}/'" id="head_menu_Font"><fmt:message key="header.chatting"/>(<span style="color:#ff0084;" id="newMsg"></span>)</a> |
            	<c:if test="${sessionScope.memberInfo==null}">
            	<a style="cursor:pointer;" onclick="location.href='/sjl/'" id="head_logout_Font">LOGIN</a>
            	</c:if>
            	<c:if test="${sessionScope.memberInfo !=null}">
            	<a style="cursor:pointer;" onclick="location.href='/sjl/member/logout'" id="head_logout_Font">LOGOUT</a>
            	</c:if>
            </td>
         </tr>
      </table>
 </fmt:bundle>