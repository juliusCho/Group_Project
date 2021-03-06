package com.chain.sjl.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chain.sjl.chatlist.ChatListVO;

@Controller
@RequestMapping("chat/{mem_no}/{cha_list_no}")
public class ChatController {
	private static Logger logger= LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
	private ChatService chatService;
	
	@RequestMapping(value="/", method=RequestMethod.POST)
	public ModelAndView chatRoom2(@ModelAttribute ChatListVO chatListVO) throws Exception{
		ModelAndView mav = new ModelAndView("chatlist/chat/chatroom");
		long cha_list_no = chatListVO.getCha_list_no();
		long mem_no = chatListVO.getCha_mate_no();
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("cha_list_no", cha_list_no);
		map.put("mem_no", mem_no);
		chatService.updateConfirm(map);
		
		mav.addObject("chatListVO", chatListVO);
		
		return mav;
	}
	
	@RequestMapping(value="/loadChat", method=RequestMethod.GET,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public List<ChatVO> loadChat(@PathVariable long cha_list_no) throws Exception{
		ModelAndView mav = new ModelAndView("chatlist/chat/chatroom");
		mav.addObject("cha_list_no",cha_list_no);
		List<ChatVO> list = chatService.getChatList(cha_list_no);
		
		return list;
	}

	
	@RequestMapping(value="insert", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public List<ChatVO> insert(@ModelAttribute ChatVO chatVO,@PathVariable long mem_no) throws Exception{
		logger.info("insert 수행중"+chatVO.toString());
		chatVO.setMem_no(mem_no);
		chatService.insertContent(chatVO);
		
		long cha_list_no = chatVO.getCha_list_no();
		chatService.updateRegdate(cha_list_no);
		
		List<ChatVO> list = chatService.getChatList(cha_list_no);
		return list;
	}
}
