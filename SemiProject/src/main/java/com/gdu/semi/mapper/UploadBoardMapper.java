package com.gdu.semi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.AttachDTO;
import com.gdu.semi.domain.UploadBoardDTO;

@Mapper
public interface UploadBoardMapper {
	public List<UploadBoardDTO> selectUploadList();
	public int insertUpload(UploadBoardDTO upload);
	public int insertAttach(AttachDTO attach);
}
