package com.gdu.semi.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AttachDTO {
	private int attachNo;
	private String path;
	private String origin;
	private String filesystem;
	private int downloadCnt;
	private int uploadBoardNo;
}
