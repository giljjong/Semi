package com.gdu.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<UploadBoardDTO> getUpLoadList() {
		return uploadBoardMapper.selectUploadList();
	}
}
