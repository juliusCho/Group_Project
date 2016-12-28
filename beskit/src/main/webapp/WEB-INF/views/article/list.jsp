<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 리스트 스크립트 -->
<%@ include file="/resources/jsp/script/article_script.jsp" %>

<!-- 공통 헤더 -->
<%@ include file="/resources/jsp/header.jsp" %>

<!-- 리스트 왼쪽메뉴 -->
<%@ include file="/resources/jsp/left_menu/article_left.jsp" %>

<!-- 리스트  -->
   <div id="main_center">
   <fmt:bundle basename="${sessionScope.basename}">
      <table id="insert_text">
         <tr>
            <td id="info_text"><fmt:message key="home.artMsg"/></td>
         </tr>
         <tr class="picUpload" id="insertImg_text_td">
            <td valign="bottom">
               <a id="insertImg_text"  style="cursor:pointer;" onclick="location.href='javascript:insertImg();'">
                  <span class="ui-icon ui-icon-image"></span> <fmt:message key="home.addPic"/></a>
            </td>
         </tr>
         <tr>
            <td id="pic_input" align="center">
               <input type="hidden" id="art_pic"/>
            </td>
         </tr>
         <tr>
            <td id="text_box">
               <textarea cols="68" rows="5" id="art_content" wrap="hard"></textarea>
               <span id="artTextLength"></span>
            </td>
         </tr>
         <tr>
            <td id="btn_insert" align="right" valign="top">
               <input class="ui-button ui-widget ui-corner-all" type="button" value="<fmt:message key="home.post"/>" id="btnInsertArticle"/>
            </td>
         </tr>
      </table>
      </fmt:bundle>
      <div id="articleList"></div>
      <div id="articleForUpdate"></div>
      <div id="moreArtBtn"></div>
   </div>
<!-- 공통 우측메뉴 -->
<%@ include file="/resources/jsp/right_menu.jsp" %>		
		
<!-- 공통 풋터 -->
<%@ include file="/resources/jsp/footer.jsp" %>