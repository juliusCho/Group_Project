<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/insertImg.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<script>
	var displaying = '';
	var windowOff = false;
	var changedImg = '';

	function uploadDisplay() {
		displaying += '<div id="insertPic" align="left"><input type="file" name="mem_pic" id="mem_pic" size=40 accept="image/*"/></div>';
		displaying += '<div id="insertPic" align="left"><input type="button" style="width:73px;" value="<fmt:message key="upload.upload"/>" id="btnInsert" /></div>';
	}

	$(function() {
		uploadDisplay();
		$('#uploadImg').html(displaying);
		$('#btnInsert').click(function() {		
			
			var file = $('#mem_pic')[0].files[0];
            var formData = new FormData();
            formData.append('upFile', file);
			
		    $.ajax({
		    	method:'POST',
		    	url:'./insertPic',
                processData: false,
                contentType: false,
                data:formData
		    }).done(function(display) {
		    	var show = '';
		    	if(display.imageName == 'fail') {
		    		show += '<fmt:message key="upload.nofileMsg"/>';
			    	show += '<br/><input type="file" name="mem_pic" id="mem_pic" size=40 accept="image/*"/>';
			    	show += '<input type="button" value="<fmt:message key="upload.upload"/>" id="btnInsert"/>';
		    	} else if(display.imageName == 'exceeded') {
		    		show += '<fmt:message key="upload.exceededMsg1"/>2MB<fmt:message key="upload.exceededMsg2"/>';
			    	show += '<br/><input type="file" name="mem_pic" id="mem_pic" size=40 accept="image/*"/>';
			    	show += '<input type="button" value="<fmt:message key="upload.upload"/>" id="btnInsert"/>';
		    	} else if(display.imageName == 'notImg') {
		    		show += '<fmt:message key="upload.notImgMsg"/>';
			    	show += '<br/><input type="file" name="mem_pic" id="mem_pic" size=40 accept="image/*"/>';
			    	show += '<input type="button" value="<fmt:message key="upload.upload"/>" id="btnInsert"/>';
		    	} else {
		    		show += '<img src="<c:url value="/member/' + display.url + '"/>" alt="<fmt:message key="upload.noImgMsg"/>"/>';
		    		show += '<br/><input type="button" value="<fmt:message key="upload.confirm"/>" onclick="javascript:clickOk();"/>';
		    		changedImg = display.url;
		    	}
	    		$('#uploadImg').html(show);
		    });
		});
	});
	
	function clickOk() {
		$(function() {
			$('#profilePic', opener.document).attr('src', '<c:url value="' + changedImg + '"/>');
			$('#mem_pic', opener.document).val(changedImg);
			self.close();
		});
	}
</script>
</head>
<body style="margin:0 auto;">
<form method="post" enctype="text" enctype="multipart/form-data">
<table align="center">
	<tr>
		<td align="center" colspan="2" height="50"><h3><fmt:message key="upload.title"/></h3></td>
	</tr>
	<tr align="center">
		<th style="width:100px; height:40px; background-color:#dcdcdc" align="center" ><fmt:message key="upload.fileformat"/></th>
		<td id="warningMsg" style="width:215px; height:40px; background-color:#ededed" align="left">
			** jpg, bmp, gif, png <fmt:message key="upload.compatMsg1"/><br/><fmt:message key="upload.compatMsg2"/> **
		</td>
	</tr>
	<tr align="center">
		<th style="width:100px; height:40px; background-color:#dcdcdc" align="center"><fmt:message key="upload.fileSize"/></th>
		<td id="warningMsg2" style="width:215px; height:40px; background-color:#ededed" align="left">
			** <fmt:message key="upload.memMsg"/>
		</td>
	</tr>
	<tr align="center">
		<td colspan="2">
			<div id="uploadImg"></div>
		</td>
	</tr>
</table>
</form>
</body>
</fmt:bundle>
</html>