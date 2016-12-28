<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 회원가입 스크립트 -->
<%@ include file="/resources/jsp/script/mypage_script.jsp"%>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>

<!-- 프로필 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/member_left.jsp" %>

<!-- 리스트  -->
   <form method="post" action="update">
   <div id="main_center">
   <fmt:bundle basename="${sessionScope.basename}">
		<input type="hidden" name="mem_country" value="${vo.mem_country}"/>
		<input type="hidden" name="mem_gender" value="${vo.mem_gender}"/>
		<input type="hidden" name="mem_id" value="${vo.mem_id}"/>
		<input type="hidden" name="mem_pwquestion" value="${vo.mem_pwquestion}"/>
		<input type="hidden" name="mem_pwanswer" value="${vo.mem_pwanswer}"/>
		<input type="hidden" name="mem_name" value="${vo.mem_name}"/>
		<c:if test="${vo.mem_country eq 0}">
			<input type="hidden" name="mem_phone" value="${vo.mem_phone}"/>
		</c:if>
		<input type="hidden" name="mem_email" value="${vo.mem_email}"/>
		<input type="hidden" name="mem_nick" value="${vo.mem_nick}"/>
		<input type="hidden" name="mem_pic" value="${vo.mem_pic}"/>
		<table id="join_table" align="center">
			<tr>
				<td colspan="2" id="join_table_title"><fmt:message key="user.checkMemInfo"/></td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.memCountry"/></th>
				<td id="join_table_td02">
					<c:choose>
					<c:when test="${vo.mem_country eq 0}"><fmt:message key="user.korean"/></c:when>
					<c:otherwise><fmt:message key="user.foreigner"/></c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.gender"/></th>
				<td id="join_table_td02">
					<c:choose>
					<c:when test="${vo.mem_gender eq 0}"><fmt:message key="user.male"/></c:when>
					<c:otherwise><fmt:message key="user.female"/></c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.id"/></th>
				<td id="join_table_td02">${vo.mem_id}</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.pwCheckQ"/></th>
				<td id="join_table_td02">${vo.mem_pwquestion}</td>
			</tr>
			<%-- 
			<tr>
				<th id="join_table_td01"><fmt:message key="user.pwCheckA"/></th>
				<td>${vo.mem_pwanswer}</td>
			</tr> 
			--%>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.name"/></th>
				<td id="join_table_td02">${vo.mem_name}</td>
			</tr>
			<c:if test="${vo.mem_country eq 0}">
			<tr>
				<th id="join_table_td01"><fmt:message key="user.phone"/></th>
				<td id="join_table_td02"> ${vo.mem_phone}</td>
			</tr>
			</c:if>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.email"/></th>
				<td id="join_table_td02">${vo.mem_email}</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.nick"/></th>
				<td id="join_table_td02">${vo.mem_nick}</td>
			</tr>
			<c:choose>
				<c:when test="${vo.mem_pic eq '' || vo.mem_pic eq null}">
					<tr>
						<th id="join_table_td01"><fmt:message key="user.profilePic"/></th>
						<td id="join_table_td02">
							<img src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" style="width:100px; height:100px;" alt="<fmt:message key="user.noImgMsg"/>"/>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th id="join_table_td01"><fmt:message key="user.profilePic"/></th>
						<td id="join_table_td02">
							<img src="<c:url value="/member/${vo.mem_pic}"/>" style="width:100px; height:100px;" alt="<fmt:message key="user.noImgMsg"/>"/>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="2" align="center">
					<input class="button_style_01" style="width:90px;" type="submit" value="<fmt:message key="user.modifyInfo"/>" />
					<input class="button_style_02" style="width:100px;" type="button" value="<fmt:message key="user.mypage"/>" onclick="javascript:location.href='../../profile/' + ${vo.mem_no} + '/';"/>
				</td>
			</tr> 
		</table>
		<h5><fmt:message key="user.askFinal1"/>&nbsp;<span style="color: green"><a style="cursor:pointer;" onclick="location.href='./leave'"><fmt:message key="user.askFinal2"/></a></span></h5>
		<br/><br/>
	</fmt:bundle>	
	</div>
	</form>		
<!-- 공통 우측메뉴 -->
<%@ include file="/resources/jsp/right_menu.jsp" %>		
		
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>	