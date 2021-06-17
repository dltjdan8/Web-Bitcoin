package com.bit.coin.service;

import java.util.List;

import com.bit.coin.model.ChatDto;

public interface ChatService {
	public void addChat(ChatDto chatDto);

	public List<ChatDto> getAllChatList();
}
