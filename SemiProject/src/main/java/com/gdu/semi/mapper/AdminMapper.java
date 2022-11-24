package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.SleepUserDTO;
import com.gdu.semi.domain.UserDTO;

@Mapper
public interface AdminMapper {
	public List<UserDTO> selectUserList(Map<String, Object> map);
	public List<SleepUserDTO> selectSleepUserList();
	public int countUser();
	public int countSleepUser();
}
