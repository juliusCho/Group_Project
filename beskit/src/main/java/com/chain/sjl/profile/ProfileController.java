package com.chain.sjl.profile;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.chain.sjl.member.FileVO;
import com.chain.sjl.member.MemberVO;

import net.coobird.thumbnailator.Thumbnails;

@RestController
@RequestMapping("profile/{mem_no}")
public class ProfileController {
	
	private static Logger logger = LoggerFactory.getLogger(ProfileController.class);
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private ListProfileDivision listDivision;
	
	@Value("${article.url}")
	private String articleUrl;
	
	@RequestMapping("/")
	public ModelAndView myPageList(@PathVariable long mem_no, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("profile/list");
		
		MemberVO memberBasicInfo =profileService.getMemberInfo(mem_no);
		mav.addObject("memberBasicInfo",memberBasicInfo);
		
		MemberVO memberVO= (MemberVO) session.getAttribute("memberInfo");
		long mymem_no = memberVO.getMem_no();
		
		List<MemberVO> list = profileService.getFriendList(mymem_no);
		int result =0;
		for(MemberVO vo : list ){
			if(vo.getMem_no()==mem_no){
				result=1;
			}
		}
		mav.addObject("result",result);
		mav.addObject("pageMem_no", mem_no);
		
		int waitingfriend = profileService.getWaitingCount(mymem_no);
		mav.addObject("waitingfriend",waitingfriend);
		
		Map<String, Long> map = new HashMap<String, Long>();
		long waiting_fri_no = mem_no;
		map.put("mem_no", mymem_no);
		map.put("waiting_fri_no", waiting_fri_no);
		int checkwaitingfriend= profileService.checkWaitingFriend(map);
		mav.addObject("checkwaitingfriend",checkwaitingfriend);
		
		return mav;
	}
	
	@RequestMapping(value="listArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public List<ArticleVO> listArticle(@PathVariable long mem_no, @RequestParam int moreArtBtnNo) throws Exception {
		return listDivision.listArticle(mem_no, moreArtBtnNo);
	}
	
	@RequestMapping(value="checkArtLike", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int checkArtLike(@RequestParam long art_no, @PathVariable long mem_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO.setArt_no(art_no);
		articleVO.setMem_no(mem_no);
		return profileService.checkArtLike(articleVO);
	}
	
	@RequestMapping(value="insertImg", method=RequestMethod.GET)
	public ModelAndView insertImg() {
		return new ModelAndView("article/insertImg");
	}
	
	@RequestMapping(value = "insertImg", method = RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public Map<String, String> insertImg(@ModelAttribute FileVO fileVO) throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		CommonsMultipartFile cmf = fileVO.getUpFile();
		if (cmf == null) {
			map.put("imageName", "fail");
			return map;
		}
		if (cmf.getSize() > 50000000) {
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
		
		File file = new File(articleUrl, imageName);
		try {
			cmf.transferTo(file);
		} catch (FileNotFoundException e) {
			createImgDir();
			cmf.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
        File thum = new File(articleUrl + "/img_" + imageName);
        if(isImage) {
            Thumbnails.of(file).size(400, 1000).outputFormat(extention).toFile(thum);
        }
        file.delete();
        map.put("url", "./inputPic/img_" + imageName);
		map.put("imageName", "img_" + imageName);
		return map;
	}
	private void createImgDir() {
		File dir = new File(articleUrl);
		if(!dir.exists()) {
			dir.mkdirs();
		}
	}
	
	@RequestMapping(value="insertArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int insertArticle(@ModelAttribute ArticleVO articleVO, @PathVariable long mem_no) throws Exception {
		articleVO.setMem_no(mem_no);
		return profileService.insertArticle(articleVO);
	}
	
	@RequestMapping(value="updateArticle", method=RequestMethod.GET)
	public ModelAndView updateArticle() {
		return new ModelAndView("article/update");
	}
	
	@RequestMapping(value="getArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ArticleVO getArticle(@RequestParam long art_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO = profileService.getArticle(art_no);
		return articleVO;
	}
	
	@RequestMapping(value="updateArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int updateArticle(@ModelAttribute ArticleVO articleVO) throws Exception {
		return profileService.updateArticle(articleVO);
	}
	
	@RequestMapping(value="deleteArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int deleteArticle(@RequestParam long art_no) throws Exception {
		return profileService.deleteArticle(art_no);
	}
	
	@RequestMapping(value="likeArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int likeArticle(@RequestParam long art_no, @PathVariable long mem_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO.setArt_no(art_no);
		articleVO.setMem_no(mem_no);
		return profileService.likeArticle(articleVO);
	}
	
	@RequestMapping(value="hateArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int hateArticle(@RequestParam long art_no, @PathVariable long mem_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO.setArt_no(art_no);
		articleVO.setMem_no(mem_no);
		return profileService.hateArticle(articleVO);
	}
	
	
	
//	==================================댓글==================================
	
	@RequestMapping(value="{art_no}", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public List<CommentVO> listComment(@PathVariable long art_no, @RequestParam int moreComBtnNo) throws Exception {
		return listDivision.listComment(art_no, moreComBtnNo);
	}
	
	@RequestMapping(value="{art_no}/checkComLike", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int checkComLike(@PathVariable long art_no, @PathVariable long mem_no,
			@RequestParam long com_no) throws Exception {
		CommentVO commentVO = new CommentVO();
		commentVO.setArt_no(art_no);
		commentVO.setCom_no(com_no);
		commentVO.setMem_no(mem_no);
		return profileService.checkComLike(commentVO);
	}
	
	@RequestMapping(value="{art_no}/insertComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int insertComment(@ModelAttribute CommentVO commentVO) throws Exception {
		return profileService.insertComment(commentVO);
	}
	
	@RequestMapping(value="{art_no}/updateComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int updateComment(@ModelAttribute CommentVO commentVO) throws Exception {
		return profileService.updateComment(commentVO);
	}
	
	@RequestMapping(value="{art_no}/deleteComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int deleteComment(@PathVariable long art_no, @RequestParam long com_no) throws Exception {
		CommentVO commentVO = new CommentVO();
		commentVO.setArt_no(art_no);
		commentVO.setCom_no(com_no);
		return profileService.deleteComment(commentVO);
	}
	
	@RequestMapping(value="{art_no}/likeComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int likeComment(@PathVariable long art_no, @RequestParam long com_no,
			@PathVariable long mem_no) throws Exception {
		CommentVO commentVO = new CommentVO();
		commentVO.setArt_no(art_no);
		commentVO.setCom_no(com_no);
		commentVO.setMem_no(mem_no);
		return profileService.likeComment(commentVO);
	}
	
	@RequestMapping(value="{art_no}/hateComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int hateComment(@PathVariable long art_no, @RequestParam long com_no,
			@PathVariable long mem_no) throws Exception {
		CommentVO commentVO = new CommentVO();
		commentVO.setArt_no(art_no);
		commentVO.setCom_no(com_no);
		commentVO.setMem_no(mem_no);
		return profileService.hateComment(commentVO);
	}

}
