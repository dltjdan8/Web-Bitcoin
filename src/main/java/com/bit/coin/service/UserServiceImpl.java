package com.bit.coin.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.coin.mapper.UserMapper;
import com.bit.coin.model.UserDto;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private SqlSession session;

	@Override
	public int validate(String userId) {
		// TODO Auto-generated method stub
		return session.getMapper(UserMapper.class).validate(userId);
	}

	@Override
	public int modify() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public UserDto getUser(String username) {
		// TODO Auto-generated method stub
		return session.getMapper(UserMapper.class).getUser(username);
	}

	@Override
	public int regist(UserDto userDto) {
		// TODO Auto-generated method stub
		userDto.setAuthority("ROLE_USER");
		return session.getMapper(UserMapper.class).regist(userDto);
	}

}
