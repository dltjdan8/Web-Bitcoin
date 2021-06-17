package com.bit.coin.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.coin.mapper.ChatMapper;
import com.bit.coin.model.ChatDto;
@Service
public class ChatServiceImpl implements ChatService{
	@Autowired
	private SqlSession session;
	
	@Override
	public void addChat(ChatDto chatDto) {
		session.getMapper(ChatMapper.class).insert(chatDto);;
	}

}
