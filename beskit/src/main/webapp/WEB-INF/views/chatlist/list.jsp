<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 리스트 스크립트 -->
<%@ include file="/resources/jsp/script/chat_script.jsp" %>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>

<!-- 리스트 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/chat_left.jsp" %>

<!-- 리스트  -->
	<div id="main_center">
	<fmt:bundle basename="${sessionScope.basename}">
		<div id="chat_list_body" align="center">
			<div id="chatList_text" ><fmt:message key="chat.list"/></div>
			<table id="chat_list_table">
				<c:forEach var="vo" items="${list}">
				<form id="${vo.cha_mate_no}">
					<input type="hidden" name="cha_list_no" value="${vo.cha_list_no}"/>
					<input type="hidden" name="cha_mate_no" value="${vo.cha_mate_no}"/>
					<input type="hidden" name="mem_nick" value="${vo.mem_nick}"/>
					<input type="hidden"name="mem_pic" value="${vo.mem_pic}"/>
				</form>
				<tr>
					<td id="chat_list_icon" align="center"><span class="ui-icon ui-icon-star"></span></td>
					<td id="chat_list_pic">
					    <c:choose>
						    <c:when test="${vo.mem_pic eq null || vo.mem_pic eq ''}">
						  	   <img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>"/>
						    </c:when>
						    <c:otherwise>
						   	   <img src="<c:url value="/member/${vo.mem_pic}"/> ">
						    </c:otherwise>
					    </c:choose>
					</td>
					<td id="chat_list_nick">
						<div id="chat_nick">${vo.mem_nick}</div>
	 					<c:if test="${vo.newmsg !=0}">
						<div id="chat_newmsg" align="center">${vo.newmsg}</div>
	 					</c:if>
						<div id="chat_regdate">${vo.cha_list_regdate}</div>
					</td>
					<td id="chat_list_start" align="center">
						<input id="chat_start" class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="chat.startChat"/>" onclick="openChatRoom('${vo.cha_list_no}','${vo.cha_mate_no}','${vo.mem_nick}','${vo.mem_pic}');"/><br/>
						<input id="chat_del" class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="chat.deleteChat"/>" onclick="removeChatRoom('${vo.cha_mate_no}');">
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
