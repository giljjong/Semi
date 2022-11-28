package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.AllUserDTO;
import com.gdu.semi.domain.RetireUserDTO;
import com.gdu.semi.domain.UserDTO;

@Mapper
public interface AdminMapper {
	public List<AllUserDTO> selectAllUserList(Map<String, Object> map);
	public int selectAllUserCountByQuery(Map<String, Object> map);
	public List<AllUserDTO> selectUsersByQuery(Map<String, Object> map);
	public int selectUserCountByQuery(Map<String, Object> map);
	public List<AllUserDTO> selectSleepUsersByQuery(Map<String, Object> map);
	public int selectSleepUserCountByQuery(Map<String, Object> map);
	public int deleteUser(String id);
	public int insertRetireUser(Map<String, Object> map);
	public int deleteSleepUser(String id);
	public int insertRestoreUser(String id);
}
