package com.bit.coin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bit.coin.model.TickerPublicDto;
import com.bit.coin.model.TransactionHistoryDto;
import com.bit.coin.service.ApiService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

@RestController
@RequestMapping("/api")
public class ApiController {

	@Autowired
	private ApiService apiService;

	// 빗썸 거래소 가상자산 거래 체결 완료 내역을 제공합니다.
	@GetMapping("/history")
	public ResponseEntity<List<TransactionHistoryDto>> getHistoryList(
			@RequestParam(value = "order_currency") String order_currency,
			@RequestParam(value = "payment_currency") String payment_currency)
			throws JsonMappingException, JsonProcessingException {
		List<TransactionHistoryDto> list = apiService.getHistoryList(order_currency, payment_currency);
		return new ResponseEntity<List<TransactionHistoryDto>>(list, HttpStatus.OK);
	}

	// 요청 당시 빗썸 거래소 가상자산 현재가 정보를 제공합니다.
	@GetMapping("/ticker")
	public ResponseEntity<TickerPublicDto> getTicker(@RequestParam(value = "order_currency") String order_currency,
			@RequestParam(value = "payment_currency") String payment_currency)
			throws JsonMappingException, JsonProcessingException {
		TickerPublicDto dto = apiService.getTicker(order_currency, payment_currency);
		return new ResponseEntity<TickerPublicDto>(dto, HttpStatus.OK);
	}

	// 가상 자산의 입/출금 현황 정보를 제공합니다.
	@GetMapping("/assetsstatus")
	public ResponseEntity<String[]> getStatus(@RequestParam(value = "order_currency") String order_currency)
			throws JsonMappingException, JsonProcessingException {
		String[] response = apiService.getStatus(order_currency);
		return new ResponseEntity<String[]>(response, HttpStatus.OK);
	}

	// 빗썸 지수 (BTMI,BTAI) 정보를 제공합니다.
	@GetMapping("/btci")
	public ResponseEntity<Map<String, Object>> getBtci() throws JsonMappingException, JsonProcessingException {
		Map<String, Object> map = apiService.getBtci();
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}

	// 요청 당시 빗썸 거래소 가상자산 현재가 정보를 제공합니다.
	@GetMapping("/orderbook")
	public ResponseEntity<Map<String, Object>> getOrderBook(
			@RequestParam(value = "order_currency") String order_currency,
			@RequestParam(value = "payment_currency") String payment_currency)
			throws JsonMappingException, JsonProcessingException {
		Map<String, Object> map = apiService.getOrderBook(order_currency, payment_currency);
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}

}
