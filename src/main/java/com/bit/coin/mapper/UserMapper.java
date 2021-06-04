package com.bit.coin.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.bit.coin.model.UserDto;

@Mapper
public interface UserMapper {

	UserDto getUser(String username);

	int validate(String userId);

	int regist(UserDto userDto);

}
