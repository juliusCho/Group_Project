<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<fmt:bundle basename="${sessionScope.basename}">
<script>
	//친구삭제
	function deleteFriend(){
	   var value= confirm('<fmt:message key="friend.delreally"/>');
	   if(value){
	      $.ajax({
	         method:'GET',
	         url:'../../friend/${mem_no}/deleteFriend',
	         data:{mymem_no:'${sessionScope.memberInfo.mem_no}'}
	      }).done(function(data){
	         if(data==2){
	            alert('<fmt:message key="friend.delsuccess"/>');
	            location.href="./";
	         }else{
	            alert('<fmt:message key="friend.error"/>');
	         }
	      });   
	   }else{
	      return;
	   }
	}
	
	//친구 추가(waiting list)
	function insertFriend(){
	   $.ajax({
	      method:'GET',
	      url:'../../friend/${mem_no}/insertWaitingFriend',
	      data:{mymem_no:'${sessionScope.memberInfo.mem_no}'}
	   }).done(function(data){
	      if(data.msg=='<fmt:message key="friend.success"/>'){
	         alert('<fmt:message key="friend.addsuccess"/>');
	         location.href="./";
	      }else{
	         alert('<fmt:message key="friend.waiting"/>');
	      }
	   });      
	}
</script>
</fmt:bundle>