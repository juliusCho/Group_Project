<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 프로필 script -->
<%@ include file="/resources/jsp/script/friend_script.jsp" %>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>

<!-- 프로필 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/friend_left.jsp" %>

<!-- 회원정보페이지용 -->
<form name="confirm_pw_form" method="POST" action="../../user/${sessionScope.memberInfo.mem_no}/mypage">
<input type="hidden" name="mem_country" value="${sessionScope.memberInfo.mem_country}"/>
<input type="hidden" name="mem_gender" value="${sessionScope.memberInfo.mem_gender}"/>
<input type="hidden" name="mem_id" value="${sessionScope.memberInfo.mem_id}"/>
<input type="hidden" name="mem_pwquestion" value="${sessionScope.memberInfo.mem_pwquestion}"/>
<input type="hidden" name="mem_pwanswer" value="${sessionScope.memberInfo.mem_pwanswer}"/>
<input type="hidden" name="mem_name" value="${sessionScope.memberInfo.mem_name}"/>
<c:if test="${sessionScope.memberInfo.mem_country eq 0}">
	<input type="hidden" name="mem_phone" value="${sessionScope.memberInfo.mem_phone}"/>
</c:if>
<input type="hidden" name="mem_email" value="${sessionScope.memberInfo.mem_email}"/>
<input type="hidden" name="mem_nick" value="${sessionScope.memberInfo.mem_nick}"/>
<input type="hidden" name="mem_pic" value="${sessionScope.memberInfo.mem_pic}"/>
</form>

<!-- 친구목록 -->
	<div id="main_center">
	<fmt:bundle basename="${sessionScope.basename}">
		<div id="friend_wait_list" align="center">
		
<!--------------------------------친구 요청 목록 ----------------------------------->		
			<div id="wait_fri_tit" ><fmt:message key="friend.requestlist2"/></div>
			<c:if test="${waitingList !=null}">
			<table id="fri_list_table">
			<c:forEach var="vo" items="${waitingList}">
				<tr>
					<td id="fri_list_icon" align="center"><span class="ui-icon ui-icon-star"></span></td>
					<td id="fri_list_pic">
				  	    <a style="cursor:pointer;" onclick="location.href='../../profile/${vo.mem_no}/'">
							<c:choose>
							    <c:when test="${vo.mem_pic eq null || vo.mem_pic eq ''}">
							  	   	<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>">
							    </c:when>
							    <c:otherwise>
							   	    <img src="<c:url value="/member/${vo.mem_pic}"/> ">
							    </c:otherwise>
						    </c:choose>
				  	    </a>
					</td>
					<td id="fri_list_nick">
						<a style="cursor:pointer;" onclick="location.href='../../profile/${vo.mem_no}/'">${vo.mem_name}(${vo.mem_nick})</a>
					</td>	
					<td id="fri_select">
						<input class="ui-button ui-widget ui-corner-all" type="button" value="O" onclick="acceptFriend(${vo.mem_no});"/>
						<input class="ui-button ui-widget ui-corner-all" type="button" value="X" onclick="deleteWaitingFriendDirect(${vo.mem_no})"/><br/>
					</td>
				</tr>
			</c:forEach>
			</table>
			</c:if>
			
<!--------------------------------친구 목록 ----------------------------------->			
			<div id="my_fri_tit" ><fmt:message key="friend.friendlist2"/></div>
			<table id="fri_list_table">
			<c:forEach var="vo" items="${list}">
			<tr>
				<td id="fri_list_icon" align="center"><span class="ui-icon ui-icon-star"></span></td>
				<td id="fri_list_pic">
			  	    <a style="cursor:pointer;" onclick="location.href='../../profile/${vo.mem_no}/'">
					    <c:choose>
						    <c:when test="${vo.mem_pic eq null || vo.mem_pic eq ''}">
					  	   	   <img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>"/>
						    </c:when>
						    <c:otherwise>
						   	   <img src="<c:url value="/member/${vo.mem_pic}"/> ">
						    </c:otherwise>
					    </c:choose>
			  	    </a>
				</td>
				<td id="fri_list_nick">
					<a style="cursor:pointer;" onclick="location.href='../../profile/${vo.mem_no}/'">${vo.mem_name}(${vo.mem_nick})</a>
				</td>
				<td id="fri_select">
				</td> 
			</tr>
			</c:forEach>
			</table>
		</div>
	</fmt:bundle>
	</div>
<!-- 공통 우측메뉴 -->
<%@ include file="/resources/jsp/right_menu.jsp" %>		
		
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>