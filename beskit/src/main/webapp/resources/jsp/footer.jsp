<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<fmt:bundle basename="${sessionScope.basename}">
	<div id="main_footer" align="center">
		<table id="main_footer_table">
			<tr>
				<td id="footer_table_space" rowspan="2"></td>
				<td id="footer_table_td" align="center" valign="middle">
					<a onclick="location.href='/sjl/member/kor';" style="cursor:pointer;"><img src="<c:url value="/resources/img/koreanFlag.png"/>"/></a>
					&nbsp;&nbsp;<a onclick="location.href='/sjl/member/eng';" style="cursor:pointer;"><img src="<c:url value="/resources/img/engFlag.png"/>"/></a>
				</td>
				<c:choose>
					<c:when test="${sessionScope.memberInfo eq null || sessionScope.memberInfo eq ''}"> 
						<td id="footer_table_td" align="center"><a onclick="location.href='/sjl/member/join';" style="cursor:pointer;"><fmt:message key="footer.join"/></a></td>
						<td id="footer_table_td" align="center"><a onclick="location.href='/sjl/member/login';" style="cursor:pointer;"><fmt:message key="footer.login"/></a></td>
					</c:when>
					<c:otherwise>
						<td id="footer_table_td" align="center"><a onclick="location.href='/sjl/user/${sessionScope.memberInfo.mem_no}/leave';" style="cursor:pointer;"><fmt:message key="footer.resign"/></a></td>
						<td id="footer_table_td" align="center"><a onclick="location.href='/sjl/member/logout';" style="cursor:pointer;"><fmt:message key="footer.logout"/></a></td>
					</c:otherwise>
				</c:choose>
				<td id="footer_table_td" align="center"><a onclick="location.href='/sjl/member/privacy';" style="cursor:pointer;"><fmt:message key="footer.protectprivacy"/></a></td>
				<td id="footer_table_td" align="center"><a onclick="location.href='/sjl/member/policy';" style="cursor:pointer;"><fmt:message key="footer.form"/></a></td>
				<td id="footer_table_space" rowspan="2"></td>
			</tr>
			<tr>
				<td align="center" colspan="6" id="corporate">© 2016 BeSkit</td>
			</tr>	
		</table>
	</div>
</fmt:bundle>
</div>
</body>
</html>