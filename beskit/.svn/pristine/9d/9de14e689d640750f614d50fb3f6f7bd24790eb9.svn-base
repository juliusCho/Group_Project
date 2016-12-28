<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 회원가입 스크립트 -->
<%@ include file="/resources/jsp/script/join_script.jsp"%>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp"%>

<!-- 회원가입 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/join_left.jsp"%>

<!-- 회원가입 출력 -->
	<div id="main_center">
	<fmt:bundle basename="${sessionScope.basename}">
		<form method="post" action="joinFinal">
			<input type="hidden" name="mem_country" value="${memberVO.mem_country}"/>
			<input type="hidden" name="mem_gender" value="${memberVO.mem_gender}"/>
			<input type="hidden" name="mem_id" value="${memberVO.mem_id}"/>
			<input type="hidden" name="mem_pw" value="${pw}"/>
			<input type="hidden" name="mem_pwquestion" value="${memberVO.mem_pwquestion}"/>
			<input type="hidden" name="mem_pwanswer" value="${memberVO.mem_pwanswer}"/>
			<input type="hidden" name="mem_name" value="${memberVO.mem_name}"/>

			<c:choose>
				<c:when test="${phone eq ''}">
					<input type="hidden" name="mem_phone" value=""/>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="mem_phone" value="${phone1}-${phone2}-${phone3}"/>
				</c:otherwise>
			</c:choose>

			<input type="hidden" name="mem_email" value="${email1}@${email2}"/>
			<input type="hidden" name="mem_nick" value="${memberVO.mem_nick}"/>
			<input type="hidden" name="mem_pic" value="${memberVO.mem_pic}"/>
			
			<table id="join_table" align="center">
				<tr>
					<td colspan="2" id="join_table_title"><fmt:message key="join.joinConfirm"/></td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.classify"/></th>
					<td id="join_table_td02">${country}</th>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.gender"/></th>
					<td id="join_table_td02">${gender}</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.id"/></th>
					<td id="join_table_td02">${memberVO.mem_id}</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.pw"/></th>
					<td id="join_table_td02">${pwhide}</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.pwConfirmQ"/></th>
					<td id="join_table_td02">${memberVO.mem_pwquestion}</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.pwConfirmA"/></th>
					<td id="join_table_td02">${memberVO.mem_pwanswer}</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.name"/></th>
					<td id="join_table_td02">${memberVO.mem_name}</td>
				</tr>
				<c:if test="${phone ne ''}">
					<tr>
						<th id="join_table_td01" ><fmt:message key="join.phone"/></th>
						<td id="join_table_td02">${phone}</td>
					</tr>
				</c:if>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.email"/></th>
					<td id="join_table_td02">${email1}@${email2}</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.nick"/></th>
					<td id="join_table_td02">${memberVO.mem_nick}</td>
				</tr>
				<c:if test="${memberVO.mem_pic ne ''}">
					<tr>
						<th id="join_table_td01" ><fmt:message key="join.profilePic"/></th>
						<td id="join_table_td02">
							<img src="<c:url value="${memberVO.mem_pic}"/>" style="width:150px; height:150px;" alt="<fmt:message key="noImg"/>"/>
						</td>
					</tr>
				</c:if>
				<tr>
					<td id="join_table_td07" height="60" colspan="2" align="center">
						<input class="button_style_01" style="width:200px;" type="submit" value="<fmt:message key="join.checkInfoAndJoin"/>"/>
						<input class="button_style_02" style="width:90px;" type="button" value="<fmt:message key="join.changeInfo"/>" onclick="javascript:history.back();"/>
						<input class="button_style_02" style="width:90px;" type="button" value="<fmt:message key="join.cancelJoin"/>" onclick="javascript:location.href='./login';"/>
					</td>
				</tr>
			</table>
		</form>
		<br/><br/><br/>
	</fmt:bundle>
	</div>
<!-- 공통 우측메뉴 -->
<%@ include file="/resources/jsp/right_menu.jsp" %>		
		
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>
