<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_other.css" />" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<script type="text/javascript">
function confirm_pw(mem_no){
 	$.ajax({
		method:'POST',
		url:'./confirm_member_pw',
		data:{mem_pw:$('#mem_pw').val(), mem_no:mem_no}
	}).done(function (data){
		if(data!==''){
			alert('<fmt:message key="user.verified"/>');
			window.opener.document.confirm_pw_form.submit();
			
			self.close();
		}else{
			alert('<fmt:message key="user.checkPwMsg"/>');
		}
	}); 
}

</script>
</head>
<body style="margin:0 auto;">
<div id="confirm_pw_tit" align="center"><fmt:message key="user.insertPwMsg"/></div>
<div align="center"><fmt:message key="user.pw"/> : 
	<input style="height:20px;" type="password" required="required" name="mem_pw" id="mem_pw"/>
	<input class="ui-button ui-widget ui-corner-all" id="pw_confirm" type="button" value="<fmt:message key="user.check"/>" onclick="confirm_pw(${mem_no});"/>
</div>
</body>
</fmt:bundle>
</html>