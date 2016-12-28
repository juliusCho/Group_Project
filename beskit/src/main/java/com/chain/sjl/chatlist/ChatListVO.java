package com.chain.sjl.chatlist;

public class ChatListVO {
	private long cha_list_no;
	private long mem_no;
	private String mem_nick;
	private String cha_list_regdate;
	private long cha_mate_no;
	private String mem_pic;
	private int newmsg;
	
	public long getCha_list_no() {
		return cha_list_no;
	}
	public void setCha_list_no(long cha_list_no) {
		this.cha_list_no = cha_list_no;
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
	public String getCha_list_regdate() {
		return cha_list_regdate;
	}
	public void setCha_list_regdate(String cha_list_regdate) {
		this.cha_list_regdate = cha_list_regdate;
	}
	public long getCha_mate_no() {
		return cha_mate_no;
	}
	public void setCha_mate_no(long cha_mate_no) {
		this.cha_mate_no = cha_mate_no;
	}
	public String getMem_pic() {
		return mem_pic;
	}
	public void setMem_pic(String mem_pic) {
		this.mem_pic = mem_pic;
	}
	public int getNewmsg() {
		return newmsg;
	}
	public void setNewmsg(int newmsg) {
		this.newmsg = newmsg;
	}
	@Override
	public String toString() {
		return "ChatListVO [cha_list_no=" + cha_list_no + ", mem_no=" + mem_no + ", mem_nick=" + mem_nick
				+ ", cha_list_regdate=" + cha_list_regdate + ", cha_mate_no=" + cha_mate_no + ", mem_pic=" + mem_pic
				+ ", newmsg=" + newmsg + "]";
	}
	
}
