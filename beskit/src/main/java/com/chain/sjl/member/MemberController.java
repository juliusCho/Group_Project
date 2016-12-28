package com.chain.sjl.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	private static long PICNUM = 0;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private EmailSender emailSender;

	@Value("${thumbnail.url}")
	private String thumbnailUrl;
	
	@Value("${article.url}")
	private String articleUrl;
	
	@Value("${emoticon.url}")
	private String emoticonUrl;
	
	@RequestMapping("kor")
	public void kor(HttpSession session, HttpServletResponse response) throws IOException {
		session.setAttribute("country", "ko_KR");
		session.setAttribute("basename", "bundle.bundle_ko");
		response.sendRedirect("login");
	}
	
	@RequestMapping("eng")
	public void eng(HttpSession session, HttpServletResponse response) throws IOException {
		session.setAttribute("country", "en_US");
		session.setAttribute("basename", "bundle.bundle");
		response.sendRedirect("login");
	}

	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void join() {}

	@RequestMapping(value = "idCheck", method = RequestMethod.POST, headers = "Accept=application/json; charset=UTF-8", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public Map<String, String> idCheck(@RequestParam String id) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", memberService.idCheck(id));
		return map;
	}

	@RequestMapping(value = "nickCheck", method = RequestMethod.POST, headers = "Accept=application/json; charset=UTF-8", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public Map<String, String> nickCheck(@RequestParam String nick) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("nick", memberService.nickCheck(nick));
		return map;
	}
	
	@RequestMapping(value="insertPic", method=RequestMethod.GET)
	public void insertPic() {}

	@RequestMapping(value = "insertPic", method = RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public Map<String, String> insertPic(@ModelAttribute FileVO fileVO) throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		CommonsMultipartFile cmf = fileVO.getUpFile();
		
		if (cmf == null) {
			map.put("imageName", "fail");
			return map;
		}
		if (cmf.getSize() > 10485760) {
			map.put("imageName", "exceeded");
			return map;
		}
		boolean isImage = cmf.getContentType().substring(0, 6).toLowerCase().equals("image/");
		if (!isImage) {
			map.put("imageName", "notImg");
			return map;
		}
		String imageName = cmf.getOriginalFilename();
		String extention = imageName.substring(imageName.lastIndexOf(".") + 1);
		
		File file = new File(thumbnailUrl, imageName);
		try {
			cmf.transferTo(file);
		} catch (FileNotFoundException e) {
			createThumbDir();
			cmf.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
        File thum = new File(thumbnailUrl + "/thumb_" + PICNUM + "_" + imageName);
        if(isImage) {
            Thumbnails.of(file).size(150, 150).outputFormat(extention).toFile(thum);
        }
        file.delete();
        map.put("url", "./inputPic/thumb_" + PICNUM + "_" + imageName);
		map.put("imageName", "thumb_" + imageName);
		PICNUM++;
		return map;
	}
	private void createThumbDir() {
		File dir = new File(thumbnailUrl);
		if(!dir.exists()) {
			dir.mkdirs();
		}
	}
	
	@RequestMapping(value = "inputPic/{pic:.+}")
    public void download(@PathVariable String pic, HttpServletResponse response) throws IOException {
		String url = "";
		if(pic.substring(pic.lastIndexOf("/")+1,pic.lastIndexOf("/")+4).equals("thu")) {
			url = thumbnailUrl;
		} else if(pic.substring(pic.lastIndexOf("/")+1,pic.lastIndexOf("/")+4).equals("img")){
			url = articleUrl;
		} else if(pic.substring(pic.lastIndexOf("/")+1,pic.lastIndexOf("/")+4).equals("emo")) {
			url = emoticonUrl;
		}
		
		File img = new File(url, pic);
        
        response.setContentLength((int)img.length());
        response.setContentType("application/octet-stream"); // 파일 그대로 내보낼 때
        response.setHeader("Content-Disposition", "attachment;filename=" + URLDecoder.decode(pic, "UTF-8"));
        InputStream is = new FileInputStream(url + "/" + pic);
        OutputStream os = response.getOutputStream(); // 응답객체로 내보냄
        FileCopyUtils.copy(is, os);
        
        os.flush();
        if(os != null) try{ os.close(); } catch(Exception e) {}
        if(is != null) try{ is.close(); } catch(Exception e) {}
    }

	@RequestMapping(value = "join", method = RequestMethod.POST)
	public ModelAndView join(@ModelAttribute MemberVO memberVO, @RequestParam String phone1,
			@RequestParam String phone2, @RequestParam String phone3, @RequestParam String email1,
			@RequestParam String email2, @RequestParam String pw, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("member/joinConfirm");

		String pwhide = pw.trim().substring(0, 1);
		for (int i = 1; i < pw.trim().length(); i++) {
			pwhide += "*";
		}
		String phone = "";
		if(String.valueOf(session.getAttribute("country")).equals("ko_KR")) {
			if (memberVO.getMem_country() == 0) {
				phone = phone1 + "-" + phone2 + "-" + phone3;
				mav.addObject("phone", phone);
				mav.addObject("country", "한국인");
			} else {
				phone = "";
				mav.addObject("phone", phone);
				mav.addObject("country", "외국인");
			}
			if(memberVO.getMem_gender() == 0) {
				mav.addObject("gender", "남자");
			} else {
				mav.addObject("gender", "여자");
			}
		} else {
			if (memberVO.getMem_country() == 0) {
				phone = phone1 + "-" + phone2 + "-" + phone3;
				mav.addObject("phone", phone);
				mav.addObject("country", "Korean");
			} else {
				phone = "";
				mav.addObject("phone", phone);
				mav.addObject("country", "Foreigner");
			}
			if(memberVO.getMem_gender() == 0) {
				mav.addObject("gender", "Male");
			} else {
				mav.addObject("gender", "Female");
			}
		}
		mav.addObject("memberVO", memberVO);
		mav.addObject("pw", pw);
		mav.addObject("pwhide", pwhide);
		mav.addObject("phone1", phone1);
		mav.addObject("phone2", phone2);
		mav.addObject("phone3", phone3);
		mav.addObject("email1", email1);
		mav.addObject("email2", email2);
		return mav;
	}

	@RequestMapping("joinFinal")
	public ModelAndView joinFinal(@ModelAttribute MemberVO memberVO, HttpSession session) throws Exception {
		int result = memberService.joinFinal(memberVO);

		ModelAndView mav = new ModelAndView("result");
		if(String.valueOf(session.getAttribute("country")).equals("ko_KR")) {
			if (result == 1) {
				mav.addObject("msg", memberVO.getMem_nick() + "(" + memberVO.getMem_id() + ")" + "님, 가입을 축하드립니다!^^");
				mav.addObject("url", "./login");
			} else {
				mav.addObject("msg", "가입에 실패하였습니다");
				mav.addObject("url", "");
			}
		} else {
			if (result == 1) {
				mav.addObject("msg", memberVO.getMem_nick() + "(" + memberVO.getMem_id() + ")" + ", congratulations to be our member! :D");
				mav.addObject("url", "./login");
			} else {
				mav.addObject("msg", "Registration failed");
				mav.addObject("url", "");
			}
		}
		return mav;
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	   public String login(HttpSession session) {
			if(session.getAttribute("country") == null) {
				session.setAttribute("country", "ko_KR");
				session.setAttribute("basename", "bundle.bundle_ko");
			}
	      return "member/login";
	   }

	   @RequestMapping(value = "login", method = RequestMethod.POST)
	   public ModelAndView loginAction(@ModelAttribute MemberVO memberVO, HttpSession session) {
	      ModelAndView mav = new ModelAndView("result");
	      try {
	    	  if(String.valueOf(session.getAttribute("country")).equals("ko_KR")) {
		         MemberVO memberInfo = memberService.login(memberVO);
		         session.setAttribute("memberInfo", memberInfo);
		         mav.addObject("msg", "어서오세요, " + memberInfo.getMem_name() + "(" + memberInfo.getMem_id() + ")님!");
		         mav.addObject("url", "../article/" + memberInfo.getMem_no() + "/");
	    	  } else {
	    		  MemberVO memberInfo = memberService.login(memberVO);
	    		  session.setAttribute("memberInfo", memberInfo);
	    		  mav.addObject("msg", "Welcome, " + memberInfo.getMem_name() + "(" + memberInfo.getMem_id() + ")!");
	    		  mav.addObject("url", "../article/" + memberInfo.getMem_no() + "/");
	    	  }
	      } catch (Exception e) {
	         mav.addObject("msg", e.getMessage());
	         mav.addObject("url", "");
	      }
	      return mav;
	   }

	   @RequestMapping(value = "findid", method = RequestMethod.GET)
	   public String findid() {
	      return "member/findid";
	   }

	   @RequestMapping(value = "find_id", method = RequestMethod.GET, headers = "Accept=application/json;charset=UTF-8", produces = {
	         MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public List<MemberVO> find_id(@RequestParam String mem_name, @RequestParam String mem_phone1,
	         @RequestParam String mem_phone2, @RequestParam String mem_phone3) throws Exception {
	      String mem_phone = mem_phone1 + "-" + mem_phone2 + "-" + mem_phone3;
	      MemberVO memberVO = new MemberVO();
	      memberVO.setMem_phone(mem_phone);
	      memberVO.setMem_name(mem_name);
	      List<MemberVO> list = memberService.find_id(memberVO);

	      return list;
	   }
	   
	   @RequestMapping(value = "find_id2", method = RequestMethod.GET, headers = "Accept=application/json;charset=UTF-8", produces = {
	         MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public List<MemberVO> find_id2(@RequestParam String email1, @RequestParam String email2) throws Exception {
	      String mem_email=null;
	      mem_email= email1+"@"+email2;
	      
	      List<MemberVO> list =  memberService.find_id2(mem_email);
	      
	      return list;
	   }

	   @RequestMapping(value = "findpw", method = RequestMethod.GET)
	   public String findpw() {
	      return "member/findpw";
	   }

	   @RequestMapping(value = "find_pw", method = RequestMethod.GET, headers = "Accept=application/json;charset=UTF-8", produces = {
	         MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public MemberVO find_pw(@RequestParam String mem_id, @RequestParam String mem_name) throws Exception {
	      MemberVO memberVO = new MemberVO();
	      memberVO.setMem_id(mem_id);
	      memberVO.setMem_name(mem_name);

	      memberVO = memberService.find_pw(memberVO);
	      return memberVO;
	   }

	   @RequestMapping(value = "confirm_pwquestion", method = RequestMethod.POST, headers = "Accept=application/json;charset=UTF-8", produces = {
	         MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public MemberVO cofirm_pwquestion(@ModelAttribute MemberVO memberVO) throws Exception {

	      memberVO = memberService.cofirm_pwquestion(memberVO);

	      return memberVO;
	   }

	   @RequestMapping(value = "findAndChange_pw", method = RequestMethod.POST, headers = "Accept=application/json;charset=UTF-8", produces = {
	         MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public void findAndChange_pw(@ModelAttribute MemberVO memberVO) throws Exception {
	      memberService.findAndChange_pw(memberVO);
	   }
	   
	   @RequestMapping("logout")
	   public ModelAndView logout(HttpSession session){
	      MemberVO memberInfo= (MemberVO) session.getAttribute("memberInfo");
	      ModelAndView mav = new ModelAndView("result");
	      if(String.valueOf(session.getAttribute("country")).equals("ko_KR")) {
	    	  mav.addObject("msg",memberInfo.getMem_name()+"("+memberInfo.getMem_id()+")"+"님이 로그아웃 하였습니다.");
	      } else {
	    	  mav.addObject("msg",memberInfo.getMem_name()+"("+memberInfo.getMem_id()+")"+" has been logged out.");
	      }
	      mav.addObject("url","../");
	      
	      session.invalidate();
	      return mav;
	   }
	   
	   @RequestMapping(value="newMessage", method = RequestMethod.POST, 
			   				   headers="Accept=application/json;charset=UTF-8",
			   				   produces={MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public int newMessage(@RequestParam long mem_no) throws Exception{
		   int result=0;
		   result=memberService.newMessage(mem_no);
		   return result;
	   }
	   
		@RequestMapping(value = "sendmail", method = RequestMethod.POST, 
				   headers="Accept=application/json;charset=UTF-8",
				   produces={MediaType.APPLICATION_JSON_UTF8_VALUE })
		@ResponseBody
		public int sendEmail(@RequestParam String mem_id, HttpSession session) {
			MemberVO memberVO = new MemberVO();
			try {
				memberVO = memberService.getMemberInfo(mem_id);
				EmailVO emailVO = new EmailVO();
				String reciver = memberVO.getMem_email();
				StringBuilder content = new StringBuilder();
				
		        content.append((char) (Math.floor(Math.random()*10)+48));	//숫자 0~9
		        content.append((char) (Math.floor(Math.random()*10)+48));	//숫자 0~9
		        content.append((char) (Math.floor(Math.random()*26)+97));	//알파벳 a~z
		        content.append((char) (Math.floor(Math.random()*26)+65));	//알파벳 A~Z
		        content.append((char) (Math.floor(Math.random()*10)+48));	//숫자 0~9
		        content.append((char) (Math.floor(Math.random()*26)+65));	//알파벳 A~Z
		        content.append((char) (Math.floor(Math.random()*26)+65));	//알파벳 A~Z
		        content.append((char) (Math.floor(Math.random()*26)+97));	//알파벳 a~z
		        content.append((char) (Math.floor(Math.random()*26)+97));	//알파벳 a~z
		        content.append((char) (Math.floor(Math.random()*26)+65));	//알파벳 A~Z
		        content.append((char) (Math.floor(Math.random()*10)+48));	//숫자 0~9
		        
		        memberVO.setMem_pw(content.toString());
		        memberService.findAndChange_pw(memberVO);
		        
		        emailVO.setReceiver(reciver);
		        String subject = "";
		        if(String.valueOf(session.getAttribute("country")).equals("ko_KR")) {
			        subject = "[BeSkit] 임시비밀번호 발송 메일 입니다.";
			        emailVO.setContent("요청하신 계정 임시 비밀번호는 아래와 같습니다." + "\n\n"  + "비밀번호 : " + 
			        content.toString()+"\n\n"+"임시비밀번호 확인후 회원정보에서 비밀번호를 변경해주세요.");
		        } else {
		        	subject = "[BeSkit] Temporary Password Sender";
		        	emailVO.setContent("The requested account's temporary password is as follows :" + "\n\n"  + "Password : " + 
		        	content.toString()+"\n\n"+"Please check the temporary password and change your password at Personal Information Page.");
		        }
		        emailVO.setSubject(subject);
		        emailSender.SendEmail(emailVO);
		        
		        return 1;
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}
		
		@RequestMapping("privacy")
		public void privacy() {}

		@RequestMapping("policy")
		public void policy() {}
}