package com.chain.sjl.profile;

import java.util.List;
import java.util.Map;

import com.chain.sjl.member.MemberVO;

public interface ProfileService {

	List<ArticleVO> listArticle(long mem_no) throws Exception;

	int insertArticle(ArticleVO articleVO) throws Exception;

	int likeArticle(ArticleVO articleVO) throws Exception;

	int hateArticle(ArticleVO articleVO) throws Exception;

	int deleteArticle(long art_no) throws Exception;
	
	List<CommentVO> listComment(long art_no) throws Exception;

	int insertComment(CommentVO commentVO) throws Exception;

	int deleteComment(CommentVO commentVO) throws Exception;

	int likeComment(CommentVO commentVO) throws Exception;

	int hateComment(CommentVO commentVO) throws Exception;

	ArticleVO getArticle(long art_no) throws Exception;

	int updateComment(CommentVO commentVO) throws Exception;

	int updateArticle(ArticleVO articleVO) throws Exception;

	int checkArtLike(ArticleVO articleVO) throws Exception;

	int checkComLike(CommentVO commentVO) throws Exception;
	
	
	
	

	MemberVO confirm_pw_submit(MemberVO memberVO) throws Exception;

	List<MemberVO> getFriendList(long mymem_no) throws Exception;

	MemberVO getMemberInfo(long mem_no) throws Exception;

	int getWaitingCount(long mymem_no) throws Exception;

	int checkWaitingFriend(Map<String, Long> map) throws Exception;




}
