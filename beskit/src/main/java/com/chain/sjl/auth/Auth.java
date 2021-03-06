package com.chain.sjl.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.GenericFilterBean;

import com.chain.sjl.member.MemberVO;

public class Auth extends GenericFilterBean {
	private static Logger logger = LoggerFactory.getLogger(Auth.class);

	public void doFilter(ServletRequest srequest, ServletResponse sresponse, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) srequest;
		HttpServletResponse response = (HttpServletResponse) sresponse;
		
		HttpSession session = request.getSession();
		MemberVO memberVO = new MemberVO();
		
		StringTokenizer st = new StringTokenizer(request.getRequestURI(), "/");
		List<String> list = new ArrayList<String>();
		while(st.hasMoreTokens()) {
			list.add(st.nextToken());
		}
		
		if(list.size() == 1) {
			chain.doFilter(request, response);
			return;
		} else if(list.size() == 2) {
			chain.doFilter(request, response);
			return;
		} else {
			if(list.get(1).equals("resources")) {
				chain.doFilter(request, response);
				return;
			} else if(list.get(1).equals("member") && (list.get(2).equals("login") || list.get(2).equals("join") ||
					list.get(2).equals("findid") || list.get(2).equals("findpw") || list.get(2).equals("insertPic") ||
					list.get(2).equals("inputPic") || list.get(2).equals("idCheck") || list.get(2).equals("nickCheck") ||
					list.get(2).equals("idCheck") || list.get(2).equals("joinFinal") || list.get(2).equals("find_id") ||
					list.get(2).equals("find_id2") || list.get(2).equals("find_pw") || list.get(2).equals("confirm_pwquestion") ||
					list.get(2).equals("findAndChange_pw") || list.get(2).equals("find_list") ||
					list.get(2).equals("newMessage") || list.get(2).equals("kor") || list.get(2).equals("eng") ||
					list.get(2).equals("sendmail") || list.get(2).equals("privacy") || list.get(2).equals("policy"))) {
				chain.doFilter(request, response);
				return;
			}
			if(session.getAttribute("memberInfo") != null) {
				memberVO = (MemberVO) session.getAttribute("memberInfo");
				
				if(list.get(1).equals("article") || list.get(1).equals("square")) {
					if(!list.get(2).equals(String.valueOf(memberVO.getMem_no()))) {
						logger.info("비정상적 접속 감지");
						if(String.valueOf(session.getAttribute("country")).equals("ko_KR"))
							request.setAttribute("msg", "다른 회원의 관련 페이지는 접근 불가능합니다");
						else request.setAttribute("msg", "You cannot access to other users&#39; relational pages");
						request.setAttribute("url", "/sjl/article/" + memberVO.getMem_no() + "/");
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/result.jsp");
						dispatcher.forward(request, response);
						return;
					}
					chain.doFilter(request, response);
					return;
				} else if(list.get(1).equals("chat") || list.get(1).equals("chatlist")) {
					if(!list.get(2).equals(String.valueOf(memberVO.getMem_no()))) {
						logger.info("비정상적 접속 감지");
						if(String.valueOf(session.getAttribute("country")).equals("ko_KR"))
							request.setAttribute("msg", "다른 회원의 채팅방은 접근 불가능합니다");
						else request.setAttribute("msg", "You cannot access to others' CHAT");
						request.setAttribute("url", "/sjl");
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/result.jsp");
						dispatcher.forward(request, response);
						return;
					}
					chain.doFilter(request, response);
					return;
				} else if(list.get(1).equals("user")) {
					if(!list.get(2).equals(String.valueOf(memberVO.getMem_no()))) {
						logger.info("비정상적 접속 감지");
						if(String.valueOf(session.getAttribute("country")).equals("ko_KR"))
							request.setAttribute("msg", "잘못된 접근입니다");
						else request.setAttribute("msg", "Access denied");
						request.setAttribute("url", "/sjl");
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/result.jsp");
						dispatcher.forward(request, response);
						return;
					}
					chain.doFilter(request, response);
					return;
				} else {
					chain.doFilter(request, response);
					return;
				}
			} else {
				logger.info("비정상적 접속 감지");
				if(String.valueOf(session.getAttribute("country")).equals("ko_KR"))
					request.setAttribute("msg", "먼저 로그인을 하셔야 합니다");
				else request.setAttribute("msg", "You MUST login first");
				request.setAttribute("url", "/sjl/member/login");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/result.jsp");
				dispatcher.forward(request, response);
				return;
			}
		}
	}
}
