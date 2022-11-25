package com.gdu.semi.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.AttachDTO;
import com.gdu.semi.domain.UploadBoardDTO;
import com.gdu.semi.mapper.UploadBoardMapper;
import com.gdu.semi.util.MyFileUtil;


@Service
public class UploadBoardServiceImpl implements UploadBoardService {

	
	@Autowired
	UploadBoardMapper uploadBoardMapper;
	
	@Autowired
	private MyFileUtil myFileUtil;
	
	@Override
	public ResponseEntity<Object> getUpLoadList() {
		
		List<UploadBoardDTO> uploadList = uploadBoardMapper.selectUploadList();
		
//		HttpHeaders header = new HttpHeaders();
//		header.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);
//		Map<String, Object> result = new HashMap<>();
//		result.put("uploadList", uploadList);
		
		return new ResponseEntity<Object>(uploadList , HttpStatus.OK) ;
	}
	
	
	@Transactional
	@Override
	public ResponseEntity<Object> save(MultipartHttpServletRequest multipartreRequest, HttpServletResponse response) {
		
		String title = multipartreRequest.getParameter("title");
		String content = multipartreRequest.getParameter("content");
		String ip = multipartreRequest.getRemoteAddr();
		String id = "admin" ;
		
	
		
		UploadBoardDTO upload = UploadBoardDTO.builder()
				.uploadTitle(title)
				.uploadContent(content)
				.ip(ip)
				.id(id)
				.build();
		
	
		
		int uploadResult = uploadBoardMapper.insertUpload(upload);
		
		List<MultipartFile> files = multipartreRequest.getFiles("files");
	
		
		int attachResult = 0;
		
//		if(uploadResult > 0 && attachResult > 0) {
//			System.out.println(uploadResult);
//			System.out.println(attachResult);
//			int result = uploadBoardMapper.updatePoint(id);
//			System.out.println("포인트 적립 성공" + result);
//		}
		
		if(files.get(0).getSize() == 0) {
			attachResult = 1;
		} else {
			attachResult = 0;
		}
		
		for(MultipartFile multipartFile : files) {
			try {
				if(multipartFile != null && multipartFile.isEmpty() == false ) {
					
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1); 
					
					String filesystem = myFileUtil.getFilename(origin);
					
					String path = myFileUtil.getTodayPath();
					
					File dir =new File(path);
					if(dir.exists() == false ) {
						dir.mkdirs();
					}
					
					File file = new File(dir, filesystem);
					
					multipartFile.transferTo(file);
					
					AttachDTO attach = AttachDTO.builder()
							.path(path)
							.origin(origin)
							.filesystem(filesystem)
							.uploadBoardNo(upload.getUploadBoardNo())
							.build();
					
					attachResult += uploadBoardMapper.insertAttach(attach);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		ResponseEntity<Object> entity = null;
		if(uploadResult > 0 && attachResult == files.size()) {
			entity = new ResponseEntity<Object>(HttpStatus.OK);  // $.ajax()의 success에서 처리
		} else {
			entity = new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);  // $.ajax()의 error에서 처리
		}
		
		
//		try {
//			response.setContentType("text/html; charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			
//			if(uploadResult > 0 && attachResult == files.size()) {
//				out.println("<script>");
//				out.println("alert('업로드 되었습니다.');");
//				out.println("location.href='" + multipartreRequest.getContextPath() + "/upload/list'");
//				out.println("</script>");
//			} else {
//				out.println("<script>");
//				out.println("alert('업로드 실패했습니다.');");
//				out.println("history.back();");
//				out.println("</script>");
//			}
//			out.close();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		return entity;
	}
	
	@Override
	public void getUploadByNo(int uploadBoardNo, Model model) {
		uploadBoardMapper.updateHit(uploadBoardNo); // 히트 새로고침도 됨 클릭시만 히트되게 
		model.addAttribute("upload", uploadBoardMapper.selectUploadByNo(uploadBoardNo));
		model.addAttribute("attachList", uploadBoardMapper.selectAttachList(uploadBoardNo) );
	}
	
	@Override
	public ResponseEntity<Resource> download(String userAgent, int attachNo) {
		
		AttachDTO attach = uploadBoardMapper.selectAttachByNo(attachNo);
		File file = new File(attach.getPath(), attach.getFilesystem());
		
		Resource resource = new FileSystemResource(file);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		uploadBoardMapper.updateDownloadCnt(attachNo);
		
		String origin = attach.getOrigin();
		try {
			
			if(userAgent.contains("Trident")) {
				origin = URLEncoder.encode(origin, "UTF-8" ).replaceAll("\\+", " ");
			}
			else if(userAgent.contains("Edg")) {
				origin = URLEncoder.encode(origin, "UTF-8");
			} else {
				origin = new String(origin.getBytes("UTF-8"), "ISO-8859-1");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Disposition", "attachment; filename=" + origin);
		header.add("Content-Length", file.length() + "");
		
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
		
				
	}
	
	@Override
	public ResponseEntity<Resource> downloadAll(String userAgent, int uploadBoardNo) {
		System.out.println(uploadBoardNo);
		List<AttachDTO> attachList = uploadBoardMapper.selectAttachList(uploadBoardNo);
		
		FileOutputStream fout = null;
		ZipOutputStream zout = null;
		FileInputStream fin = null;
		
		String tmpPath = "storage" + File.separator + "temp";
		
		File tmpDir = new File(tmpPath);
		if(tmpDir.exists() == false) {
			tmpDir.mkdirs();
		}
		
		String tmpName = System.currentTimeMillis() + ".zip";
		
		try {
			
			fout = new FileOutputStream(new File(tmpPath, tmpName));
			zout = new ZipOutputStream(fout);
			
			if(attachList != null && attachList.isEmpty() == false) {
				for(AttachDTO attach : attachList) {
					
					ZipEntry zipEntry = new ZipEntry(attach.getOrigin());
					zout.putNextEntry(zipEntry);
					
					fin = new FileInputStream(new File(attach.getPath(),attach.getFilesystem()));
					byte[] buffer = new byte[1024];
					int length;
					while((length = fin.read(buffer))!= -1) {
						zout.write(buffer, 0 , length);
					}
					zout.closeEntry();
					fin.close();
					
					uploadBoardMapper.updateDownloadCnt(attach.getAttachNo());
				}
				
				zout.close();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		File file = new File(tmpPath, tmpName);
		Resource resource = new FileSystemResource(file);
		
		if(resource.exists() == false ) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Disposition", "atachment; filename=" + tmpName);
		header.add("Content-Length", file.length() + "");
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	@Transactional
	@Override
	public void modifyUpload(MultipartHttpServletRequest mulRequest, HttpServletResponse response) {
		
		int uploadBoardNo = Integer.parseInt(mulRequest.getParameter("uploadBoardNo"));
		String title = mulRequest.getParameter("title");
		String content = mulRequest.getParameter("content");
		
		UploadBoardDTO upload = UploadBoardDTO.builder()
							.uploadBoardNo(uploadBoardNo)
							.uploadTitle(title)
							.uploadContent(content)
							.build();
		int uploadResult = uploadBoardMapper.updateUpload(upload);
		
		List<MultipartFile> files = mulRequest.getFiles("files");
		
		int attachResult;
		if(files.get(0).getSize() == 0) {
			attachResult = 1;
		} else {
			attachResult = 0;
		}
		
		for(MultipartFile multipartFile : files) {
			try {
				if(multipartFile != null && multipartFile.isEmpty() == false ) {
					
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1 );
					
					String filesystem = myFileUtil.getFilename(origin);
					
					String path = myFileUtil.getTodayPath();
					
					File dir = new File(path);
					if(dir.exists() == false ) {
						dir.mkdirs();
					}
					
					File file = new File(dir, filesystem);
					
					multipartFile.transferTo(file);
					
					AttachDTO attach = AttachDTO.builder()
							.path(path)
							.origin(origin)
							.filesystem(filesystem)
							.uploadBoardNo(uploadBoardNo)
							.build();
							
					attachResult += uploadBoardMapper.insertAttach(attach);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(uploadResult > 0 && attachResult == files.size()) {
				System.out.println("업로드 넘버 : " + uploadBoardNo );
				out.println("<script>");
				out.println("alert('수정되었습니다.')");
				out.println("location.href='" + mulRequest.getContextPath() + "/upload/detail?uploadBoardNo=" + uploadBoardNo + "'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('수정이 실패했습니다.')");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	@Override
	public void removeAttachByAttachNo(int attachNo) {
		
		AttachDTO attach = uploadBoardMapper.selectAttachByNo(attachNo);
		
		int result = uploadBoardMapper.deleteAttach(attachNo);
		
		if(result > 0) {
			File file = new File(attach.getPath(), attach.getFilesystem());
			
			if(file.exists()) {
				file.delete();
			}
		}
	}
	
	@Override
	public void removeUpload(HttpServletRequest request, HttpServletResponse response) {
		
		int uploadBoardNo = Integer.parseInt(request.getParameter("uploadBoardNo"));
		
		List<AttachDTO> attachList = uploadBoardMapper.selectAttachList(uploadBoardNo);
		
		int result = uploadBoardMapper.deleteUpload(uploadBoardNo);
		
		if(result > 0) {
			if(attachList != null && attachList.isEmpty() == false ) {
				for(AttachDTO attach : attachList) {
					File file = new File(attach.getPath(), attach.getFilesystem());
					if(file.exists()) {
						file.delete();
					}
				}
				
			}
		}
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0 ) {
				out.println("<script>");
				out.println("alert('삭제 되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/upload/list'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('삭제 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}