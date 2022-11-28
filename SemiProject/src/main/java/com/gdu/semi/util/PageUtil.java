package com.gdu.semi.util;

import org.springframework.stereotype.Component;

import lombok.Getter;

@Component
@Getter
public class PageUtil {

	private int page; 
	private int totalRecord;
	private int recordPerPage = 3;
	private int begin;
	private int end;
	
	private int totalPage;
	private int pagePerBlock = 5;
	private int beginPage;
	private int endPage;
	
	public void setPageUtil(int page, int totalRecord) {
		this.page = page;
		this.totalRecord = totalRecord;
		
		begin = (page -1) * recordPerPage + 1 ;
		end = begin + recordPerPage - 1 ;
		if(end > totalRecord) {
			end = totalRecord;
		}
		totalPage = (int) Math.ceil(totalRecord/recordPerPage); 
		
		beginPage = ((page - 1 ) / pagePerBlock ) * pagePerBlock + 1 ;
		endPage = beginPage + pagePerBlock - 1 ;
		
		if(endPage > totalPage ) {
			endPage = totalPage;
		}
		
	}
	
}
