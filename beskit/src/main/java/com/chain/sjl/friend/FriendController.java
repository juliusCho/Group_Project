package com.chain.sjl.friend;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chain.sjl.member.MemberVO;

@Controller
@RequestMapping("friend/{mem_no}/")
public class FriendController {
	private static Logger logger= LoggerFactory.getLogger(FriendController.class);
	
	@Autowired
	private FriendService friendService;
	
	@RequestMapping("/")
	public ModelAndView friendList(@PathVariable long mem_no){	
		List<MemberVO> list = new ArrayList<MemberVO>();
		ModelAndView mav = new ModelAndView();
		try {
			//친구목록
			list = friendService.getFriendList(mem_no);
			mav.setViewName("friend/list");
			mav.addObject("list",list);
			
			//친구 요청목록
			List<MemberVO> waitingList = friendService.getWaitingFriends(mem_no);
			mav.addObject("waitingList",waitingList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value="getLoginMemberList", method=RequestMethod.GET,
		headers="Accept=application/json;charset=UTF-8",
		produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody	
	public List<MemberVO> getLoginMember(@PathVariable long mem_no, HttpSession session, HttpServletRequest request) throws Exception{
		List<MemberVO> list = new ArrayList<MemberVO>();
		list = friendService.getFriendList(mem_no);
		Enumeration eNames= request.getAttributeNames();
		if(eNames.hasMoreElements()){
			while(eNames.hasMoreElements()){ 
				String name =(String) eNames.nextElement().toString();
			}
		}
		return null;
	}
	
	@RequestMapping(value="findFriend", method=RequestMethod.GET)
	public String findFriend(){
		return "friend/findFriend";
	}
	
	@RequestMapping(value="findFriend", method=RequestMethod.POST,
			headers="Accept=application/json;charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody	
	public MemberVO findFriendAction(@RequestParam String mem_id) throws Exception{
		MemberVO memberVO= new MemberVO();
		memberVO=friendService.findFriend(mem_id);
		return memberVO;
	}
	
	@RequestMapping(value="getFriendInfo", method=RequestMethod.GET)
	public ModelAndView getFreindInfo(@RequestParam String mem_id, @PathVariable long mem_no) throws Exception{
		MemberVO memberVO = friendService.getFriendInfo(mem_id);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("friend/friendInfo");
		mav.addObject("memberVO",memberVO);
		return mav;
	}
	
	@RequestMapping(value="insertWaitingFriend", method=RequestMethod.GET,
			headers="Accept=application/json;charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public Map<String, String> insertWaitingFriend(@RequestParam long mymem_no, @PathVariable long mem_no, HttpSession session) {
		long waiting_fri_no = mem_no;
		
		Map<String,String> myMap = new HashMap<String,String>();
		try {
			Map<String, Long> map = new HashMap<String, Long>();
			map.put("waiting_fri_no",waiting_fri_no);
			map.put("mymem_no", mymem_no);
			
			List<MemberVO> list = friendService.getFriendList(mymem_no);
			for(MemberVO items: list){
				if(items.getMem_no()==waiting_fri_no){
					if(String.valueOf(session.getAttribute("country")).equals("ko_KR"))
						throw new RuntimeException("이미 등록된 친구입니다!");
					else throw new RuntimeException("This person is already your friend!");
				}
			}
			friendService.insertWaitingFriend(map);
			
			myMap.put("msg","Success");
			return myMap;
		} catch (Exception e) {
			myMap.put("msg", e.getMessage());
			return myMap;
		}
	}
	
	@RequestMapping("waitingFriends")
	public ModelAndView waitingFriends(@PathVariable long mem_no) throws Exception{
		List<MemberVO> waitingList = friendService.getWaitingFriends(mem_no);
		
		return new ModelAndView("friend/list","waitingList", waitingList);
	}
	
	@RequestMapping(value="acceptFriend", method=RequestMethod.GET,
			headers="Accept=application/json;charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public int acceptFriend(@RequestParam long waiting_fri_no, @PathVariable long mem_no) throws Exception{
		int result=0;
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("waiting_fri_no", waiting_fri_no);
		map.put("mem_no", mem_no);
		
		int first = friendService.acceptFriend(map);
		int second= friendService.acceptFriend2(map);
		
		result =first+second;
		return result;
	}
	
	@RequestMapping(value="deleteWaitingFriend", method=RequestMethod.GET,
			headers="Accept=application/json;charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public int deleteWaitingFriend(@PathVariable long mem_no, @RequestParam long waiting_fri_no) throws Exception{
		int result=0;
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("waiting_fri_no", waiting_fri_no);
		map.put("mem_no", mem_no);
		
		result = friendService.deleteWaitingFriend(map);
		return result;
	}
	
	@RequestMapping(value="deleteFriend", method=RequestMethod.GET,
			headers="Accept=application/json;charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public int deleteFriend(@RequestParam long mymem_no, @PathVariable long mem_no) throws Exception{
		long fri_no=mem_no;
		int result=0;
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("fri_no", fri_no);
		map.put("mymem_no", mymem_no);
		
		int first = friendService.deleteFriend(map);
		int second=friendService.deleteFriend2(map);
		
		result = first+second;
		return result;
	}
	
}
