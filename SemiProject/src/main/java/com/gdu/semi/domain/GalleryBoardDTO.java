package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 클래스에 존재하는 모든 필드에 대한 생성자 생성
@Data // @Geteer, @Setter, @ToString 등
@Builder // 빌더 패턴 자동생성
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
