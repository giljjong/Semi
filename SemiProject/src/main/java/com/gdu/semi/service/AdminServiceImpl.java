package com.gdu.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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
	public void findAllUsers(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int userCnt = adminMapper.countUser();
		
		int totalRecord = userCnt;
		
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		List<UserDTO> users = adminMapper.selectUserList(map);
		
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/admin/user/list"));
		model.addAttribute("users", users);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("totalRecord", totalRecord);
	}
	
	@Override
	public void findAllSleepUsers(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int sleepUserCnt = adminMapper.countSleepUser();
		
		int totalRecord = sleepUserCnt;
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/admin/user/list"));
		model.addAttribute("sleepUsers", adminMapper.selectSleepUserList());
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("totalRecord", totalRecord);
	}
}
