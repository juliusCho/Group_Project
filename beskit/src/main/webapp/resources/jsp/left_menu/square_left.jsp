<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function() {
		$("#left_menu a").button();
		$("a").click(function(event) {
			event.preventDefault();
		});
	});
</script>
	<div id="sub_body">
		<div id="main_left" align="center">
		<fmt:bundle basename="${sessionScope.basename}">
			<div id="left_menu">
				<h1><fmt:message key="square.title"/></h1>
				<a onclick="location.href='/sjl/profile/${sessionScope.memberInfo.mem_no}/'"><fmt:message key="square.mypage"/></a>
				<a onclick="location.href='/sjl/friend/${sessionScope.memberInfo.mem_no}/'"><fmt:message key="square.friendlist"/></a>
			</div>
		</fmt:bundle>
		</div>