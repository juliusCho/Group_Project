<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<title>BeSkit</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/find.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<script type="text/javascript">
function closeMe() {
	this.close();
}
</script>
<script>
  $( function() {
    $( "input" ).checkboxradio();
  } );
</script>

<script>
  $( function() {
    $( ".widget button" ).button();
    $( "button" ).click( function( event ) {
      event.preventDefault();
    } );
  } );
</script>
<script type="text/javascript">
function make_temppw(){
	var value='';
	value += String.fromCharCode(Math.floor(Math.random()*10)+48);//숫자0~9까지
	value += String.fromCharCode(Math.floor(Math.random()*26)+97);
	value += String.fromCharCode(Math.floor(Math.random()*10)+48);
	value += String.fromCharCode(Math.floor(Math.random()*26)+97);
	value += String.fromCharCode(Math.floor(Math.random()*26)+97);
	value += String.fromCharCode(Math.floor(Math.random()*26)+97);
	value += String.fromCharCode(Math.floor(Math.random()*26)+65);
	value += String.fromCharCode(Math.floor(Math.random()*26)+97);
	value += String.fromCharCode(Math.floor(Math.random()*26)+65);
	value += String.fromCharCode(Math.floor(Math.random()*10)+48);
	value += String.fromCharCode(Math.floor(Math.random()*26)+65);
	
	return value;	
}

//임시비밀번호로 바꾸는 function
function findAndChange_pw(result, mem_id){
	$.ajax({
		method:'POST',
		url:'./findAndChange_pw',
		data:{mem_pw:result, mem_id:mem_id}
	}).done(function(data){});
}

//본인 인증 두번째( 아이디,이름, 질문에 대한 답변)
function confirm_pw(){
	$.ajax({
		method:'POST',
		url:'./confirm_pwquestion',
		data:{mem_id:$('#mem_id').val(), mem_name:$('#mem_name').val(), mem_pwanswer:$('#mem_pwanswer').val()}
	}).done(function(data){
		if(data!==''){
			$('#waiting_msg').html('처리중입니다. 잠시만 기다려주세요');
			$.ajax({
				method:'POST',
				url:'./sendmail',
				data:{mem_id:$('#mem_id').val()}
				
			}).done(function(data){
				if(data==1){
					alert('<fmt:message key="find.verifydoneMsg"/>');
					self.close();
				}else{
					alert('<fmt:message key="find.error"/>');
				}
			});
		}else{
			$('#waiting_msg').html('<fmt:message key="find.verifynoMsg"/>');
		}
	});
}


//본인 인증 첫번째 (아이디,이름)
$(function(){
	$('#find_pw').click(function(){
		$.ajax({
			method:'GET',
			url:'./find_pw',
			data:{mem_id:$('#mem_id').val(), mem_name:$('#mem_name').val()}
			
		}).done(function(data){
			
			if(data!==''){
				var item ='<hr/><br/><strong>'+ data.mem_pwquestion + '</strong>';
				item += '<br/><input style="height:30px;" type="text" id="mem_pwanswer" id="mem_pwanswer" required="required"/>'
				item += '&nbsp;&nbsp;<input type="button" class="ui-button ui-widget ui-corner-all" name="confirm_pw" id="confirm_pw" value="<fmt:message key="find.confirm"/>" onclick="confirm_pw();"/>'
				item += '<br/>';
				item += '';
				$('#display').html(item);
				$('#waiting_msg').html('가입하신 e-mail로 임시비밀번호가 발송됩니다.');
			}else{
				$('#display').html('<fmt:message key="find.nomatchMsg"/>');
			}
		});
	});
	
});
</script>
</head>
<body id="main">
	<div id="find_title" align="center"><strong><fmt:message key="find.findpw"/></strong></div>
	<div class="widget" align="left">
		<table id="findpw_table">
			<tr>
				<td align="center" width="80"><fmt:message key="find.id"/></td>
				<td><input type="text" name="mem_id" id="mem_id" required="required" size="20"/></td>
			</tr>
			<tr>
				<td align="center" width="80"><fmt:message key="find.name2"/></td>
				<td><input type="text" name="mem_name" id="mem_name" required="required" size="20"/></td>
			</tr>
			<tr>
				<td colspan="2" height="60"><button name="find_pw" id="find_pw" class="ui-button ui-widget ui-corner-all"><fmt:message key="find.search"/></button>
				</td>
			</tr>
		</table>
		<div id="display"></div>
		<div id="waiting_msg"></div>
		<div id="temppw"></div>
	</div>
	<div id="underLine"><hr/></div>
	<input type="button" id="find_other" class="ui-button ui-widget ui-corner-all" onclick="location.href='findid'" value="<fmt:message key="find.findid"/>"  />
	<input type="button" id="find_close" class="ui-button ui-widget ui-corner-all" onclick="location.href='javascript:closeMe()'" value="<fmt:message key="find.close"/>" />
</body>
</fmt:bundle>
</html>