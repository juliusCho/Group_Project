package com.chain.sjl.article;

import java.io.Serializable;

public class ArticleVO implements Serializable {

	private long art_no;
	private String art_content;
	private int art_like;
	private String art_regdate;
	private int art_com_cnt;
	private String art_pic;
	private long mem_no;
	private String mem_nick;
	
	public long getArt_no() {
		return art_no;
	}
	public void setArt_no(long art_no) {
		this.art_no = art_no;
	}
	public String getArt_content() {
		return art_content;
	}
	public void setArt_content(String art_content) {
		this.art_content = art_content;
	}
	public int getArt_like() {
		return art_like;
	}
	public void setArt_like(int art_like) {
		this.art_like = art_like;
	}
	public String getArt_regdate() {
		return art_regdate;
	}
	public void setArt_regdate(String art_regdate) {
		this.art_regdate = art_regdate;
	}
	public int getArt_com_cnt() {
		return art_com_cnt;
	}
	public void setArt_com_cnt(int art_com_cnt) {
		this.art_com_cnt = art_com_cnt;
	}
	public String getArt_pic() {
		return art_pic;
	}
	public void setArt_pic(String art_pic) {
		this.art_pic = art_pic;
	}
	public long getMem_no() {
		return mem_no;
	}
	public void setMem_no(long mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	
	@Override
	public String toString() {
		return "ArticleVO [art_no=" + art_no + ", art_content=" + art_content + ", art_like=" + art_like
				+ ", art_regdate=" + art_regdate + ", art_com_cnt=" + art_com_cnt
				+ ", art_pic=" + art_pic + ", mem_no=" + mem_no + ", mem_nick=" + mem_nick + "]";
	}
}
