package com.chain.sjl.profile;

import java.io.Serializable;

public class CommentVO implements Serializable {

	private long com_no;
	private String com_content;
	private String com_regdate;
	private int com_like;
	private long art_no;
	private long mem_no;
	private String mem_nick;
	
	public long getCom_no() {
		return com_no;
	}
	public void setCom_no(long com_no) {
		this.com_no = com_no;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	public String getCom_regdate() {
		return com_regdate;
	}
	public void setCom_regdate(String com_regdate) {
		this.com_regdate = com_regdate;
	}
	public int getCom_like() {
		return com_like;
	}
	public void setCom_like(int com_like) {
		this.com_like = com_like;
	}
	public long getArt_no() {
		return art_no;
	}
	public void setArt_no(long art_no) {
		this.art_no = art_no;
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
		return "CommentVO [com_no=" + com_no + ", com_content=" + com_content + ", com_regdate=" + com_regdate
				+ ", com_like=" + com_like + ", art_no=" + art_no + ", mem_no=" + mem_no + ", mem_nick=" + mem_nick
				+ "]";
	}
}
