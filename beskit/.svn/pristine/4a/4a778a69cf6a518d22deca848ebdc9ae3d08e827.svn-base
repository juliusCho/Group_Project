package com.chain.sjl.square;

import java.util.List;

import com.chain.sjl.member.MemberVO;

public interface SquareDAO {

	List<ArticleVO> listArticle(MemberVO memberVO) throws Exception;

	int likeArticle(ArticleVO articleVO) throws Exception;

	int hateArticle(ArticleVO articleVO) throws Exception;

	void upComcnt(long art_no) throws Exception;
	
	void downComcnt(long art_no) throws Exception;

	List<CommentVO> listComment(long art_no) throws Exception;

	int insertComment(CommentVO commentVO) throws Exception;

	int deleteComment(CommentVO commentVO) throws Exception;

	int likeComment(CommentVO commentVO) throws Exception;

	int hateComment(CommentVO commentVO) throws Exception;

	int updateComment(CommentVO commentVO) throws Exception;
	
	void insertArtLike(ArticleVO articleVO);

	void deleteArtLike(ArticleVO articleVO);

	int checkArtLike(ArticleVO articleVO) throws Exception;

	int checkComLike(CommentVO commentVO) throws Exception;

	void insertComLike(CommentVO commentVO) throws Exception;

	void deleteComLike(CommentVO commentVO) throws Exception;
}
