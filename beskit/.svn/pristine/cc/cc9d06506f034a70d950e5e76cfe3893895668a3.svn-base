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
function changeStatus(){
	if($(':input:radio[name=selectFindOption]:checked').val()==1){
		var msg = '<table id="findid_table">';
		msg += '<tr>';
		msg += '<td align="center" width="80"><fmt:message key="find.name"/></td>';
		msg += '<td width="400"><input type="text" id ="mem_name" name="mem_name" required="required" size="24"/></td>';
		msg += '</tr>';
		msg += '<tr>';
		msg += '<td align="center" width="80"><fmt:message key="find.phone"/></td>';
		msg += '<td><select id="mem_phone1" name="mem_phone1" required="required">';
		msg += '	<option selected="selected">010</option>';
		msg += '	<option>011</option>';
		msg += '	<option>016</option>';
		msg += '	<option>017</option>';
		msg += '	<option>019</option>';
		msg += '</select> ';
		msg += '- <input type="text" name ="mem_phone2" id="mem_phone2" required="required" size="4"/> -';
		msg += ' <input type="text" name ="mem_phone3" id="mem_phone3" required="required" size="4"/>';
		msg += '</td>';
		msg += '<tr>';
		msg += '<td colspan="2" style="padding-top:10px;"><button name="find_id" id="find_id" class="ui-button ui-widget ui-corner-all"><fmt:message key="find.search"/></button>';
		msg += '</td>';
		msg += '</tr></table>';
		$('#findIdForm').html(msg);
	}else{
		var msg='<table id="findid_table">';
		msg += '<tr>';
		msg += '<td>';
		msg += '<input type="text" name="email1" id="email1" required size="10"/>@';
		msg += '<input type="text" name="email2" id="email2" required size="10"/> ';
		msg += '<select id="emailSelect" style="height:24px;">';
		msg += '<option selected><fmt:message key="find.emailchoose"/></option>';
		msg += '<option>gmail.com</option>';
		msg += '<option>hotmail.com</option>';
		msg += '<option>naver.com</option>';
		msg += '<option>daum.net</option>';
		msg += '<option>hanmail.net</option>';
		msg += '<option>nate.com</option>';
		msg += '<option id="selectWrite"><fmt:message key="find.emailchoose7"/></option>';
		msg += '</select>';
		msg += '</td></tr>';
		msg += '<tr><td style="padding-top:10px;">';
		msg += '<button name="find_id2" id="find_id2" class="ui-button ui-widget ui-corner-all"><fmt:message key="find.search"/></button>';
		msg += '</td></tr>';
		msg += '</table>';
		$('#findIdForm').html(msg);
	}
}

$(function(){
	changeStatus();
	$(":input:radio[name=selectFindOption]").change(function(){
		changeStatus();	
	});
	
	$(document).on("change","#emailSelect",function(){ 
		if($('#emailSelect option:selected').val() != '<fmt:message key="find.emailchoose"/>') {
			document.getElementById('email2').disabled = false;				
			if($('#emailSelect option:selected').val() != '<fmt:message key="find.emailchoose7"/>')
				$('#email2').val($('#emailSelect option:selected').val());
		} else {
			document.getElementById('email2').disabled = true;
		}
	});
	
	$(document).on("click","#find_id2",function(){ 
		$.ajax({
			method:'GET',
			url:'./find_id2',
			data:{email1:$('#email1').val(), email2:$('#email2').val()}
		}).done(function(data){
			if(data!==''){
				var mem_id= new Array();
				for(var i=0; i<data.length; i++){
					mem_id[i]=data[i].mem_id;
				}

				var mem_id_first = new Array();
				for(var i=0; i<mem_id.length; i++){
					mem_id_first[i] = mem_id[i].substring(0,3);
				}
				
				var mem_id_last = new Array();
				for(var i=0; i<mem_id.length; i++){
					mem_id_last[i]= mem_id[i].substring(mem_id[i].length-2, mem_id[i].length);
				}
				
				var star = new Array();
				for(var i=0; i<mem_id.length; i++){
					star[i] = mem_id[i].substring(3,mem_id[i].length-2);
				}
				
				var mem_id_middle= new Array();
				for(var i=0; i<star.length; i++){
					for(var j=0; j<star[i].length; j++){
						mem_id_middle[i]='';
						mem_id_middle[i]+='*';
					}
				}
				//실제로 출력하는 아이디값들 배열 
				var value = new Array();
				for(var i=0; i<mem_id.length; i++){
					value[i] = mem_id_first[i]+mem_id_middle[i]+mem_id_last[i];
				}
				$('#display').html('<hr/><div id="id_list_tit"><fmt:message key="find.idlist"/></div><br/>');
				for(var i=0; i<value.length; i++){
					$('#display').append('<div id="id_list">' + value[i]+'</div>');
				}

			}else{
				$('#display').html('<fmt:message key="find.noIdMsg"/>');
			}
		});
	});
	
	$(document).on("click","#find_id",function(){ 
		$.ajax({
			method:'GET',
			url:'./find_id',
			data:{mem_name:$('#mem_name').val(),mem_phone1:$('#mem_phone1').val(), mem_phone2:$('#mem_phone2').val(), mem_phone3:$('#mem_phone3').val()}
		}).done(function(data){
			if(data!==''){
				var mem_id= new Array();
				for(var i=0; i<data.length; i++){
					mem_id[i]=data[i].mem_id;
				}

				var mem_id_first = new Array();
				for(var i=0; i<mem_id.length; i++){
					mem_id_first[i] = mem_id[i].substring(0,3);
				}
				
				var mem_id_last = new Array();
				for(var i=0; i<mem_id.length; i++){
					mem_id_last[i]= mem_id[i].substring(mem_id[i].length-2, mem_id[i].length);
				}
				
				var star = new Array();
				for(var i=0; i<mem_id.length; i++){
					star[i] = mem_id[i].substring(3,mem_id[i].length-2);
				}
				
				var mem_id_middle= new Array();
				for(var i=0; i<star.length; i++){
					for(var j=0; j<star[i].length; j++){
						mem_id_middle[i]='';
						mem_id_middle[i]+='*';
					}
				}
				//실제로 출력하는 아이디값들 배열 
				var value = new Array();
				for(var i=0; i<mem_id.length; i++){
					value[i] = mem_id_first[i]+mem_id_middle[i]+mem_id_last[i];
				}
				$('#display').html('<hr/><div id="id_list_tit"><fmt:message key="find.idlist"/></div><br/>');
				for(var i=0; i<value.length; i++){
					$('#display').append('<div id="id_list">' + value[i]+'</div>');
				}
			}else{
				$('#display').html('<fmt:message key="find.noIdMsg"/>.');
			}
		});
	});
});
</script>
</head>
<body id="main">
	<div id="find_title" align="center"><strong><fmt:message key="find.findid"/></strong></div>
	<div class="widget" align="left">
		<label for="radio-1"><fmt:message key="find.findphone"/></label>
		<input type="radio" name="selectFindOption" checked="checked" value="1" id="radio-1">
		<label for="radio-2"><fmt:message key="find.findemail"/></label>
		<input type="radio" name="selectFindOption" value="2" id="radio-2">
		<div id="findIdForm"></div>
		<div id="display"></div>
	</div>
	<div id="underLine"><hr/></div>
	<input type="button" id="find_other" class="ui-button ui-widget ui-corner-all" onclick="location.href='findpw'" value="<fmt:message key="find.findpw"/>"  />
	<input type="button" id="find_close" class="ui-button ui-widget ui-corner-all" onclick="location.href='javascript:closeMe()'" value="<fmt:message key="find.close"/>" />
</body>
</fmt:bundle>
</html>