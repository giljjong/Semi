package com.gdu.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.semi.domain.AllUserDTO;
import com.gdu.semi.domain.SleepUserDTO;
import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.mapper.AdminMapper;
import com.gdu.semi.util.PageUtil;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Override
	public Map<String, Object> findAllUsers(HttpServletRequest request) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		Map<String, Object> map = new HashMap<>();
		int totalRecord = adminMapper.selectAllUserCountByQuery(map);
		int sleepUserCnt = adminMapper.selectSleepUserCountByQuery(map);
		
		pageUtil.setPageUtil(page, totalRecord);

		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		List<AllUserDTO> users = adminMapper.selectAllUserList(map);
		
		Map<String, Object> result = new HashMap<>();
		if(users.size() == 0) {
			result.put("message", "조회된 결과가 없습니다.");
			result.put("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
			result.put("totalRecord", totalRecord);
			result.put("sleepUserCnt", sleepUserCnt);
			result.put("status", 500);
		} else {
			result.put("users", users);
			result.put("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
			result.put("totalRecord", totalRecord);
			result.put("sleepUserCnt", sleepUserCnt);
			result.put("paging", pageUtil.getPaging(request.getContextPath() + "/admin/user/list"));
			result.put("status", 200);
		}
		return result;
	}
	
	@Override
	public Map<String, Object> findUsers(HttpServletRequest request) {
		
		String state = request.getParameter("state");
		if(state == null) {
			System.out.println(findAllUsers(request));
			return findAllUsers(request);
		}
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String start = request.getParameter("start");
		String stop = request.getParameter("stop");
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		Map<String, Object> map = new HashMap<>();
		map.put("column", column);
		map.put("query", query);
		map.put("start", start);
		map.put("stop", stop);
		
		int totalRecord = 0;
		List<AllUserDTO> users = null;
		
		if(state.equals("active")) {
			totalRecord = adminMapper.selectUserCountByQuery(map);
			pageUtil.setPageUtil(page, totalRecord);
			
			map.put("begin", pageUtil.getBegin());
			map.put("end", pageUtil.getEnd());
			users = adminMapper.selectUsersByQuery(map);
			
		} else if(state.equals("sleep")){
			
			totalRecord = adminMapper.selectSleepUserCountByQuery(map);
			pageUtil.setPageUtil(page, totalRecord);
			
			map.put("begin", pageUtil.getBegin());
			map.put("end", pageUtil.getEnd());
			users = adminMapper.selectSleepUsersByQuery(map);
		}
		
		String path = null;
		
		switch(column) {
		case "ID":
			path = request.getContextPath() + "/list/searchUsers?column=" + column + "&query=" + query;
			break;
		case "CREATE_DATE":
		case "SLEEP_DATE":
		case "POINT":
			path = request.getContextPath() + "/list/searchUsers?column=" + column + "&start=" + start + "&stop=" + stop;
			break;
		default : path = request.getContextPath() + "/admin/list/searchUsers";
		}
		
		Map<String, Object> result = new HashMap<>();
		if(users.size() == 0) {
			result.put("message", "조회된 결과가 없습니다.");
			result.put("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
			result.put("totalRecord", totalRecord);
			result.put("status", 500);
		} else {
			result.put("users", users);
			result.put("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
			result.put("totalRecord", totalRecord);
			result.put("paging", pageUtil.getPaging(path));
			result.put("status", 200);
		}
		
		System.out.println(result.get("users"));
		
		return result;
	}
	
}
