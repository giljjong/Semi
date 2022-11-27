package com.gdu.semi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.AttachDTO;
import com.gdu.semi.domain.UploadBoardDTO;
import com.gdu.semi.domain.UserDTO;

@Mapper
public interface UploadBoardMapper {
	public List<UploadBoardDTO> selectUploadList();
	public int updateHit(int uploadBoardNo);
	
	public int insertUpload(UploadBoardDTO upload);
	public int insertAttach(AttachDTO attach);
	public int updatePoint(String id);
	
	public UploadBoardDTO selectUploadByNo(int uploadBoardNo);
	public List<AttachDTO> selectAttachList(int uploadBoardNo);
	
	public int updateDownloadCnt(int attachNo);
	public AttachDTO selectAttachByNo(int uploadBoardNo);
	public int updateUpload(UploadBoardDTO upload);
	
	public int deleteAttach(int attachNo);
	public int deleteUpload(int uploadBoardNo);
	public List<AttachDTO> selectAttachListInYesterday();
	
}
