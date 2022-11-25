package com.gdu.semi.controller;

import java.awt.PageAttributes.MediaType;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public String list() {
		return "upload/list";
	}

	@ResponseBody
	@GetMapping(value = "/upload/jlist", produces="application/json; charset=UTF-8")
	public ResponseEntity<Object> jsonList() {
		return uploadBoardService.getUpLoadList();
	}

	@GetMapping("/upload/write")
	public String write() {
		return "upload/write";
	}
	
	@ResponseBody
	@PostMapping("/upload/add")
	public ResponseEntity<Object> add(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		return uploadBoardService.save(multipartRequest, response);
	}
	
	@GetMapping("/upload/detail")
	public String detail(@RequestParam(value = "uploadBoardNo", required = false , defaultValue = "0" )int uploadBoardNo, Model model) {
		uploadBoardService.getUploadByNo(uploadBoardNo, model);
		return "upload/detail";
	}
	
	@ResponseBody
	@GetMapping("/upload/download")
	public ResponseEntity<Resource> download(@RequestHeader("User-Agent") String userAgent, @RequestParam("attachNo") int attachNo){
		System.out.println("userAgent  :   " + userAgent);
		return uploadBoardService.download(userAgent, attachNo);
	}
	
	@ResponseBody
	@GetMapping("/upload/downloadAll")
	public ResponseEntity<Resource> downloadAll(@RequestHeader("User-Agent") String userAgent, @RequestParam("uploadBoardNo") int uploadBoardNo){
		
		return uploadBoardService.downloadAll(userAgent, uploadBoardNo);
	}
	
	@PostMapping("/upload/edit")
	public String edit(@RequestParam("uploadBoardNo") int uploadBoardNo, Model model) {
		uploadBoardService.getUploadByNo(uploadBoardNo, model);
		return "upload/edit";
	}
	
	@PostMapping("/upload/modify")
	public void modify(MultipartHttpServletRequest mulRequest, HttpServletResponse response) {
		uploadBoardService.modifyUpload(mulRequest, response);
	}
	
	@GetMapping("/upload/attach/remove")
	public String attachRemove(@RequestParam("uploadBoardNo") int uploadBoardNo, @RequestParam("attachNo") int attachNo) {
		uploadBoardService.removeAttachByAttachNo(attachNo);
		return "redirect:/upload/detail?uploadNo=" + uploadBoardNo;
	}
	
	@PostMapping("/upload/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		uploadBoardService.removeUpload(request, response);
	}
	
}