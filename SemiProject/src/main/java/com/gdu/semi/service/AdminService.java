package com.gdu.semi.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface AdminService {
	public void findAllUsers(HttpServletRequest request, Model model);
	public void findAllSleepUsers(HttpServletRequest request, Model model);
}