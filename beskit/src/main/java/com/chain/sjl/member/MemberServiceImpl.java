package com.chain.sjl.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chain.sjl.article.ArticleVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;

	@Override
	public String idCheck(String id) throws Exception {
		return memberDAO.idCheck(id);
	}

	@Override
	public String nickCheck(String nick) throws Exception {
		return memberDAO.nickCheck(nick);
	}

	@Override
	public int joinFinal(MemberVO memberVO) throws Exception {
		return memberDAO.joinFinal(memberVO);
	}
	
	@Override
	public MemberVO login(MemberVO memberVO) throws Exception {
		MemberVO memberInfo = memberDAO.login(memberVO);
		if(memberInfo == null){
			throw new RuntimeException("Id or Pw is wrong. Please check your infomation");
		}
		return memberInfo;
	}

	@Override
	public List<MemberVO> find_id(MemberVO memberVO) throws Exception {
		return memberDAO.find_id(memberVO);
	}

	@Override
	public MemberVO find_pw(MemberVO memberVO) throws Exception {
		return memberDAO.find_pw(memberVO);
	}

	@Override
	public MemberVO cofirm_pwquestion(MemberVO memberVO) throws Exception {
		return memberDAO.cofirm_pwquestion(memberVO);
	}

	@Override
	public void findAndChange_pw(MemberVO memberVO) throws Exception {
		memberDAO.findAndChange_pw(memberVO);	
	}

	@Override
	public List<MemberVO> find_id2(String mem_email) throws Exception {
		return memberDAO.find_id2(mem_email);
	}

	@Override
	public MemberVO confirm_pw_submit(MemberVO memberVO) throws Exception {
		return memberDAO.confirm_pw_submit(memberVO);
	}

	@Override
	public int updateFinal(MemberVO memberVO) throws Exception {
		return memberDAO.updateFinal(memberVO);
	}

	@Override
	public int newMessage(long mem_no) throws Exception {
		return memberDAO.newMessage(mem_no);
	}

	@Override
	public void leaveAccount(long mem_no) throws Exception {
		memberDAO.leaveAccount(mem_no);
	}

	@Override
	public MemberVO getMemberInfo(String mem_id) throws Exception {
		return memberDAO.getMemberInfo(mem_id);
	}
}
