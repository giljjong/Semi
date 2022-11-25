package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class GalleryBoardDTO {
	private int galleryBoardNo;
	private String id;
	private String galleryTitle;
	private String galleryContent;
	private String ip;
	private Date createDate;
	private Date modifyDate;
	private int hit;
}
