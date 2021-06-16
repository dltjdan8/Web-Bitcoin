package com.bit.coin.service;

import java.util.List;
import java.util.Map;

import com.bit.coin.model.TickerPublicDto;
import com.bit.coin.model.TransactionHistoryDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface ApiService {

	public List<TransactionHistoryDto> getHistoryList(String order_currency, String payment_currency)
			throws JsonMappingException, JsonProcessingException;

	public TickerPublicDto getTicker(String order_currency, String payment_currency)
			throws JsonMappingException, JsonProcessingException;

	public String[] getStatus(String order_currency) throws JsonMappingException, JsonProcessingException;

	public Map<String, Object> getBtci() throws JsonMappingException, JsonProcessingException;

	public Map<String, Object> getOrderBook(String order_currency, String payment_currency)
			throws JsonMappingException, IllegalArgumentException, JsonProcessingException;

	public Map<String, Object> getCandleStick(String order_currency, String payment_currency, String chart_intervals) throws JsonMappingException, IllegalArgumentException, JsonProcessingException;

}
