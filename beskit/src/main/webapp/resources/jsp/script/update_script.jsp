<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="vo" value="${memberInfo}"/>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeSkit</title>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/join.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
</head>
<fmt:bundle basename="${sessionScope.basename}">
<script>
	var engOk = false;
	var pwOk = false;
	var pwCheckOk = false;
	var pwQOk = false;
	var phoneOk = false;
	var emailOk = false;
	var nickOk = false;
	
	window.onload = function() {
		updateBtnEnable();
		if(document.getElementById('mem_pwquestion').value == '') {
			document.getElementById('mem_pwquestion').disabled = true;
		}
		if(document.getElementById('email2').value == '') {
			document.getElementById('email2').disabled = true;
		}
		if('${memberVO.mem_pic}' != null) {
			document.getElementById('mem_pic').value = '${memberVO.mem_pic}';
		}
	}
	
	$(function() {
		$('#updateOk').addClass('button_style_01');
		$('#resetBtn').addClass('button_style_02');
		$('#cancelAllBtn').addClass('button_style_02');
	});
	
	//한글 입력 방지
	function noEngInput(input) {
		if(input.substring(input.length-1).charCodeAt(0) >= 128) {
			alert('<fmt:message key="user.noKorean"/>');
			if(input == document.getElementById('email1').value)
				document.getElementById('email1').value = '';
			if(input == document.getElementById('email2').value)
				document.getElementById('email2').value = '';
			engOk = true;
		} else {
			engOk = false;
		}
		updateBtnEnable();
	}

	$(function() {
//  한국인일 때 전화번호 출력
		if('${memberVO.mem_country}' == 0) {
			$('#phoneTitle').html('<fmt:message key="user.phone"/>');
			var psec = '<select id="phone1" name="phone1">';
			psec += '<option><fmt:message key="user.choose"/></option>';
			
			switch('${phone1}') {
			case '010' :
				psec += '<option selected>010</option>';
				psec += '<option>011</option>';
				psec += '<option>016</option>';
				psec += '<option>017</option>';
				psec += '<option>019</option>';
				break;
			case '011' :
				psec += '<option>010</option>';
				psec += '<option selected>011</option>';
				psec += '<option>016</option>';
				psec += '<option>017</option>';
				psec += '<option>019</option>';
				break;
			case '016' :
				psec += '<option>010</option>';
				psec += '<option>011</option>';
				psec += '<option selected>016</option>';
				psec += '<option>017</option>';
				psec += '<option>019</option>';
				break;
			case '017' :
				psec += '<option>010</option>';
				psec += '<option>011</option>';
				psec += '<option>016</option>';
				psec += '<option selected>017</option>';
				psec += '<option>019</option>';
				break;
			case '019' :
				psec += '<option>010</option>';
				psec += '<option>011</option>';
				psec += '<option>016</option>';
				psec += '<option>017</option>';
				psec += '<option selected>019</option>';
				break;
			}
			psec += '</select>';
			psec += '- <input type="text" name="phone2" id="phone2" value="${phone2}" required/>';
			psec += '- <input type="text" name="phone3" id="phone3" value="${phone3}" required/>';
			$('#phoneSection').html(psec);
			
			$('select[name=phone1]').change(function() {
				if($('select[name=phone1] option:selected').val() == '<fmt:message key="user.choose"/>' ||
						!$.isNumeric($('#phone2')) || $('#phone2').val() == '' || $('#phone2').val().length > 3 ||
						!$.isNumeric($('#phone3')) || $('#phone3').val() == '' || $('#phone3').val().length > 3 ) {
					phoneOk = true;
					updateBtnEnable();
				} else {
					phoneOk = false;
					updateBtnEnable();
				}
			});
			
			$('#phone2').keyup(function() {
				if($('#phone2').val() != '') {
					if($('#phone2').val().length == 4) {
						$('#phoneCheckMsg').html('');
						$('#phone2').focusout();
						$('#phone3').focus();
						phoneOk = false;
						updateBtnEnable();
					} else if (!$.isNumeric($('#phone2').val()) || $('#phone2').val().length > 4 ||
							$('select[name=phone1] option:selected').val() == '선택') {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="user.wrongPhone"/>');
						phoneOk = true;
						updateBtnEnable();
					} else if(($('#phone3').val() != '' && !$.isNumeric($('#phone3').val())) ||
							($('#phone3').val() != '' && (3 > $('#phone3').val().length && 
									$('#phone3').val().length > 4))) {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="user.wrongPhone"/>');
						phoneOk = true;
						updateBtnEnable();
					}
				}
			});
			$('#phone3').keyup(function() {
				if($('#phone3').val() != '') {
					if($('#phone3').val().length == 4) {
						$('#phoneCheckMsg').html('');
						phoneOk = false;
						updateBtnEnable();
					} else if (!$.isNumeric($('#phone3').val()) || $('#phone3').val().length > 4 ||
							$('select[name=phone1] option:selected').val() == '<fmt:message key="user.choose"/>') {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="user.wrongPhone"/>');
						phoneOk = true;
						updateBtnEnable();
					} else if(($('#phone2').val() != '' && !$.isNumeric($('#phone2').val())) ||
							($('#phone2').val() != '' && (3 > $('#phone2').val().length && 
									$('#phone2').val().length > 4))) {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="user.wrongPhone"/>');
						phoneOk = true;
						updateBtnEnable();
					}
				} 	
			});
		} else {
			$('#phoneOn').addClass('displayOff');
			$('#phoneTitle').html('');
			var psec2 = '<input type="hidden" name="phone1" value="null"/>';
			psec2 += '<input type="hidden" name="phone2" value="null"/>';
			psec2 += '<input type="hidden" name="phone3" value="null"/>';
			$('#phoneSection').html(psec2);
			$('#phoneCheckMsg').html('');
			phoneOk = false;
			updateBtnEnable();
		}
		
		//비밀번호 확인을 입력할 시
		$('#mem_pwCheck').keyup(function() {
			if($('#mem_pw').val() != '') {
				if(10 <= $('#mem_pw').val().length && $('#mem_pw').val().length <= 20) {
					if($('#mem_pwCheck').val() != '') {
						if($('#mem_pwCheck').val() == $('#mem_pw').val()) {
							$('#pwCheckMsg').removeClass('highlightNo');
							$('#pwCheckMsg').addClass('highlightOk');
							$('#pwCheckMsg').html('<fmt:message key="user.pwMatch"/>');
							pwCheckOk = false;
							updateBtnEnable();
						} else {
							$('#pwCheckMsg').removeClass('highlightOk');
							$('#pwCheckMsg').addClass('highlightNo');
							$('#pwCheckMsg').html('<fmt:message key="user.pwNoMatch"/>');
							pwCheckOk = true;
							updateBtnEnable();
						}
					}
					pwOk = false;
					updateBtnEnable();
				} else {
					alert('<fmt:message key="user.pwLengthMsg"/>');
					$('#mem_pwCheck').val('');
					pwOk = true;
					updateBtnEnable();
				}
			}
		});
		
		//비밀번호 확인 질문 선택
		$('#pwQuestionSelect').change(function() {
			if($('#pwQuestionSelect option:selected').val() != '<fmt:message key="user.chooseQ"/>') {
				document.getElementById('mem_pwquestion').disabled = false;				
				if($('#pwQuestionSelect option:selected').val() != '<fmt:message key="user.choose6"/>')
					$('#mem_pwquestion').val($('#pwQuestionSelect option:selected').val());
				pwQOk = false;
				updateBtnEnable();
			} else {
				document.getElementById('mem_pwquestion').disabled = true;
				pwQOk = true;
				updateBtnEnable();
			}
		});
		
		//이메일 도메인 선택
		$('#emailSelect').change(function() {
			if($('#emailSelect option:selected').val() != '<fmt:message key="user.emailChoose"/>') {
				document.getElementById('email2').disabled = false;				
				if($('#emailSelect option:selected').val() != '<fmt:message key="user.emailChoose7"/>')
					$('#email2').val($('#emailSelect option:selected').val());
				emailOk = false;
				updateBtnEnable();
			} else {
				document.getElementById('email2').disabled = true;
				emailOk = true;
				updateBtnEnable();
			}
		});
		
		//닉네임 입력 시
		$('#mem_nick').keyup(function() {
			if($('#mem_nick').val().length > 0) {
				if($('#mem_nick').val().length > 10) {
					$('#nickCheckMsg').removeClass('highlightOk');
					$('#nickCheckMsg').addClass('highlightNo');
					$('#nickCheckMsg').html('<fmt:message key="user.nickLengthMsg"/>');
					nickOk = true;
					updateBtnEnable();
				} else {
					$.ajax({
						method:'POST',
						url:'./nickCheck',
						data:{nick:$('#mem_nick').val()}
					}).done(function(nick) {
						if(nick.nick == 'same') {
							$('#nickCheckMsg').removeClass('highlightNo');
							$('#nickCheckMsg').removeClass('highlightOk');
							$('#nickCheckMsg').html('');
							nickOk = false;
							updateBtnEnable();
						} else if(nick.nick != null) {
							$('#nickCheckMsg').removeClass('highlightOk');
							$('#nickCheckMsg').addClass('highlightNo');
							$('#nickCheckMsg').html('<fmt:message key="user.nickAlreadyUse"/>');
							nickOk = true;
							updateBtnEnable();
						} else {
							$('#nickCheckMsg').removeClass('highlightNo');
							$('#nickCheckMsg').addClass('highlightOk');
							$('#nickCheckMsg').html('<fmt:message key="user.nickUseOk"/>');
							nickOk = false;
							updateBtnEnable();
						}
					});
				}
			}
		});
		
		//프로필 사진 입력 버튼 클릭 시
		$('#insertPic').click(function() {
			$('#nickCheckMsg').html('');
			window.open('./insertPic', 'Profile Picture Inserting', 
					'toolbar=no, location=center, scrollbar=no' +
					 'resizable=no, width=320, height=320, left=500, top=250');
			updateBtnEnable();
		});
		
		//프로필 사진 삭제 버튼 클릭 시
		$('#deletePic').click(function() {
			$('#nickCheckMsg').html('');
			if(document.getElementById('profilePic').src=='<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>') {
				return;
			} else {
				$('#profilePic').attr('src', '<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>');
				$('#mem_pic').val('');
			}
			updateBtnEnable();
		});
	});
	
	//조건사항이 모두 충족 시, 가입하기 버튼 enabled
	function updateBtnEnable() {
		if(pwOk == false && pwCheckOk == false && pwQOk == false && engOk == false &&
				phoneOk == false && emailOk == false && nickOk == false) {
			document.getElementById('updateOk').disabled = false;
			$('#updateOk').removeClass('button_style_02');
			$('#updateOk').addClass('button_style_01');
		} else {
			document.getElementById('updateOk').disabled = true;
			$('#updateOk').removeClass('button_style_01');
			$('#updateOk').addClass('button_style_02');
		}
	}
	
	//submit
	$(function() {
		$('#updateOk').click(function() {
			alert('<fmt:message key="user.infoChanged"/>');
			$('#updateForm').submit();
		});
	});
</script>
</fmt:bundle>
</head>