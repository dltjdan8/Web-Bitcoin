package com.bit.coin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.coin.model.ChatDto;
import com.bit.coin.service.ChatService;

@Controller
@RequestMapping("/chat")
public class ChatController {
	@Autowired
	private ChatService chatServcie;
	
	@GetMapping("/room")
	public void room() {
	}
	
	@GetMapping("/allChat")
	@ResponseBody
	public ResponseEntity<List<ChatDto>> getAllChatList(){
		List<ChatDto> list = chatServcie.getAllChatList();
		return new ResponseEntity<List<ChatDto>>(list, HttpStatus.OK);
	}
}
