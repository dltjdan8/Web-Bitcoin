package com.bit.coin.model;

import lombok.Data;

@Data
public class TransactionHistoryDto {
	private String transaction_date;
	//bids 매수 , asks 매도
	private String type;
	private String units_traded;
	private String price;
	private String total;
}
