package com.chain.sjl.square;

import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import com.chain.sjl.member.MemberVO;

@RestController
@RequestMapping("square/{mem_no}")
public class SquareController {

	private static final Logger logger = LoggerFactory.getLogger(SquareController.class);
	
	@Autowired
	private SquareService squareService;
	
	@Autowired
	private ListSquareDivision listDivision;
	
	@Value("${article.url}")
	private String articleUrl;
	
	@RequestMapping("/")
	public ModelAndView main() {
		return new ModelAndView("square/list");
	}
	
	@RequestMapping(value="listArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public List<ArticleVO> listArticle(@PathVariable long mem_no,
			@RequestParam int moreArtBtnNo, HttpSession session) throws Exception {
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		return listDivision.listArticle(mem_no, moreArtBtnNo, memberVO.getMem_country());
	}
	
	@RequestMapping(value="checkArtLike", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int checkArtLike(@RequestParam long art_no, @PathVariable long mem_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO.setArt_no(art_no);
		articleVO.setMem_no(mem_no);
		return squareService.checkArtLike(articleVO);
	}

	@RequestMapping(value="likeArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int likeArticle(@RequestParam long art_no, @PathVariable long mem_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO.setArt_no(art_no);
		articleVO.setMem_no(mem_no);
		return squareService.likeArticle(articleVO);
	}
	
	@RequestMapping(value="hateArticle", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int hateArticle(@RequestParam long art_no, @PathVariable long mem_no) throws Exception {
		ArticleVO articleVO = new ArticleVO();
		articleVO.setArt_no(art_no);
		articleVO.setMem_no(mem_no);
		return squareService.hateArticle(articleVO);
	}
	
	
	
//	==================================댓글==================================
	
	@RequestMapping(value="{art_no}", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public List<CommentVO> listComment(@PathVariable long art_no,
			@RequestParam int moreComBtnNo) throws Exception {
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
		return squareService.checkComLike(commentVO);
	}
	
	@RequestMapping(value="{art_no}/insertComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int insertComment(@ModelAttribute CommentVO commentVO) throws Exception {
		return squareService.insertComment(commentVO);
	}
	
	@RequestMapping(value="{art_no}/updateComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int updateComment(@ModelAttribute CommentVO commentVO) throws Exception {
		return squareService.updateComment(commentVO);
	}
	
	@RequestMapping(value="{art_no}/deleteComment", method=RequestMethod.POST,
			headers="Accept=application/json; charset=UTF-8",
			produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int deleteComment(@PathVariable long art_no, @RequestParam long com_no) throws Exception {
		CommentVO commentVO = new CommentVO();
		commentVO.setArt_no(art_no);
		commentVO.setCom_no(com_no);
		return squareService.deleteComment(commentVO);
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
		return squareService.likeComment(commentVO);
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
		return squareService.hateComment(commentVO);
	}
}
