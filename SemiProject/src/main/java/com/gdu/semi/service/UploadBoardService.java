package com.gdu.semi.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.UploadBoardDTO;

public interface UploadBoardService {
	
	public ResponseEntity<Object> getUpLoadList();
	public ResponseEntity<Object> save(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse response);
	
	public void getUploadByNo(int uploadBoardNo, Model model);
	
	public ResponseEntity<Resource> download(String userAgent, int attachNo);
	public ResponseEntity<Resource> downloadAll(String userAgent, int uploadBoardNo);
	public void modifyUpload(MultipartHttpServletRequest mulRequest, HttpServletResponse response);
	
	public void removeAttachByAttachNo(int attachNo);
	public void removeUpload(HttpServletRequest request,HttpServletResponse response );
}