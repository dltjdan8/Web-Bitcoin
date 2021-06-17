package com.bit.coin.model;

import java.util.Date;
import lombok.Data;

@Data
public class ChatDto {
	private int cnum;
	private String rid;
	private String nickname;
	private String content;
	private Date regdate;
}