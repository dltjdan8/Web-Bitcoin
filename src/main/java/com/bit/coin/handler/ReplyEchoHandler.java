package com.bit.coin.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.bit.coin.model.ChatDto;
import com.bit.coin.service.ChatService;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;
@Log4j
public class ReplyEchoHandler extends TextWebSocketHandler{
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private ObjectMapper jsonMapper = new ObjectMapper();
	private ChatDto msgObj = new ChatDto();
	@Autowired
	private ChatService chatService;
	
	// 소켓 연결성공 시 작동
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("연결된 세션 : " + session.getId());
		log.info("채팅방 입장 아이디 : " + session.getPrincipal().getName());
		// 접속한 사용자 list에 추가
		sessionList.add(session);
	}
	
	// 메세지를 받아서 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String rawMessage = message.getPayload(); // json형태의 메세지
		msgObj = jsonMapper.readValue(rawMessage, ChatDto.class); // json형식의 문자를 특정 클래스로 캐스팅
		// 채팅 메세지 db에 저장
		chatService.addChat(msgObj);
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(msgObj.getNickname() + "|" + message.getPayload()));
		}
	}
	// 소켓 연결이 끊긴 후 작동
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.info(session.getId() + "연결 끊음");
	}
	
}
