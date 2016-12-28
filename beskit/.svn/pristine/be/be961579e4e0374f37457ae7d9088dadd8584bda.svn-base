<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.country}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeSkit</title>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/join.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<fmt:bundle basename="${sessionScope.basename}">
<script>
	var engOk = false;
	var idOk = false;
	var pwOk = false;
	var pwCheckOk = false;
	var pwQOk = false;
	var phoneOk = false;
	var emailOk = false;
	var nickOk = false;
	
	window.onload = function() {
		phoneInput();
		joinBtnEnable();
		if(document.getElementById('mem_pwquestion').value == '') {
			document.getElementById('mem_pwquestion').disabled = true;
		}
		if(document.getElementById('email2').value == '') {
			document.getElementById('email2').disabled = true;
		}
	}
	
	//한글 입력 방지
	function noEngInput(input) {
		if(input.substring(input.length-1).charCodeAt(0) >= 128) {
			alert('<fmt:message key="join.noKorean"/>');
			if(input == document.getElementById('mem_id').value)
				document.getElementById('mem_id').value = '';
			if(input == document.getElementById('email1').value)
				document.getElementById('email1').value = '';
			if(input == document.getElementById('email2').value)
				document.getElementById('email2').value = '';
			engOk = true;
		} else {
			engOk = false;
		}
		joinBtnEnable();
	}
	
	// 한국인 radio button 선택 되어 있을 시
	function phoneInput() {
		if ($(':input:radio[name=mem_country]:checked').val() == 0) {
			$('#phoneOn').removeClass('displayOff');
			$('#phoneTitle').html('<fmt:message key="join.phone"/>');
			var psec = '<select id="phone1" name="phone1">';
			psec += '<option selected><fmt:message key="join.choose"/></option>';
			psec += '<option>010</option>';
			psec += '<option>011</option>';
			psec += '<option>016</option>';
			psec += '<option>017</option>';
			psec += '<option>019</option>';
			psec += '</select>';
			psec += '- <input type="text" name="phone2" id="phone2" required/>';
			psec += '- <input type="text" name="phone3" id="phone3" required/>';
			$('#phoneSection').html(psec);
			
			$('select[name=phone1]').change(function() {
				if($('select[name=phone1] option:selected').val() == '<fmt:message key="join.choose"/>' ||
						!$.isNumeric($('#phone2')) || $('#phone2').val() == '' || $('#phone2').val().length > 3 ||
						!$.isNumeric($('#phone3')) || $('#phone3').val() == '' || $('#phone3').val().length > 3 ) {
					phoneOk = true;
					joinBtnEnable();
				} else {
					phoneOk = false;
					joinBtnEnable();
				}
			});
			
			$('#phone2').keyup(function() {
				if($('#phone2').val() != '') {
					if($('#phone2').val().length == 4) {
						$('#phoneCheckMsg').html('');
						$('#phone2').focusout();
						$('#phone3').focus();
						phoneOk = false;
						joinBtnEnable();
					} else if (!$.isNumeric($('#phone2').val()) || $('#phone2').val().length > 4 ||
							$('select[name=phone1] option:selected').val() == '<fmt:message key="join.choose"/>') {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="join.wrongPhone"/>');
						phoneOk = true;
						joinBtnEnable();
					} else if(($('#phone3').val() != '' && !$.isNumeric($('#phone3').val())) ||
							($('#phone3').val() != '' && (3 > $('#phone3').val().length && 
									$('#phone3').val().length > 4))) {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="join.wrongPhone"/>');
						phoneOk = true;
						joinBtnEnable();
					}
				}
			});
			$('#phone3').keyup(function() {
				if($('#phone3').val() != '') {
					if($('#phone3').val().length == 4) {
						$('#phoneCheckMsg').html('');
						phoneOk = false;
						joinBtnEnable();
					} else if (!$.isNumeric($('#phone3').val()) || $('#phone3').val().length > 4 ||
							$('select[name=phone1] option:selected').val() == '<fmt:message key="join.choose"/>') {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="join.wrongPhone"/>');
						phoneOk = true;
						joinBtnEnable();
					} else if(($('#phone2').val() != '' && !$.isNumeric($('#phone2').val())) ||
							($('#phone2').val() != '' && (3 > $('#phone2').val().length && 
									$('#phone2').val().length > 4))) {
						$('#phoneCheckMsg').removeClass('highlightOk');
						$('#phoneCheckMsg').addClass('highlightNo');
						$('#phoneCheckMsg').html('<fmt:message key="join.wrongPhone"/>');
						phoneOk = true;
						joinBtnEnable();
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
			joinBtnEnable();
		}
	}

	$(function() {
		$(':input:radio[name=mem_country]').change(function() {
			phoneInput();
		});
		
		//아이디 확인 버튼을 누를 시
		$('#btnIdCheck').click(function() {
			if(6 <= $('#mem_id').val().length && $('#mem_id').val().length <= 20) {
				$.ajax({
					method:'POST',
					url:'./idCheck',
					data:{id:$('#mem_id').val()}
				}).done(function(id) {
					if(id.id != null) {
						alert('<fmt:message key="join.joinedId"/>');
						idOk = true;
						joinBtnEnable();
					} else {
						alert('<fmt:message key="join.joinOkId"/>');
						idOk = false;
						joinBtnEnable();
					}
				});
			} else {
				alert('<fmt:message key="join.idLengthMsg"/>');
				idOk = true;
				joinBtnEnable();
				return;
			}
		});
		
		//비밀번호 확인을 입력할 시
		$('#mem_pwCheck').keyup(function() {
			if($('#mem_pw').val() != '') {
				if(10 <= $('#mem_pw').val().length && $('#mem_pw').val().length <= 20) {
					if($('#mem_pwCheck').val() != '') {
						if($('#mem_pwCheck').val() == $('#mem_pw').val()) {
							$('#pwCheckMsg').removeClass('highlightNo');
							$('#pwCheckMsg').addClass('highlightOk');
							$('#pwCheckMsg').html('<fmt:message key="join.pwMatched"/>');
							pwCheckOk = false;
							joinBtnEnable();
						} else {
							$('#pwCheckMsg').removeClass('highlightOk');
							$('#pwCheckMsg').addClass('highlightNo');
							$('#pwCheckMsg').html('<fmt:message key="join.pwNoMatch"/>');
							pwCheckOk = true;
							joinBtnEnable();
						}
					}
					pwOk = false;
					joinBtnEnable();
				} else {
					alert('<fmt:message key="join.pwLengthMsg"/>');
					$('#mem_pwCheck').val('');
					pwOk = true;
					joinBtnEnable();
				}
			}
		});
		
		//비밀번호 확인 질문 선택
		$('#pwQuestionSelect').change(function() {
			if($('#pwQuestionSelect option:selected').val() != '<fmt:message key="join.chooseQ"/>') {
				document.getElementById('mem_pwquestion').disabled = false;				
				if($('#pwQuestionSelect option:selected').val() != '<fmt:message key="join.choose6"/>')
					$('#mem_pwquestion').val($('#pwQuestionSelect option:selected').val());
				pwQOk = false;
				joinBtnEnable();
			} else {
				document.getElementById('mem_pwquestion').disabled = true;
				pwQOk = true;
				joinBtnEnable();
			}
		});
		
		//이메일 도메인 선택
		$('#emailSelect').change(function() {
			if($('#emailSelect option:selected').val() != '<fmt:message key="join.emailChoose"/>') {
				document.getElementById('email2').disabled = false;	
				emailOk = true;
				joinBtnEnable();
				if($('#emailSelect option:selected').val() != '<fmt:message key="join.emailChoose7"/>')
					$('#email2').val($('#emailSelect option:selected').val());
				emailOk = false;
				joinBtnEnable();
			} else {
				document.getElementById('email2').disabled = true;
				emailOk = true;
				joinBtnEnable();
			}
		});
		
		//닉네임 입력 시
		$('#mem_nick').keyup(function() {
			if($('#mem_nick').val().length > 0) {
				if($('#mem_nick').val().length > 10) {
					$('#nickCheckMsg').removeClass('highlightOk');
					$('#nickCheckMsg').addClass('highlightNo');
					$('#nickCheckMsg').html('<fmt:message key="join.nickLengthMsg"/>');
					nickOk = true;
					joinBtnEnable();
				} else {
					$.ajax({
						method:'POST',
						url:'./nickCheck',
						data:{nick:$('#mem_nick').val()}
					}).done(function(nick) {
						if(nick.nick != null) {
							$('#nickCheckMsg').removeClass('highlightOk');
							$('#nickCheckMsg').addClass('highlightNo');
							$('#nickCheckMsg').html('<fmt:message key="join.joinedNick"/>');
							nickOk = true;
							joinBtnEnable();
						} else {
							$('#nickCheckMsg').removeClass('highlightNo');
							$('#nickCheckMsg').addClass('highlightOk');
							$('#nickCheckMsg').html('<fmt:message key="join.nickOkUse"/>');
							nickOk = false;
							joinBtnEnable();
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
			joinBtnEnable();
		});
		
		//프로필 사진 삭제 버튼 클릭 시
		$('#deletePic').click(function() {
			$('#nickCheckMsg').html('');
			if($('#profilePic').attr('src', '<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>')) {
				return;
			} else {
				$('#profilePic').attr('src', '<c:url value="/resources/img/thumbnail/thumb_defaultpic.jpg"/>');
				$('#mem_pic').val('');
			}
			joinBtnEnable();
		});
	});
	
	//조건사항이 모두 충족 시, 가입하기 버튼 enabled
	function joinBtnEnable() {
		if(pwOk == false && pwCheckOk == false && pwQOk == false && engOk == false &&
				 emailOk == false && nickOk == false) {
			document.getElementById('joinOk').disabled = false;
			$('#joinOk').removeClass('button_style_02');
			$('#joinOk').addClass('button_style_01');
		} else {
			document.getElementById('joinOk').disabled = true;
			$('#joinOk').removeClass('button_style_01');
			$('#joinOk').addClass('button_style_02');
		}
	}
</script>
</fmt:bundle>
</head>