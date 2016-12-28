package com.chain.sjl.chat;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chain.sjl.chatlist.ChatListVO;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDAO chatDAO;

	@Override
	public void insertContent(ChatVO chatVO) throws Exception {
		chatDAO.insertContent(chatVO);
	}

	@Override
	public List<ChatVO> getChatList(long cha_list_no) throws Exception {
		return chatDAO.getChatList(cha_list_no);
	}

	@Override
	public void updateRegdate(long cha_list_no) throws Exception {
		chatDAO.updateRegdate(cha_list_no);
	}

	@Override
	public int checkMateChatRoom(Map<String, Long> map) throws Exception {
		return chatDAO.checkMateChatRoom(map);
	}

	@Override
	public void insertChatList(ChatListVO chatListVO) throws Exception {
		chatDAO.insertChatList(chatListVO);
	}

	@Override
	public void updateConfirm(Map<String, Long> map) throws Exception {
		chatDAO.updateConfirm(map);
	}

	

}
