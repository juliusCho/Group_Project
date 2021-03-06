package com.chain.sjl.chatlist;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chain.sjl.member.MemberVO;

@Controller
@RequestMapping("chatlist/{mem_no}")
public class ChatListController {
	private static Logger logger = LoggerFactory.getLogger(ChatListController.class);
	
	@Autowired
	private ChatListService chatListService;
	
	@RequestMapping("/")
	public ModelAndView chatList(@PathVariable long mem_no){
		
		ModelAndView mav = new ModelAndView("chatlist/list");
		try {
			List<ChatListVO> list = chatListService.getChatList(mem_no);
			for(ChatListVO vo : list){
				long cha_list_no = vo.getCha_list_no();
				Map<String, Long> map = new HashMap<String, Long>();
				map.put("cha_list_no", cha_list_no);
				map.put("mem_no", mem_no);
				int newmsg = chatListService.getNewMsg(map);
				vo.setNewmsg(newmsg);
				
				int userStatus = chatListService.checkUserStatus(vo.getCha_mate_no());
				if(userStatus==0){
					vo.setMem_nick("알수 없음");
					vo.setMem_pic(null);
				}
				
			}
			mav.addObject("list",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ChatListVO insertChatList(@ModelAttribute ChatListVO chatListVO) {
	
		
		//mem_no 만 내것~!
		long mem_no;
		long cha_mate_no;
		long cha_list_no;
		int status =0;
		
		mem_no= chatListVO.getMem_no();
		cha_mate_no=chatListVO.getCha_mate_no();
		cha_list_no=mem_no+cha_mate_no;
		
		try{
			status = chatListService.chatStatus(cha_list_no);
			if(status==0){
				chatListVO.setCha_list_no(cha_list_no);
				
				chatListService.insertChatList(chatListVO);
				MemberVO memberVO = chatListService.getMemberInfo(mem_no);
				if(memberVO.getMem_pic()==null){
					memberVO.setMem_pic("");
				}
				ChatListVO chatListVO2 = new ChatListVO();
				chatListVO2.setMem_no(chatListVO.getCha_mate_no());
				chatListVO2.setMem_nick(memberVO.getMem_nick());
				chatListVO2.setCha_mate_no(memberVO.getMem_no());
				chatListVO2.setMem_pic(memberVO.getMem_pic());
				chatListVO2.setCha_list_no(cha_list_no);
		
				chatListService.insertChatList2(chatListVO2);
			
				return chatListVO;
			}else if(status==1){
				ChatListVO vo = chatListService.checkChatList(cha_list_no);
				if(vo.getMem_no()==chatListVO.getMem_no()){
					//상대가 채팅방을 지운경우
					MemberVO memberVO = chatListService.getMemberInfo(mem_no);
					if(memberVO.getMem_pic()==null){
						memberVO.setMem_pic("");
					}
					
					ChatListVO chatListVO2 = new ChatListVO();
					chatListVO2.setMem_no(chatListVO.getCha_mate_no());
					chatListVO2.setMem_nick(memberVO.getMem_nick());
					chatListVO2.setCha_mate_no(memberVO.getMem_no());
					chatListVO2.setMem_pic(memberVO.getMem_pic());
					chatListVO2.setCha_list_no(cha_list_no);
			
					chatListService.insertChatList2(chatListVO2);
				}else{
					//내가 채팅방을 지운경우
					chatListVO.setCha_list_no(cha_list_no);
					chatListService.insertChatList(chatListVO);
				}
				return chatListVO;
			}else{
				chatListVO.setCha_list_no(cha_list_no);
				return chatListVO;	
			}
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	@RequestMapping(value="removeChatRoom", method=RequestMethod.GET,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public void removeChatRoom(@PathVariable long mem_no, @RequestParam long cha_mate_no) throws Exception{
		Map<String, Long> map  = new HashMap<String, Long>();
		map.put("mem_no", mem_no);
		map.put("cha_mate_no", cha_mate_no);
		chatListService.deleteChatRoom(map);
	}
	
	@RequestMapping(value="updateConfirm", method=RequestMethod.GET,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public void updateConfirm(@PathVariable long mem_no, @RequestParam long cha_mate_no) throws Exception{
		long cha_list_no= mem_no+cha_mate_no;
		Map<String, Long> map  = new HashMap<String, Long>();
		map.put("mem_no", cha_mate_no);
		map.put("cha_list_no", cha_list_no);
		chatListService.updateConfirm(map);
	}
}
