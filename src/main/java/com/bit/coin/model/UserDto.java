package com.bit.coin.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserDto {

	private String rid;
	private String rpwd;
	private String name;
	private String gender;
	private String nickname;

	private String postalCode; // 우편번호
	private String roadAddress; // 도로명 주소
	private String detailAddress; // 상세 주소

	private String email;
	private boolean enabled;

	private String birthday;
	private Date regDate;

	private String authority;
}
