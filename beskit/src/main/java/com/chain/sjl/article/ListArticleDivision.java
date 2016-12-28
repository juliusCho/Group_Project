package com.chain.sjl.article;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class ListArticleDivision implements Serializable {
	
	@Autowired
	private ArticleService articleService;
	
	@Value("${article.displayNumber}")
	private int displayArtNumber;
	
	@Value("${comment.displayNumber}")
	private int displayComNumber;
	
	private long mem_no;
	private long moreArtBtnNo;
	private long articleCount;
	private long art_no;
	private long moreComBtnNo;
	private long commentCount;
	private List<ArticleVO> artList;
	private List<CommentVO> comList;
	
	public List<ArticleVO> listArticle(long mem_no, int moreArtBtnNo) throws Exception {
		this.mem_no = mem_no;
		this.moreArtBtnNo = moreArtBtnNo;
		setArtList(articleService.listArticle(mem_no));			
		List<ArticleVO> list = new ArrayList<ArticleVO>();		
		
		if(getArtList().size() <= displayArtNumber) return getArtList();
		if(getArtList().size() % displayArtNumber != 0) {
			if(getArtList().size() > ((moreArtBtnNo + 1) * displayArtNumber)) {
				setArticleCount((moreArtBtnNo + 1) * displayArtNumber);
			} else {
				setArticleCount((getArtList().size() % displayArtNumber) + ((moreArtBtnNo + 1) * displayArtNumber) - displayArtNumber);
			}
		} else {
			setArticleCount((moreArtBtnNo + 1) * displayArtNumber);
		}
		for(int i=0; i<getArticleCount(); i++) {
			list.add(getArtList().get(i));
		}
		return list;
	}
	
	public List<CommentVO> listComment(long art_no, int moreComBtnNo) throws Exception {
		this.art_no = art_no;
		this.moreComBtnNo = moreComBtnNo;
		
		setComList(articleService.listComment(art_no));			
		List<CommentVO> list = new ArrayList<CommentVO>();		
		
		if(getComList().size() <= displayComNumber) {
			for(int i=getComList().size()-1; i>=0; i--) {
				list.add(getComList().get(i));
			}
			return list;
		}
		if(getComList().size() % displayComNumber != 0) {
			if(getComList().size() > ((moreComBtnNo + 1) * displayComNumber)) {
				setCommentCount((moreComBtnNo + 1) * displayComNumber);
			} else {
				setCommentCount((getComList().size() % displayComNumber) + ((moreComBtnNo + 1) * displayComNumber) - displayComNumber);
			}
		} else {
			setCommentCount((moreComBtnNo + 1) * displayComNumber);
		}
		for(int i=(int)(getCommentCount()-1); i>=0; i--) {
			list.add(getComList().get(i));
		}
		return list;
	}

	
	
	
	
	
	public long getArticleCount() {
		return articleCount;
	}

	public void setArticleCount(long articleCount) {
		this.articleCount = articleCount;
	}

	public long getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(long commentCount) {
		this.commentCount = commentCount;
	}

	public List<ArticleVO> getArtList() {
		return artList;
	}

	public void setArtList(List<ArticleVO> artList) {
		this.artList = artList;
	}

	public List<CommentVO> getComList() {
		return comList;
	}

	public void setComList(List<CommentVO> comList) {
		this.comList = comList;
	}

	@Override
	public String toString() {
		return "ListArticleDivision [articleService=" + articleService + ", displayArtNumber=" + displayArtNumber
				+ ", displayComNumber=" + displayComNumber + ", mem_no=" + mem_no + ", moreArtBtnNo=" + moreArtBtnNo
				+ ", articleCount=" + articleCount + ", art_no=" + art_no + ", moreComBtnNo=" + moreComBtnNo
				+ ", commentCount=" + commentCount + ", artList=" + artList + ", comList=" + comList + "]";
	}
}
