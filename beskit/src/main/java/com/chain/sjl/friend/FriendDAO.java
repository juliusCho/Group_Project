package com.chain.sjl.friend;

import java.util.List;
import java.util.Map;

import com.chain.sjl.member.MemberVO;

public interface FriendDAO {

	List<MemberVO> getFriendList(long mem_no) throws Exception;

	List<MemberVO> getLoginMemberList(long mem_no) throws Exception;

	MemberVO findFriend(String mem_id) throws Exception;

	MemberVO getFriendInfo(String mem_id) throws Exception;

	void insertWaitingFriend(Map<String, Long> map) throws Exception;

	List<MemberVO> getWaitingFriends(long mem_no) throws Exception;

	int acceptFriend(Map<String, Long> map) throws Exception;

	int deleteWaitingFriend(Map<String, Long> map) throws Exception;

	int acceptFriend2(Map<String, Long> map) throws Exception;

	int deleteFriend(Map<String, Long> map) throws Exception;

	int deleteFriend2(Map<String, Long> map) throws Exception;


}
