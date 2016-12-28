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
				<h1>MY PAGE</h1>
				<div id="profile">
					<table>
						<tr>
							<td colspan="2" align="center">
								<c:choose>
									<c:when test="${sessionScope.memberInfo.mem_pic eq null || sessionScope.memberInfo.mem_pic eq ''}">
										<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" />
									</c:when>
									<c:otherwise>
										<img src="<c:url value="/member/${sessionScope.memberInfo.mem_pic}" />"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th align="center"><fmt:message key="friend.nick"/></th>
							<td id="profileInfo">${sessionScope.memberInfo.mem_nick}</td>
						</tr>
						<tr>
							<th align="center"><fmt:message key="friend.country"/></th>
							<td id="profileInfo">
							<c:if test="${sessionScope.memberInfo.mem_country==0}"><fmt:message key="friend.korea"/></c:if>
							<c:if test="${sessionScope.memberInfo.mem_country==1}">Foreigner</c:if>
							</td>
						</tr>
						<tr>
							<th align="center"><fmt:message key="friend.gender"/></th>
							<td id="profileInfo">
							<c:if test="${sessionScope.memberInfo.mem_gender==0}"><fmt:message key="friend.male"/></c:if>
							<c:if test="${sessionScope.memberInfo.mem_gender==1}"><fmt:message key="friend.female"/></c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center" id="profileInfo">${sessionScope.memberInfo.mem_email}</td>
						</tr>
					</table>
					<a onclick="location.href='/sjl/profile/${sessionScope.memberInfo.mem_no}/'"><fmt:message key="home.mypage"/></a>
					<a onclick="location.href='/sjl/profile/${sessionScope.memberInfo.mem_no}/'"><fmt:message key="home.friendlist"/></a>
				</div>
			</div>
		</fmt:bundle>
		</div>