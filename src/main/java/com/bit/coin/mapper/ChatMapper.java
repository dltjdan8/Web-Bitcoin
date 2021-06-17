package com.bit.coin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bit.coin.model.ChatDto;

@Mapper
public interface ChatMapper {
	public void insert(ChatDto chatDto);
	public List<ChatDto> getAllChatList();
}
