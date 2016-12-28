package com.chain.sjl.article;

import java.util.List;

public interface ArticleService {

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

}
