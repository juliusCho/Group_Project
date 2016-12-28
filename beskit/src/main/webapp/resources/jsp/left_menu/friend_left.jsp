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
				<h1>FRIENDS</h1>
				<div id="profile">
					<c:choose>
						<c:when test="${sessionScope.memberInfo.mem_pic eq null || sessionScope.memberInfo.mem_pic eq ''}">
							<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" />
						</c:when>
						<c:otherwise>
							<img src="<c:url value="/member/${sessionScope.memberInfo.mem_pic}" />"/>
						</c:otherwise>
					</c:choose>
					<br />
					<c:if test="${sessionScope.memberInfo.mem_no==mem_no}"><fmt:message key="friend.nick"/>: <span id="profileInfo">${sessionScope.memberInfo.mem_nick}</span>
						<br />
						<c:if test="${sessionScope.memberInfo.mem_country==0}"><fmt:message key="friend.country"/>: <span id="profileInfo"><fmt:message key="friend.korea"/></span>
						<br />
						</c:if>
						<c:if test="${sessionScope.memberInfo.mem_country==1}"><fmt:message key="friend.country"/>: <span id="profileInfo">Foreigner</span>
						<br />
						</c:if>
						<c:if test="${sessionScope.memberInfo.mem_gender==0}"><fmt:message key="friend.gender"/>: <span id="profileInfo"><fmt:message key="friend.male"/></span>
						<br />
						</c:if>
						<c:if test="${sessionScope.memberInfo.mem_gender==1}"><fmt:message key="friend.gender"/>: <span id="profileInfo"><fmt:message key="friend.female"/></span>
						<br />
						</c:if>
						<span id="profileInfo">${sessionScope.memberInfo.mem_email}</span>
						<br />
					</c:if>
					<c:if test="${sessionScope.memberInfo.mem_no!=mem_no}"><fmt:message key="friend.nick"/>: <span id="profileInfo">${memberBasicInfo.mem_nick}</span>
						<br />
						<c:if test="${memberBasicInfo.mem_country==0}"><fmt:message key="friend.country"/>: <span id="profileInfo"><fmt:message key="friend.korea"/></span>
							<br />
						</c:if>
						<c:if test="${memberBasicInfo.mem_country==1}"><fmt:message key="friend.country"/>: <span id="profileInfo">Foreigner</span>
						<br />
						</c:if>
						<c:if test="${memberBasicInfo.mem_gender==0}"><fmt:message key="friend.gender"/>: <span id="profileInfo"><fmt:message key="friend.male"/></span>
						<br />
						</c:if>
						<c:if test="${memberBasicInfo.mem_gender==1}"><fmt:message key="friend.gender"/>: <span id="profileInfo"><fmt:message key="friend.female"/></span>
						<br />
						</c:if>
						<span id="profileInfo">${memberBasicInfo.mem_email}</span>
						<br/>
					</c:if>
				</div>
				<br/>
				<c:if test="${sessionScope.memberInfo.mem_no==mem_no}">
					<a onclick="location.href='/sjl/friend/${sessionScope.memberInfo.mem_no}/'"><fmt:message key="friend.friendlist"/></a>
					<a onclick="javascript:confirm_pw(${sessionScope.memberInfo.mem_no});"><fmt:message key="friend.changemem"/></a>
				</c:if>
				<c:if test="${sessionScope.memberInfo.mem_no!=mem_no}">
					<c:if test="${result == 0}">
						<li><input type="button" value="<fmt:message key="friend.addfriend"/>"
							onclick="insertFriend();" /></li>
						<br />
					</c:if>
					<c:if test="${result==1}">
						<li><input type="button" value="<fmt:message key="friend.delfriend"/>"
							onclick="deleteFriend();" /></li>
						<br />
					</c:if>
				</c:if>
				<c:if test="${sessionScope.memberInfo.mem_no!=mem_no}">
					<li><input type="button" value="<fmt:message key="friend.chatfriend"/>" onclick="startChat();" /></li>
				</c:if>
			</div>
		</fmt:bundle>
		</div>