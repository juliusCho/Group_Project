package com.chain.sjl.profile;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chain.sjl.member.MemberVO;

@Service
public class ProfileServiceImpl implements ProfileService {

	@Autowired
	private ProfileDAO profileDAO;

	@Override
	public List<ArticleVO> listArticle(long mem_no) throws Exception {
		return profileDAO.listArticle(mem_no);
	}
	
	@Override
	public int checkArtLike(ArticleVO articleVO) throws Exception {
		return profileDAO.checkArtLike(articleVO);
	}

	@Override
	public int insertArticle(ArticleVO articleVO) throws Exception {
		return profileDAO.insertArticle(articleVO);
	}
	
	@Override
	public ArticleVO getArticle(long art_no) throws Exception {
		return profileDAO.getArticle(art_no);
	}
	
	@Override
	public int updateArticle(ArticleVO articleVO) throws Exception {
		return profileDAO.updateArticle(articleVO);
	}
	
	@Override
	public int likeArticle(ArticleVO articleVO) throws Exception {
		profileDAO.insertArtLike(articleVO);
		return profileDAO.likeArticle(articleVO);
	}

	@Override
	public int hateArticle(ArticleVO articleVO) throws Exception {
		profileDAO.deleteArtLike(articleVO);
		return profileDAO.hateArticle(articleVO);
	}

	@Override
	public int deleteArticle(long art_no) throws Exception {
		return profileDAO.deleteArticle(art_no);
	}
	
	@Override
	public List<CommentVO> listComment(long art_no) throws Exception {
		return profileDAO.listComment(art_no);
	}
	
	@Override
	public int checkComLike(CommentVO commentVO) throws Exception {
		return profileDAO.checkComLike(commentVO);
	}

	@Override
	public int insertComment(CommentVO commentVO) throws Exception {
		profileDAO.upComcnt((long)commentVO.getArt_no());
		return profileDAO.insertComment(commentVO);
	}
	
	@Override
	public int updateComment(CommentVO commentVO) throws Exception {
		return profileDAO.updateComment(commentVO);
	}

	@Override
	public int deleteComment(CommentVO commentVO) throws Exception {
		profileDAO.downComcnt((long)commentVO.getArt_no());
		return profileDAO.deleteComment(commentVO);
	}

	@Override
	public int likeComment(CommentVO commentVO) throws Exception {
		profileDAO.insertComLike(commentVO);
		return profileDAO.likeComment(commentVO);
	}

	@Override
	public int hateComment(CommentVO commentVO) throws Exception {
		profileDAO.deleteComLike(commentVO);
		return profileDAO.hateComment(commentVO);
	}
	
	
	
	

	@Override
	public MemberVO confirm_pw_submit(MemberVO memberVO) throws Exception {
		return profileDAO.confirm_pw_submit(memberVO);
		
	}

	@Override
	public List<MemberVO> getFriendList(long mymem_no) throws Exception {
		return profileDAO.getFriendList(mymem_no);
	}

	@Override
	public MemberVO getMemberInfo(long mem_no) throws Exception {
		return profileDAO.getMemberInfo(mem_no);
	}

	@Override
	public int getWaitingCount(long mymem_no) throws Exception {
		return profileDAO.getWaitingCount(mymem_no);
	}

	@Override
	public int checkWaitingFriend(Map<String, Long> map) throws Exception {
		return profileDAO.checkWaitingFriend(map);
	}
	
}
