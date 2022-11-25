package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface AdminService {
	public Map<String, Object> findAllUsers(HttpServletRequest request);
	public Map<String, Object> findUsers(HttpServletRequest request);
}
