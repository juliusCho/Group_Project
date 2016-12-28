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
<link rel="shortcut icon" href="/favicon.png"/>
<script src="<c:url value="/resources/js/jquery-3.1.1.js"/>"></script>
<script>
	var art_no = '';

	window.onload = function() {
		art_no = window.opener.document.getElementById('articleUpdateNo').value;
		
		$.ajax({
			method:'POST',
			url:'./getArticle',
			data:{art_no:art_no}
		}).done(function(articleVO) {
			if(articleVO.art_pic != null) {
				$('#pic_input').html('<img src="<c:url value="/member/' + articleVO.art_pic + '"/>"/>' +
				'<input type="hidden" id="art_pic" value="' + articleVO.art_pic + '"/>');
			} else {
				$('#pic_input').html('<img src="<c:url value="/resources/img/article/img_noimage.png"/>"/>' +
				'<input type="hidden" id="art_pic" value=""/>');
			}
			$('#art_content').val(articleVO.art_content);
			$('#art_no').val(articleVO.art_no);
		});
	}
	
	$(function() {
		
		//사진변경을 클릭 시
		$('#picChangeBtn').click(function() {
			window.open('./insertImg', 'Image Inserting', 
					'toolbar=no, location=center, scrollbar=yes' +
					 'resizable=yes, width=500, height=500, left=500, top=250');
		});
		
		//사진삭제를 클릭 시
		$('#picDeleteBtn').click(function() {
			if(confirm('<fmt:message key="home.delPicMsg"/>')) {
				$('#pic_input').html('<img src="<c:url value="/resources/img/article/img_noimage.png"/>"/>' +
				'<input type="hidden" id="art_pic" value=""/>');
			}
		});
		
	});
	
	//수정을 클릭 시
	function submitBtn() {
		if(confirm('<fmt:message key="home.updateArtMsg"/>')) {
			$(function() {	
				if($('#art_pic').val() == '<c:url value="/resources/img/article/img_noimage.png"/>') {
					$('#art_pic').val('');
				}
				
				$.ajax({
					method:'POST',
					url:'./updateArticle',
					data:{
						art_no:art_no,
						art_pic:$('#art_pic').val(),
						art_content:$('#art_content').val()
					}
				}).done(function(result) {
					if(result != null) {
						window.opener.location.reload();
						self.close();
					} 
				});
			});
		}
	}
	
	//취소를 클릭 시
	function cancelBtn() {
		self.close();
	}
</script>
</head>
<body>
<form method="post" enctype="multipart/form-data">
<table align="center">
	<caption><fmt:message key="home.updateTitle"/></caption>
<tr>
	<td align="center">
		<div id="pic_input"></div>
	</td>
</tr>
<tr>
	<td align="center">
		<input type="button" value="<fmt:message key="home.changePic"/>" id="picChangeBtn"/>
		<input type="button" value="<fmt:message key="home.deletePic"/>" id="picDeleteBtn"/>
	</td>
</tr>
<tr>
	<td align="center">
		<textarea cols="70" rows="5" id="art_content" required="required"></textarea>
	</td>
</tr>
<tr>
	<td align="center">
		<input type="button" value="<fmt:message key="home.updateUpdate"/>" onclick="javascript:submitBtn();"/>
		<input type="reset" value="<fmt:message key="home.deleteContent"/>"/>
		<input type="button" value="<fmt:message key="home.updateCancel"/>" onclick="javascript:cancelBtn();"/>
	</td>
</tr>
</table>
</form>
</body>
</fmt:bundle>
</html>