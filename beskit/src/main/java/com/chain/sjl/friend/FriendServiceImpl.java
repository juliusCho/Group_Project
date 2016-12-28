package com.chain.sjl.friend;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chain.sjl.member.MemberVO;

@Service
public class FriendServiceImpl implements FriendService {

	@Autowired
	private FriendDAO friendDAO;

	@Override
	public List<MemberVO> getFriendList(long mem_no) throws Exception {
		return friendDAO.getFriendList(mem_no);
	}

	@Override
	public List<MemberVO> getLoginMemberList(long mem_no) throws Exception {
		return friendDAO.getLoginMemberList(mem_no);
	}

	@Override
	public MemberVO findFriend(String mem_id) throws Exception {
		return friendDAO.findFriend(mem_id);
	}

	@Override
	public MemberVO getFriendInfo(String mem_id) throws Exception {
		return friendDAO.getFriendInfo(mem_id);
	}

	@Override
	public void insertWaitingFriend(Map<String, Long> map) throws Exception {
		friendDAO.insertWaitingFriend(map);
	}

	@Override
	public List<MemberVO> getWaitingFriends(long mem_no) throws Exception {
		return friendDAO.getWaitingFriends(mem_no);
	}

	@Override
	public int acceptFriend(Map<String, Long> map) throws Exception {
		return friendDAO.acceptFriend(map);
	}

	@Override
	public int deleteWaitingFriend(Map<String, Long> map) throws Exception {
		return friendDAO.deleteWaitingFriend(map);
	}

	@Override
	public int acceptFriend2(Map<String, Long> map) throws Exception {
		return friendDAO.acceptFriend2(map);
	}

	@Override
	public int deleteFriend(Map<String, Long> map) throws Exception {
		return friendDAO.deleteFriend(map);
	}

	@Override
	public int deleteFriend2(Map<String, Long> map) throws Exception {
		return friendDAO.deleteFriend2(map);
	}


}
