package com.gdu.semi.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.service.UserService;

public class KeepLoginInterceptor implements HandlerInterceptor {

	@Autowired
	private UserService userService;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 로그인이 되어 있지 않은 경우 + 쿠키에 keepLogin이 있는 경우 => 로그인 유지 동작(자동 로그인)
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) {
			
			// 스프링에서는 특정 쿠키를 가져올 수 있음
			Cookie cookie = WebUtils.getCookie(request, "keepLogin");
			if(cookie != null) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("sessionId", cookie.getValue());
				
				UserDTO loginUser = userService.getUserBySessionId(map);
				if(loginUser != null) {
					session.setAttribute("loginUser", loginUser);
				}
				
			}
			
		}
		
		return true;  
		
	}
	
}