<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<fmt:bundle basename="${sessionScope.basename}">
<script>
	//채팅방생성
	function makeChatRoom(cha_list_no) {
		var myForm = document.popForm;
		var url = '../../chat/${sessionScope.memberInfo.mem_no}/' + cha_list_no+ '/';
		window.open('', 'popForm',
				'toolbar=no,location=no,status=no,menubar=no,scrollbar=yes,'
						+ 'resizable=no,width=400,height=600');
		myForm.action = url;
		myForm.method = "post";
		myForm.target = "popForm";
		myForm.submit();
	}

	//채팅방목록생성
	function startChat() {
		$.ajax({
			method : 'POST',
			url : '../../chatlist/${sessionScope.memberInfo.mem_no}/insert',
			data : {
				mem_no : '${sessionScope.memberInfo.mem_no}',
				mem_nick : '${memberBasicInfo.mem_nick}',
				cha_mate_no : '${memberBasicInfo.mem_no}',
				mem_pic:'${memberBasicInfo.mem_pic}'
			}
		}).done(function(data) {
			if (data !== '') {
				makeChatRoom(data.cha_list_no);
			} else {
				alert('에러발생~!');
			}
		});
	}
</script>
</fmt:bundle>