package com.gdu.semi.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RetireUserDTO {
	private int userNo;
	private String id;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date joinDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date retireDate;
}
