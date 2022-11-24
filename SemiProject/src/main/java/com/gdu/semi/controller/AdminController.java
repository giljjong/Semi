package com.gdu.semi.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.semi.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/admin/menu")
	public String menu() {
		return "admin/menu";
	}
	
	@GetMapping("/admin/list/user")
	public String userList(HttpServletRequest request, Model model) {
		adminService.findAllUsers(request, model);
		return "admin/list/user";
	}
	
	@GetMapping("/admin/list/sleep")
	public String sleepList(HttpServletRequest request, Model model) {
		adminService.findAllSleepUsers(request, model);
		return "admin/list/sleep";
	}
	
	@GetMapping("/admin/list/free")
	public String freeList(HttpServletRequest request, Model model) {
		adminService.findAllSleepUsers(request, model);
		return "admin/list/free";
	}
	
	@GetMapping("/admin/list/gallery")
	public String galleryList(HttpServletRequest request, Model model) {
		adminService.findAllSleepUsers(request, model);
		return "admin/list/gallery";
	}
	
	@GetMapping("/admin/list/upload")
	public String uploadList(HttpServletRequest request, Model model) {
		adminService.findAllSleepUsers(request, model);
		return "admin/list/upload";
	}
	
}
