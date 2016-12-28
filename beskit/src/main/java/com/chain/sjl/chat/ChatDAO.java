package com.chain.sjl.chat;

import java.util.List;
import java.util.Map;

import com.chain.sjl.chatlist.ChatListVO;

public interface ChatDAO {

	void insertContent(ChatVO chatVO) throws Exception;

	List<ChatVO> getChatList(long cha_list_no) throws Exception;

	void updateRegdate(long cha_list_no) throws Exception;

	int checkMateChatRoom(Map<String, Long> map) throws Exception;

	void insertChatList(ChatListVO chatListVO) throws Exception;

	void updateConfirm(Map<String, Long> map) throws Exception;

}
