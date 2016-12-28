<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 리스트 스크립트 -->
<%@ include file="/resources/jsp/script/join_script.jsp"%>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp"%>

<!-- 리스트 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/join_left.jsp"%>

<!-- 리스트  -->
<fmt:bundle basename="${sessionScope.basename}">
	<div id="main_center">
		<form method="post" id="joinForm">
			<table id="join_table" align="center">
				<tr>
					<td colspan="3" id="join_table_title"><fmt:message key="join.title"/></td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2"><fmt:message key="join.classify"/></th>
					<td id="join_table_td02"><input type="radio" name="mem_country" value=0
						checked="checked"><fmt:message key="join.korean"/></td>
					<td id="join_table_td02"><input type="radio" name="mem_country" value=1><fmt:message key="join.foreigner"/>
					</td>
				</tr>
				<tr>
					<td id="join_table_td02"><input type="radio" name="mem_gender" value=0	checked="checked"><fmt:message key="join.male"/></td>
					<td id="join_table_td02"><input type="radio" name="mem_gender" value=1><fmt:message key="join.female"/></td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2" ><fmt:message key="join.id"/></th>
					<td id="join_table_td03" colspan="2"><input type="text" name="mem_id" id="mem_id"
						onkeyup="javascript:noEngInput(this.value);" required autofocus />
						<input type="button" value="<fmt:message key="join.idconfirm"/>" id="btnIdCheck" /></td>
				</tr>
				<tr>
					<td id="join_table_td04" colspan="2"><span id="infoFont"><fmt:message key="join.idMsg"/></span></td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2"  ><fmt:message key="join.pw"/></th>
					<td id="join_table_td03" colspan="2"><input type="password" name="pw" id="mem_pw"
						required /></td>
				</tr>
				<tr>
					<td id="join_table_td04" colspan="2"><span id="infoFont"><fmt:message key="join.pwMsg"/></span></td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2"  ><fmt:message key="join.confirm"/></th>
					<td id="join_table_td03" colspan="2"><input type="password" id="mem_pwCheck"
						required /></td>
				</tr>
				<tr>
					<td id="join_table_td04" colspan="2"><span id="infoFont"><div id="pwCheckMsg"></div></span>
					</td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2"  ><fmt:message key="join.pw"/></br><fmt:message key="join.confirmQ"/></th>
					<td id="join_table_td03" colspan="2"><input type="text" name="mem_pwquestion" id="mem_pwquestion" required />
					</td>
				</tr>
				<tr>
					<td id="join_table_td04" colspan="2">
						<select id="pwQuestionSelect">
							<option selected><fmt:message key="join.chooseQ"/></option>
							<option><fmt:message key="join.choose1"/></option>
							<option><fmt:message key="join.choose2"/></option>
							<option><fmt:message key="join.choose3"/></option>
							<option><fmt:message key="join.choose4"/></option>
							<option><fmt:message key="join.choose5"/></option>
							<option id="selectWrite"><fmt:message key="join.choose6"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<th id="join_table_td01" ><fmt:message key="join.qAns"/></th>
					<td id="join_table_td02" colspan="2"><input type="text" name="mem_pwanswer"
						id="mem_pwanswer" required /></td>
				</tr>
				<tr>
					<th id="join_table_td01"><fmt:message key="join.name"/></th>
					<td id="join_table_td02" colspan="2"><input type="text" name="mem_name"
						id="mem_name" required /></td>
				</tr>
				<tr id="phoneOn">
					<th id="join_table_td01" rowspan="2"><div id="phoneTitle"></div></th>
					<td id="join_table_td03" colspan="2"><div id="phoneSection"></div></td>
				</tr>
				<tr id="phoneOn">
					<td id="join_table_td04" colspan="2"><span id="infoFont"><div id="phoneCheckMsg"></div></span>
					</td>
				</tr>
				<tr>
					<th id="join_table_td01"><fmt:message key="join.email"/></th>
					<td id="join_table_td02" colspan="2"><input type="text" name="email1" id="email1"
						onkeydown="javascript:noEngInput(this.value);" required /> @ <input
						type="text" name="email2" id="email2"
						onkeydown="javascript:noEngInput(this.value);" required /> 
						<select id="emailSelect">
							<option selected><fmt:message key="join.emailChoose"/></option>
							<option>gmail.com</option>
							<option>hotmail.com</option>
							<option>naver.com</option>
							<option>daum.net</option>
							<option>hanmail.net</option>
							<option>nate.com</option>
							<option id="selectWrite"><fmt:message key="join.emailChoose7"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2"  ><fmt:message key="join.nick"/></th>
					<td id="join_table_td03" colspan="2"><input type="text" name="mem_nick"
						id="mem_nick" required /></td>
				</tr>
				<tr>
					<td id="join_table_td04" colspan="2">
						<span id="infoFont"><div id="nickCheckMsg"></div></span>
					</td>
				</tr>
				<tr>
					<th id="join_table_td01" rowspan="2"><fmt:message key="join.profilePic"/></th>
					<td id="join_table_td05" rowspan="2" align="center"><img id="profilePic"
						src="<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>" style="width: 100px; height: 100px;" alt="<fmt:message key="noImg"/>" />
					</td>
					<td valign="bottom" id="join_table_td05">
						<input type="button" class="button_style_03" id="insertPic"	value="<fmt:message key="join.uploadImg"/>" />
					</td>
				</tr>
				<tr>
					<td valign="top" id="join_table_td06"><input class="button_style_03" type="button" id="deletePic" value="<fmt:message key="join.imgDelete"/>" /></td>
				</tr>
				<tr>
					<td colspan="3"><input type="hidden" name="mem_pic" id="mem_pic" />
					</td>
				</tr>
				<tr>
					<td id="join_table_td07" height="60" colspan="3" align="center">
						<input type="submit" value="<fmt:message key="join.join"/>" id="joinOk" />
						<input type="reset" class="button_style_02" value="<fmt:message key="join.rewrite"/>" id="resetBtn"/> 
						<input type="button" class="button_style_02" value="<fmt:message key="join.cancel"/>" onclick="javascript:history.back();" id="cancelAllBtn"/>
					</td>
				</tr>
			</table>
		</form>
		<br/><br/><br/>
	</div>
</fmt:bundle>
	
<!-- 공통 우측메뉴 -->
<%@ include file="/resources/jsp/right_menu.jsp" %>		
		
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>
