<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<fmt:bundle basename="${sessionScope.basename}">
<head>
<script src="<c:url value="/resources/js/jquery-3.1.1.js"/>"></script>
<style>
	#warningMsg {color:green; font-size:90%;}
	#warningMsg2 {color:red; font-size:70%;}
</style>
<script>
	var displaying = '';
	var windowOff = false;
	var changedImg = '';

	window.onload = function() {
		uploadDisplay();
	}
	
	function uploadDisplay() {
		displaying += '<input type="file" name="mem_pic" id="mem_pic" size=40 accept="image/*"/>';
		displaying += '<input type="button" value="<fmt:message key="upload.upload"/>" id="btnInsert"/>';
	}

	$(function() {
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
			    	show += '<input type="button" value="<fmt:message key="upload.upload"/>" id="btnInsert"/>';
		    	} else {
		    		show += '<img src="<c:url value="/member/' + display.url + '"/>" alt="<fmt:message key="upload.noImgMsg"/>"/>';
		    		show += '<br/><br/><input type="button" value="<fmt:message key="upload.confirm"/>" onclick="javascript:clickOk();"/>';
		    		changedImg = display.url;
		    	}
	    		$('#uploadImg').html(show);
		    });
		});
	});
	
	function clickOk() {
		$(function() {
			$('#profilePic', opener.document).attr('src', '<c:url value="/member/' + changedImg + '"/>');
			$('#mem_pic', opener.document).val(changedImg);
			self.close();
		});
	}
</script>
</head>
<body>
<form method="post" enctype="text" enctype="multipart/form-data">
<table align="center">
	<caption><h3><fmt:message key="upload.title"/></h3></caption>
<tr align="center">
	<td id="warningMsg">
		** jpg, bmp, gif, png <fmt:message key="upload.compatMsg1"/><br/><fmt:message key="upload.compatMsg2"/> **
	</td>
</tr>
<tr align="center">
	<td id="warningMsg2">
		** <fmt:message key="upload.memMsg"/>
	</td>
</tr>
<tr><td><br/></td></tr>
<tr align="center">
	<td>
		<div id="uploadImg"></div>
	</td>
</tr>
</table>
</form>
</body>
</fmt:bundle>
</html>