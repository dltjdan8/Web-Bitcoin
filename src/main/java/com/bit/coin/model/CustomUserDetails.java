package com.bit.coin.model;

import java.util.Date;
import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("serial")
@Getter
@Setter
@ToString
public class CustomUserDetails extends User {
	private String name;
	private String gender;
	private String nickname;
	private String postalCode; // 우편번호
	private String roadAddress; // 도로명 주소
	private String detailAddress; // 상세 주소
	private String email;
	private String birthday;
	private Date regDate;

	public CustomUserDetails(UserDto user) {
		super(user.getRid(), user.getRpwd(), user.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.name = user.getName();
		this.gender = user.getGender();
		this.nickname = user.getNickname();
		this.postalCode = user.getPostalCode();
		this.roadAddress = user.getRoadAddress();
		this.detailAddress = user.getDetailAddress();

		this.email = user.getEmail();
		this.birthday = user.getBirthday();
		this.regDate = user.getRegDate();
	}

}
