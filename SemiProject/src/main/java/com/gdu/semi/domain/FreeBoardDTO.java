package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class FreeBoardDTO {
	private int freeBoardNo;
	private String id;
	private String freeTitle;
	private String freeContent;
	private String ip;
	private Date createDate;
	private Date modifyDate;
	private int state;
	private int depth;
	private int groupNo;
	private int groupOrder;
}