package com.chain.sjl.article;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleDAO articleDAO;

	@Override
	public List<ArticleVO> listArticle(long mem_no) throws Exception {
		return articleDAO.listArticle(mem_no);
	}
	
	@Override
	public int checkArtLike(ArticleVO articleVO) throws Exception {
		return articleDAO.checkArtLike(articleVO);
	}

	@Override
	public int insertArticle(ArticleVO articleVO) throws Exception {
		return articleDAO.insertArticle(articleVO);
	}
	
	@Override
	public ArticleVO getArticle(long art_no) throws Exception {
		return articleDAO.getArticle(art_no);
	}
	
	@Override
	public int updateArticle(ArticleVO articleVO) throws Exception {
		return articleDAO.updateArticle(articleVO);
	}
	
	@Override
	public int likeArticle(ArticleVO articleVO) throws Exception {
		articleDAO.insertArtLike(articleVO);
		return articleDAO.likeArticle(articleVO);
	}

	@Override
	public int hateArticle(ArticleVO articleVO) throws Exception {
		articleDAO.deleteArtLike(articleVO);
		return articleDAO.hateArticle(articleVO);
	}

	@Override
	public int deleteArticle(long art_no) throws Exception {
		return articleDAO.deleteArticle(art_no);
	}
	
	@Override
	public List<CommentVO> listComment(long art_no) throws Exception {
		return articleDAO.listComment(art_no);
	}
	
	@Override
	public int checkComLike(CommentVO commentVO) throws Exception {
		return articleDAO.checkComLike(commentVO);
	}

	@Override
	public int insertComment(CommentVO commentVO) throws Exception {
		articleDAO.upComcnt((long)commentVO.getArt_no());
		return articleDAO.insertComment(commentVO);
	}
	
	@Override
	public int updateComment(CommentVO commentVO) throws Exception {
		return articleDAO.updateComment(commentVO);
	}

	@Override
	public int deleteComment(CommentVO commentVO) throws Exception {
		articleDAO.downComcnt((long)commentVO.getArt_no());
		return articleDAO.deleteComment(commentVO);
	}

	@Override
	public int likeComment(CommentVO commentVO) throws Exception {
		articleDAO.insertComLike(commentVO);
		return articleDAO.likeComment(commentVO);
	}

	@Override
	public int hateComment(CommentVO commentVO) throws Exception {
		articleDAO.deleteComLike(commentVO);
		return articleDAO.hateComment(commentVO);
	}
}
