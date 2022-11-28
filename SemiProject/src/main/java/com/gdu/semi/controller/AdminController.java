package com.gdu.semi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String User() {
		return "admin/list/user";
	}
	
	@ResponseBody
	@GetMapping(value="/admin/list/allUsers", produces="application/json; charset=UTF-8")
	public Map<String, Object> userList(HttpServletRequest request){
		return adminService.findAllUsers(request);
	}
	
	@ResponseBody
	@GetMapping(value="/admin/list/searchUsers", produces="application/json; charset=UTF-8")
	public Map<String, Object> searchUserList(HttpServletRequest request){
		return adminService.findUsers(request);
	}
	
	@GetMapping("/admin/list/board")
	public String boardList(HttpServletRequest request) {
		return "admin/list/board";
	}
	
	@ResponseBody
	@PostMapping(value="/admin/user/retire", produces="application/json; charset=UTF-8")
	public Map<String, Object> retireUser(HttpServletRequest request) {
		return adminService.retireUser(request);
	}
	
	@ResponseBody
	@PostMapping(value="/admin/user/restore", produces="application/json; charset=UTF-8")
	public Map<String, Object> restoreUser(HttpServletRequest request) {
		return adminService.restoreUser(request);
	}
	
	@ResponseBody
	@PostMapping(value="/admin/user/dormant", produces="application/json; charset=UTF-8")
	public Map<String, Object> dormantUser(HttpServletRequest request) {
		return adminService.dormantUser(request);
	}
	
}