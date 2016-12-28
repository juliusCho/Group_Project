<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 수정 스크립트 -->
<%@ include file="/resources/jsp/script/update_script.jsp" %>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>

<!-- 수정 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/member_left.jsp" %>

<!-- 수정 리스트  -->
<fmt:bundle basename="${sessionScope.basename}">
<div id="main_center">
	<form method="post" id="updateForm" action="./updateFinal">
		<c:choose>
			<c:when test="${memberVO.mem_country ne 0}">
				<input type="hidden" name="mem_phone" value=""/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="mem_phone" value="${phone1}-${phone2}-${phone3}"/>
			</c:otherwise>
		</c:choose>
			
		<table id="join_table" align="center">
			<tr>
				<td colspan="3" id="join_table_title"><fmt:message key="user.updateTitle"/></td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.classify"/></th>
				<td  id="join_table_td02" colspan="2">
				<c:choose>
					<c:when test="${memberVO.mem_country eq 0}"><fmt:message key="user.korean"/></c:when>
					<c:otherwise><fmt:message key="user.foreigner"/></c:otherwise>
				</c:choose>
				<input type="hidden" name="mem_country" value="${memberVO.mem_country}"/>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.gender"/></th>
				<td id="join_table_td02" colspan="2">
				<c:choose>
					<c:when test="${memberVO.mem_gender eq 0}"><fmt:message key="user.male"/></c:when>
					<c:otherwise><fmt:message key="user.female"/></c:otherwise>
				</c:choose>
				<input type="hidden" name="mem_gender" value="${memberVO.mem_gender}"/>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.id"/></th>
				<td id="join_table_td02">${memberVO.mem_id}
					<input type="hidden" name="mem_id" value="${memberVO.mem_id}"/>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01" rowspan="2"><fmt:message key="user.pw"/></th>
				<td id="join_table_td03" colspan="2">
					<input type="password" name="pw" id="mem_pw" required/>
				</td>
			</tr>
			<tr>
				<td id="join_table_td02" colspan="2">
					<span id="infoFont"><fmt:message key="user.pwLengthMsg"/></span>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01" rowspan="2"><fmt:message key="user.pwCheck"/></th>
				<td id="join_table_td03" colspan="2">
					<input type="password" id="mem_pwCheck" required/>
				</td>
			</tr>
			<tr>
				<td id="join_table_td04" colspan="2">
					<span id="infoFont"><div id="pwCheckMsg"></div></span>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01" rowspan="2"><fmt:message key="user.pwCheckQ"/></th>
				<td id="join_table_td03" colspan="2">
					<input type="text" name="mem_pwquestion" id="mem_pwquestion" value="${memberVO.mem_pwquestion}" required/>
				</td>
			</tr>
			<tr>
				<td id="join_table_td04" colspan="2">
					<select id="pwQuestionSelect">
						<option selected><fmt:message key="user.chooseQ"/></option>
						<option><fmt:message key="user.choose1"/></option>
						<option><fmt:message key="user.choose2"/></option>
						<option><fmt:message key="user.choose3"/></option>
						<option><fmt:message key="user.choose4"/></option>
						<option><fmt:message key="user.choose5"/></option>
						<option id="selectWrite"><fmt:message key="user.choose6"/></option>
					</select>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01" ><fmt:message key="user.pwCheckA"/></th>
				<td id="join_table_td02" colspan="2">
					<input type="text" name="mem_pwanswer" id="mem_pwanswer" value="${memberVO.mem_pwanswer}" required/>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.name"/></th>
				<td id="join_table_td02" colspan="2">
					<input type="text" name="mem_name" id="mem_name" value="${memberVO.mem_name}" required/>
				</td>
			</tr>
			<tr id="phoneOn">
				<th id="join_table_td01" rowspan="2"><div id="phoneTitle"></div></th>
				<td id="join_table_td03" colspan="2"><div id="phoneSection"></div></td>
			</tr>
			<tr id="phoneOn">
				<td id="join_table_td04" colspan="2">
					<span id="infoFont"><div id="phoneCheckMsg"></div></span>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01"><fmt:message key="user.email"/></th>
				<td id="join_table_td02" colspan="2">
					<input type="text" name="email1" id="email1" value="${email1}" onkeyup="javascript:noEngInput(this.value);" required/>
					@ <input type="text" name="email2" id="email2" value="${email2}" onkeyup="javascript:noEngInput(this.value);" required/>
					<select id="emailSelect">
						<option><fmt:message key="user.emailChoose"/></option>
						<c:choose>
							<c:when test="${email2 eq 'gmail.com'}">
								<option selected>gmail.com</option>
								<option>hotmail.com</option>
								<option>naver.com</option>
								<option>daum.net</option>
								<option>hanmail.net</option>
								<option>nate.com</option>
								<option id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:when>
							<c:when test="${email2 eq 'hotmail.com'}">
								<option>gmail.com</option>
								<option selected>hotmail.com</option>
								<option>naver.com</option>
								<option>daum.net</option>
								<option>hanmail.net</option>
								<option>nate.com</option>
								<option id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:when>
							<c:when test="${email2 eq 'naver.com'}">
								<option>gmail.com</option>
								<option>hotmail.com</option>
								<option selected>naver.com</option>
								<option>daum.net</option>
								<option>hanmail.net</option>
								<option>nate.com</option>
								<option id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:when>
							<c:when test="${email2 eq 'daum.net'}">
								<option>gmail.com</option>
								<option>hotmail.com</option>
								<option>naver.com</option>
								<option selected>daum.net</option>
								<option>hanmail.net</option>
								<option>nate.com</option>
								<option id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:when>
							<c:when test="${email2 eq 'hanmail.net'}">
								<option>gmail.com</option>
								<option>hotmail.com</option>
								<option>naver.com</option>
								<option>daum.net</option>
								<option selected>hanmail.net</option>
								<option>nate.com</option>
								<option id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:when>
							<c:when test="${email2 eq 'nate.com'}">
								<option>gmail.com</option>
								<option>hotmail.com</option>
								<option>naver.com</option>
								<option>daum.net</option>
								<option>hanmail.net</option>
								<option selected>nate.com</option>
								<option id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:when>
							<c:otherwise>
								<option>gmail.com</option>
								<option>hotmail.com</option>
								<option>naver.com</option>
								<option>daum.net</option>
								<option>hanmail.net</option>
								<option>nate.com</option>
								<option selected id="selectWrite"><fmt:message key="user.emailChoose7"/></option>
							</c:otherwise>
						</c:choose>
					</select>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01" rowspan="2" ><fmt:message key="user.nick"/></th>
				<td id="join_table_td03" colspan="2">
					<input type="text" name="mem_nick" id="mem_nick" value="${memberVO.mem_nick}" required/>
				</td>
			</tr>
			<tr>
				<td id="join_table_td04" colspan="2">
					<span id="infoFont"><div id="nickCheckMsg"></div></span>
				</td>
			</tr>
			<tr>
				<th id="join_table_td01" rowspan="2"><fmt:message key="user.profilePic"/></th>
				<td id="join_table_td05" rowspan="2" align="center">
					<c:choose>
						<c:when test="${memberVO.mem_pic eq '' || memberVO.mem_pic eq null}">
							<img id="profilePic" src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" style="width:100px; height:100px;" alt="<fmt:message key="user.noImgMsg"/>"/>
							<input type="hidden" name="mem_pic" id="mem_pic"/>
						</c:when>
						<c:otherwise>
							<img id="profilePic" src="<c:url value="/member/${memberVO.mem_pic}"/>" style="width:100px; height:100px;" alt="<fmt:message key="user.noImgMsg"/>"/>
							<input type="hidden" name="mem_pic" id="mem_pic" value="${memberVO.mem_pic}"/>
						</c:otherwise>
					</c:choose>
				</td>
				<td valign="bottom" id="join_table_td05">
					<input class="button_style_03" type="button" id="insertPic" value="<fmt:message key="user.profilePicChange"/>"/>
				</td>
			</tr>
			<tr>
				<td valign="top" id="join_table_td06">
					<input class="button_style_03" type="button" id="deletePic" value="<fmt:message key="user.profilePicDelete"/>"/>
				</td>
			</tr>
			<tr>
				<td id="join_table_td07" height="60" colspan="3" align="center">
					<input type="button" value="<fmt:message key="user.modify"/>" id="updateOk"/>
					<input type="button" class="button_style_02" value="<fmt:message key="user.cancel"/>" onclick="javascript:history.back();"/>
				</td>
			</tr>
		</table>
	</form>
	<br/><br/>
</div>
</fmt:bundle>
<!-- 공통 우측메뉴 -->
<%@ include file="/resources/jsp/right_menu.jsp" %>		
		
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>	