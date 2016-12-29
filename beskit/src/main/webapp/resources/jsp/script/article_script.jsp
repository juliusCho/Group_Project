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
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/sub_main.css" />" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/jquery_ui/flick/jquery-ui.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery_ui/jquery-ui.js" />"></script>
<fmt:bundle basename="${sessionScope.basename}">
<script>
	var closeComment = '';
	var comUpdateDisplay = new Array(2);
	var textCount = 0;
	var previousArtText = '';
	var previousComText = '';
	var moreArtBtnNo;
	var moreComBtnNo;
	
	window.onload = function() {
		moreArtBtnNo = 0;
		moreComBtnNo = 0;
		articleList(moreArtBtnNo);
	}
	
	//최대 입력 글자수 제어
	$(function() {
		$('#artTextLength').html(textCount + '/600');
		$('#art_content').keyup(function() {
			textCount = $('#art_content').val().length;
			if(textCount > 600) {
				alert('게시글은 최대 600자 까지만 가능합니다');
				$('#art_content').val(previousArtText);
				textCount = previousArtText.length;
				return;
			}
			$('#artTextLength').html(textCount + '/600');
			previousArtText = $('#art_content').val();
		});
	});
		
	//게시물 목록
	function articleList(moreArtBtnNo) {
		$.ajax({
			method:'POST',
			url:'./listArticle',
			data:{moreArtBtnNo:moreArtBtnNo}
		}).done(function(list) {
			var articleList = '';
			if(list.length == 0) {
				articleList += '<h2 id="noArticleMsg"><fmt:message key="home.noArtMsg1"/></h2>';
				articleList += '<h2 id="noArticleMsg"><fmt:message key="home.noArtMsg2"/></h2>';	
				articleList += '<br/><br/><br/>';
			} else {
				$.each(list, function(key,val) {
					articleList += '<table id="list_table" align="center">';
					articleList += '<tr align="center">';
					articleList += '<td id="list_nick_td"><a href="../../profile/' + val['mem_no'] + '/">' + val['mem_nick'] + '</a><fmt:message key="home.artTitle"/>';
					articleList += '<span id="articleTitle">&nbsp&nbsp' + '<span class="ui-icon ui-icon-clock"></span>' + val['art_regdate'] + '<fmt:message key="home.regdateMsg"/></span>';
					articleList += '</td></tr>';
					
					//게시물에 사진이 첨부되어 있을 시
					if(val['art_pic'] != null && val['art_pic'] != '') {
						articleList += '<tr align="center" valign="top"><td id="view_img">';
						articleList += '<img src="<c:url value="/member/' + val['art_pic'] + '"/>" alt=""/>';
						articleList += '</td></tr>';
					}
					articleList += '<tr align="left">';
					articleList += '<td id="list_content">' + val['art_content'] + '</td>';
					articleList += '</tr>';
					
					//본인의 글일 시
					if(val['mem_no'] == '${sessionScope.memberInfo.mem_no}') {
						articleList += '<tr align="center">';
						articleList += '<td id="up_del_btn" align="right">';
						if(val['mem_nick'] == '${sessionScope.memberInfo.mem_nick}')
						articleList += '<input class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="home.update"/>" onclick="javascript:updateArticle(' + val['art_no'] + ');"/>';
						articleList += '<input class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="home.delete"/>" onclick="javascript:deleteArticle(' + val['art_no'] + ');"/>';
						articleList += '</td></tr>';
					}
					
					articleList += '</table>';
					articleList += '<table id="comment_close">';
					articleList += '<tr><td id="comment_number" align="center" valign="middle">';
					articleList += '<a href="javascript:likeArticle(' + val['art_no'] + ');">';
					articleList += '<span id="heart' + val['art_no'] + '">♥</span>' ;
					
					//하트가 클릭 되었을 시
					$.ajax({
						method:'POST',
						url:'./checkArtLike',
						data:{art_no:val['art_no']}
					}).done(function(result) {
						if(result != 0) {
							$('#heart' + val['art_no']).addClass('likeOk');
						}
					});
					
					articleList += '(' + val['art_like'] + ')</a>';
					articleList += '&nbsp&nbsp';
					articleList += '<a href="javascript:commentOpen(' + val['art_no'] + ',' + moreComBtnNo + ');"><fmt:message key="home.comment"/>(';
					articleList += val['art_com_cnt'] + ')<fmt:message key="home.quantity"/>';
					articleList += '</a>';
					articleList += '</td></tr>';
					articleList += '<tr><td id="comment">';
					articleList += '<div id="commentList' + val['art_no'] + '"></div>';
					articleList += '</td></tr>';
					articleList += '</table>';
					
					if(closeComment == val['art_no']) commentList(val['art_no'], moreComBtnNo);
				});
			}
			$('#articleList').html(articleList);
			
			//[더 보기] 버튼 보이기/감추기
			if(10 <= list.length && list.length % 10 == 0) {
				moreArtBtnNo++;
				$('#moreArtBtn').html('<input type="button" value="<fmt:message key="home.seemore"/>" align="center"' + 
						' onclick="javascript:moreArtClicked(' + moreArtBtnNo + ');" style="width:600px;"/>');
			} else {
				$('#moreArtBtn').html('');
			}
		});
	}
	
	//게시글 더 보기 버튼 누를 시
	function moreArtClicked(moreArtBtnNo) {
		articleList(moreArtBtnNo);
	}
	
	//사진 첨부
	function insertImg() {
		window.open('./insertImg', 'Image Inserting', 
				'toolbar=no, location=center, scrollbar=yes' +
				 'resizable=yes, width=500, height=500, left=500, top=250');
	}
	
	//글 입력을 누를 시
	$(function() {
		$('#btnInsertArticle').click(function() {
			textCount = 0;
			previousArtText = '';
			$('#artTextLength').html(textCount + '/600');
			if($('#art_pic').val() == '') $('#art_pic').val('');
			if($('#art_content').val() != '') {
				$.ajax({
					method:'POST',
					url:'./insertArticle',
					data:{
						art_content:$('#art_content').val(),
						art_pic:$('#art_pic').val(),
						mem_no:'${sessionScope.memberInfo.mem_no}',
						mem_nick:'${sessionScope.memberInfo.mem_nick}'
					}
				}).done(function(insertArticle) {
					$('#pic_input').html('<input type="hidden" id="art_pic"/>');
					$('#art_content').val('');
					if(insertArticle != null) articleList(moreArtBtnNo);
				});
			} else {
				alert('<fmt:message key="home.addcontentMsg"/>');
				return;
			}
		});
	});
	
	//글 수정을 누를 시
	function updateArticle(art_no) {
		window.open('./updateArticle', 'ArticleModification',
				'toolbar=no, location=center, scrollbar=yes' +
				'resizable=yes, width=600, height=800, left=400, top=50');
		$(function() {
			$('#articleForUpdate').html('<input type="hidden" id="articleUpdateNo" value="' + art_no + '"/>');
		});
	}
	
	//글 삭제를 누를 시
	function deleteArticle(art_no) {
		if(confirm('<fmt:message key="home.reallydelete"/>')) {
			$.ajax({
				method:'POST',
				url:'./deleteArticle',
				data:{art_no:art_no}
			}).done(function(result) {
				if(result != null) articleList(moreArtBtnNo);
			});
		}
	}
	
	//좋아요를 누를 시
	function likeArticle(art_no) {
		if(!$('#heart' + art_no).hasClass('likeOk')) {
			$.ajax({
				method:'POST',
				url:'./likeArticle',
				data:{art_no:art_no}
			}).done(function(like) {
				if(like != 0) articleList(moreArtBtnNo);
				$(window).ready(function() {
					if($('#commentList' + art_no).html() != '')
						commentList(art_no, moreComBtnNo);
				});
			});
		} else if($('#heart' + art_no).hasClass('likeOk')) {
			$.ajax({
				method:'POST',
				url:'./hateArticle', 
				data:{art_no:art_no}
			}).done(function(hate) {
				if(hate != 0) articleList(moreArtBtnNo);
				$(window).ready(function() {
					if($('#commentList' + art_no).html() != '')
						commentList(art_no, moreComBtnNo);
				});
			});
		}
	}
	
	//댓글 누를 시
	function commentOpen(art_no, moreComBtnNo) {
		$(function() {
			if($('#commentList' + art_no).html() == '') {
				commentList(art_no, moreComBtnNo);
				$('#commentList' + closeComment).html('');
				closeComment = art_no;
			} else {
				$('#commentList' + art_no).html('');
				closeComment = '';
			}
		});
	}
	
	//댓글 목록
	function commentList(art_no, moreComBtnNo) {
		$.ajax({
			method:'POST',
			url:'./' + art_no,
			data:{moreComBtnNo:moreComBtnNo}
		}).done(function(comment) {
			var commentList = '<table id="comment_open" align="center">';
			if(comment.length == 0) {
				commentList += '<tr><td colspan="3" align="center"><fmt:message key="home.firstCommentMsg"/></td></tr>';
			} else {			
				$.each(comment, function(key,val) {
					commentList += '<tr>';
					commentList += '<td id="comment_nick" align="center">' + val['mem_nick'] + '</td>';
					
					//댓글 수정을 누른 댓글
					if(comUpdateDisplay[0] == art_no && comUpdateDisplay[1] == val['com_no']) {
						commentList += '<td>';
						commentList += '<textarea type="text" rows="3" cols="54" id="com_contentChange">' + val['com_content'] + '</textarea>';
						commentList += '</td>';
						commentList += '<td align="center" id="regdate"">';
						commentList += '<a href="javascript:comChange(' + art_no + ');" id="articleTitle"><fmt:message key="home.update"/></a>&nbsp';
						commentList += '<a href="javascript:comChangeCancel(' + art_no + ');" id="articleTitle"><fmt:message key="home.cancel"/></a>';
						commentList += '</td>';
						commentList += '</tr>';
					
					} else {
						commentList += '<td id="comment_content">' + val['com_content'] + '<span style="float:right">';
						commentList += '<a href="javascript:likeComment(' + art_no + ',' + val['com_no'] + ');" id="articleTitle">';
						commentList += '<span  id="heart'  + art_no + '_' + val['com_no'] + '">♥</span>';
						commentList += '(' + val['com_like'] + ')</a>';
						
						//본인의 댓글일 시
						if(val['mem_no'] == '${sessionScope.memberInfo.mem_no}') {
							commentList += ' <a href="javascript:updateComment(' + art_no + ',' + val['com_no'] + ');" id="articleTitle">';
							commentList += '<fmt:message key="home.update"/></a> <a href="javascript:deleteComment(' + art_no + ',' + val['com_no'] + ');" id="articleTitle">';
							commentList += '<fmt:message key="home.delete"/></a></span>';
						}
						
						//하트가 클릭될 시
						$.ajax({
							method:'POST',
							url:'./' + art_no + '/checkComLike',
							data:{com_no:val['com_no']}
						}).done(function(result) {
							if(result != 0) $('#heart' + art_no + '_' + val['com_no']).addClass('likeOk');
							else $('#heart' + art_no + '_' + val['com_no']).removeClass('likeOk');
						});
						
						commentList += '</td>';
						commentList += '<td align="center" id="regdate">';
						commentList += '&nbsp&nbsp' + val['com_regdate'];
						commentList += '</td></tr>';
					}
				});
			}
			//[더 보기] 버튼 시작 
			commentList += '<tr>';
			commentList += '<td align="center" colspan="3"><span id="moreComBtn"></span><br/>';
			commentList += '</td></tr>';
			//[더 보기] 버튼 끝
			
			commentList += '<tr>';
			commentList += '<td id="insert_comment" align="center">${sessionScope.memberInfo.mem_nick}</td>';
			commentList += '<td id="insert_comment">';
			commentList += '<input type="text" name="com_content" id="com_content" size="52"/></td>';
			commentList += '<td id="insert_comment" align="center">';
			commentList += '<input type="button" onclick="javascript:insertComment(' + art_no + ')" value="<fmt:message key="home.addComment"/>"/>';
			commentList += '</td>';
			commentList += '</tr></table>';
			
			$('#commentList' + art_no).html(commentList);
			
			//[더 보기] 버튼 보이기/감추기
			if(20 <= comment.length && comment.length % 20 == 0) {
				moreComBtnNo++;
				$('#moreComBtn').html('<a style="cursor:pointer;" onclick="javascript:moreComClicked(' + art_no + ',' + moreComBtnNo + ');"><div id="more_btn">more(+20)</div></a>');
			} else {
				$('#moreComBtn').html('');
			}
			
			//댓글 글자수 제어
			$('#com_content').keyup(function() {
				if($('#com_content').val().length > 150) {
					alert('<fmt:message key="home.commentLength"/>');
					$('#com_content').val(previousComText);
					return;
				}
				previousComText = $('#com_content').val();
			});
			$('#com_contentChange').keyup(function() {
				if($('#com_contentChange').val().length > 150) {
					alert('<fmt:message key="home.commentLength"/>');
					$('#com_contentChange').val(previousComText);
					return;
				}
				previousComText = $('#com_content').val();
			});
		});
	}
	
	//댓글 더 보기 버튼 누를 시
	function moreComClicked(art_no, moreComBtnNo) {
		commentList(art_no, moreComBtnNo);
	}
	
	//댓글 입력을 누를 시
	function insertComment(art_no) {
		previousComText = '';
		if($('#com_content').val() != '') {
			$.ajax({
				method:'POST',
				url:'./' + art_no + '/insertComment',
				data:{
						art_no:art_no,
						com_content:$('#com_content').val(),
						mem_no:'${sessionScope.memberInfo.mem_no}' 
					}
			}).done(function(insert) { 
				if(insert != null) articleList(moreArtBtnNo);
			});
		} else {return;}
	}
	
	//댓글 수정을 누를 시
	function updateComment(art_no, com_no) {
		comUpdateDisplay[0] = art_no;
		comUpdateDisplay[1] = com_no;
		commentList(art_no, moreComBtnNo);
	}
	
	//댓글 수정 확인/취소
	function comChange(art_no) {
		if($('#com_contentChange').val() != '') {
			$.ajax({
				method:'POST',
				url:'./' + comUpdateDisplay[0] + '/updateComment',
				data:{
					art_no:comUpdateDisplay[0],					
					com_no:comUpdateDisplay[1],
					com_content:$('#com_contentChange').val()
				}
			}).done(function(result) {
				if(result != null) {
					comUpdateDisplay[0] = '';
					comUpdateDisplay[1] = '';
					articleList(moreArtBtnNo);
				}
			});
		} else {return;}
	}
	function comChangeCancel(art_no) {
		comUpdateDisplay[0] = '';
		comUpdateDisplay[1] = '';
		commentList(art_no, moreComBtnNo);
	}
	
	//댓글 삭제를 누를 시
	function deleteComment(art_no, com_no) {
		if(confirm('<fmt:message key="home.delComMsg"/>')) {
			$.ajax({
				method:'POST',
				url:'./' + art_no + '/deleteComment',
				data:{com_no:com_no}
			}).done(function(result) {
				if(result != null) articleList(moreArtBtnNo);
			});
		}
	}
	
	//댓글 좋아요를 누를 시
	function likeComment(art_no, com_no) {
		if(!$('#heart' + art_no + '_' + com_no).hasClass('likeOk')) {
			$.ajax({
				method:'POST',
				url:'./' + art_no + '/likeComment',
				data:{com_no:com_no}
			}).done(function(like) {
				if(like != 0) commentList(art_no, moreComBtnNo);
			});
		} else if($('#heart' + art_no + '_' + com_no).hasClass('likeOk')) {
			$.ajax({
				method:'POST',
				url:'./' + art_no + '/hateComment',
				data:{com_no:com_no}
			}).done(function(hate) {
				if(hate != 0) commentList(art_no, moreComBtnNo);
			});
		}
	}
</script>
</fmt:bundle>
</head>