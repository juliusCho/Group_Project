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
				<c:if test="${sessionScope.memberInfo.mem_no==mem_no}">
				<h1>MY PAGE</h1>
				
				<!--			 내프로필				 -->
				<div id="profile">
					<table>
						<tr>
							<td colspan="2" align="center">
								<c:choose>
									<c:when test="${memberBasicInfo.mem_pic eq null || memberBasicInfo.mem_pic eq ''}">
										<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" />
									</c:when>
									<c:otherwise>
										<img src="<c:url value="/member/${memberBasicInfo.mem_pic}" />"/>
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
						<c:if test="${waitingfriend !=0}">
						<tr>
							<td colspan="2" align="center">
								<span style="cursor:pointer;" onclick="location.href='/sjl/friend/${sessionScope.memberInfo.mem_no}/'">
									<fmt:message key="mypage.requestfriend"/> (<span style="font-size:15px; font-weight:bold; color:#ff0084;'">${waitingfriend}</span>)<fmt:message key="mypage.requesttime"/>
								</span>
							</td>
						</tr>
						</c:if>
					</table>
				</c:if>
				<c:if test="${sessionScope.memberInfo.mem_no!=mem_no}">
				<h1>MEMBER</h1>
				<!--			타인 프로필				 -->
				<div id="profile">
					<table>
						<tr>
							<td colspan="2" align="center">
								<c:choose>
									<c:when test="${memberBasicInfo.mem_pic eq null || memberBasicInfo.mem_pic eq ''}">
										<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" />
									</c:when>
									<c:otherwise>
										<img src="<c:url value="/member/${memberBasicInfo.mem_pic}" />"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th align="center"><fmt:message key="friend.nick"/></th>
							<td id="profileInfo">${memberBasicInfo.mem_nick}</td>
						</tr>
						<tr>
							<th align="center"><fmt:message key="friend.country"/></th>
							<td id="profileInfo">
							<c:if test="${memberBasicInfo.mem_country==0}"><fmt:message key="friend.korea"/></c:if>
							<c:if test="${memberBasicInfo.mem_country==1}">Foreigner</c:if>
							</td>
						</tr>
						<tr>
							<th align="center"><fmt:message key="friend.gender"/></th>
							<td id="profileInfo">
							<c:if test="${memberBasicInfo.mem_gender==0}"><fmt:message key="friend.male"/></c:if>
							<c:if test="${memberBasicInfo.mem_gender==1}"><fmt:message key="friend.female"/></c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">${memberBasicInfo.mem_email}</td>
						</tr>
					</c:if>
					</table>
				</div>
				
				<!--			 본인 프로필 일때 BUTTON			 -->
				<c:if test="${sessionScope.memberInfo.mem_no==mem_no}">
					<a onclick="location.href='/sjl/friend/${sessionScope.memberInfo.mem_no}/'"><fmt:message key="friend.friendlist"/></a>
					<a onclick="javascript:confirm_pw(${sessionScope.memberInfo.mem_no});"><fmt:message key="friend.changemem"/></a>
				</c:if>
				
				<!--			타인 프로필 일때 BUTTON 			 -->
				<c:if test="${sessionScope.memberInfo.mem_no!=mem_no}">
					<c:if test="${result == 0}">
						<c:if test="${checkwaitingfriend==0}">
							<a onclick="insertFriend();"><fmt:message key="friend.addfriend"/></a>
						</c:if>
						<c:if test="${checkwaitingfriend==1}">
							<a onclick="acceptFriend(${memberBasicInfo.mem_no});"><fmt:message key="mypage.acceptfriend"/></a>
							<a onclick="deleteWaitingFriendDirect(${memberBasicInfo.mem_no});"><fmt:message key="mypage.rejectfriend"/></a>
						</c:if>
					</c:if>
					<c:if test="${result==1}">
						<a onclick="deleteFriend();"><fmt:message key="friend.delfriend"/></a>
					</c:if>
				</c:if>
				<c:if test="${sessionScope.memberInfo.mem_no!=mem_no}">
					<a onclick="startChat();"><fmt:message key="friend.chatfriend"/></a>
				</c:if>
			</div>
		</fmt:bundle>
		</div>