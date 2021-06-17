package com.bit.coin.service;

import com.bit.coin.model.UserDto;

public interface UserService {

	public int regist(UserDto userDto);

	public int validate(String userId);

	public int modify();

	public int delete();

	public UserDto getUser(String username);
}
