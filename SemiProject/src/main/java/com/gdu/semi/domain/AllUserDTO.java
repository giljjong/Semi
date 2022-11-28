package com.gdu.semi.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AllUserDTO {
	private UserDTO userDTO;
	private SleepUserDTO sleepUserDTO;
}