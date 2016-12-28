package com.chain.sjl.square;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chain.sjl.member.MemberVO;

@Service
public class SquareServiceImpl implements SquareService {

	@Autowired
	private SquareDAO squareDAO;

	@Override
	public List<ArticleVO> listArticle(MemberVO memberVO) throws Exception {
		return squareDAO.listArticle(memberVO);
	}
	
	@Override
	public int checkArtLike(ArticleVO articleVO) throws Exception {
		return squareDAO.checkArtLike(articleVO);
	}

	@Override
	public int likeArticle(ArticleVO articleVO) throws Exception {
		squareDAO.insertArtLike(articleVO);
		return squareDAO.likeArticle(articleVO);
	}

	@Override
	public int hateArticle(ArticleVO articleVO) throws Exception {
		squareDAO.deleteArtLike(articleVO);
		return squareDAO.hateArticle(articleVO);
	}
	
	@Override
	public List<CommentVO> listComment(long art_no) throws Exception {
		return squareDAO.listComment(art_no);
	}
	
	@Override
	public int checkComLike(CommentVO commentVO) throws Exception {
		return squareDAO.checkComLike(commentVO);
	}

	@Override
	public int insertComment(CommentVO commentVO) throws Exception {
		squareDAO.upComcnt((long)commentVO.getArt_no());
		return squareDAO.insertComment(commentVO);
	}
	
	@Override
	public int updateComment(CommentVO commentVO) throws Exception {
		return squareDAO.updateComment(commentVO);
	}

	@Override
	public int deleteComment(CommentVO commentVO) throws Exception {
		squareDAO.downComcnt((long)commentVO.getArt_no());
		return squareDAO.deleteComment(commentVO);
	}

	@Override
	public int likeComment(CommentVO commentVO) throws Exception {
		squareDAO.insertComLike(commentVO);
		return squareDAO.likeComment(commentVO);
	}

	@Override
	public int hateComment(CommentVO commentVO) throws Exception {
		squareDAO.deleteComLike(commentVO);
		return squareDAO.hateComment(commentVO);
	}
}
