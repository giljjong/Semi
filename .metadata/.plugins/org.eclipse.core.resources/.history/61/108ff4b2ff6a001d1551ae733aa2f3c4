package com.gdu.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.semi.service.UploadBoardService;

@Controller
public class UploadBoardController {
	
	@Autowired
	private UploadBoardService uploadBoardService;
	
	@GetMapping("/")
	public String welcome() {
		return "index";
	}
	
	@GetMapping("/upload/list")
	public String list(Model model) {
		model.addAttribute("uploadList", uploadBoardService.getUpLoadList());
		return "upload/list";
	}
}
