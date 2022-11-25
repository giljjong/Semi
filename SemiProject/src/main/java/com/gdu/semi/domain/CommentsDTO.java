package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CommentsDTO {
	private int commentsNo;
	private String id;
	private int galleryBoardNo;
	private Date createDate;
	private String commContent;
	private String ip;
	private int state;
	private int depth;
	private int groupNo;
	private int groupOrder;
}
