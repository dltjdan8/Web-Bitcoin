package com.bit.coin.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
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
			@RequestParam(value = "payment_currency") String payment_currency) {
		List<TransactionHistoryDto> list;
		try {
			list = apiService.getHistoryList(order_currency, payment_currency);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<List<TransactionHistoryDto>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<TransactionHistoryDto>>(list, HttpStatus.OK);
	}

	// 요청 당시 빗썸 거래소 가상자산 현재가 정보를 제공합니다.
	@GetMapping("/ticker")
	public ResponseEntity<TickerPublicDto> getTicker(@RequestParam(value = "order_currency") String order_currency,
			@RequestParam(value = "payment_currency") String payment_currency) {
		TickerPublicDto dto;
		try {
			dto = apiService.getTicker(order_currency, payment_currency);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<TickerPublicDto>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<TickerPublicDto>(dto, HttpStatus.OK);
	}

	// 가상 자산의 입/출금 현황 정보를 제공합니다.
	@GetMapping("/assetsstatus")
	public ResponseEntity<String[]> getStatus(@RequestParam(value = "order_currency") String order_currency) {
		String[] response;
		try {
			response = apiService.getStatus(order_currency);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<String[]>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<String[]>(response, HttpStatus.OK);
	}

	// 빗썸 지수 (BTMI,BTAI) 정보를 제공합니다.
	@GetMapping("/btci")
	public ResponseEntity<Map<String, Object>> getBtci() {
		Map<String, Object> map;
		try {
			map = apiService.getBtci();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Map<String, Object>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}

	// 요청 당시 빗썸 거래소 가상자산 현재가 정보를 제공합니다.
	@GetMapping("/orderbook")
	public ResponseEntity<Map<String, Object>> getOrderBook(
			@RequestParam(value = "order_currency") String order_currency,
			@RequestParam(value = "payment_currency") String payment_currency) {
		Map<String, Object> map;
		try {
			map = apiService.getOrderBook(order_currency, payment_currency);
		} catch (IllegalArgumentException | JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Map<String, Object>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}

	// 시간 및 구간 별 빗썸 거래소 가상자산 가격, 거래량 정보를 제공합니다. 날짜별 오름차순
	@GetMapping("/candlestick")
	public ResponseEntity<Map<String, Object>> getCandleStick(
			@RequestParam(value = "order_currency") String order_currency,
			@RequestParam(value = "payment_currency") String payment_currency,
			@RequestParam(value = "chart_intervals") String chart_intervals) {
		Map<String, Object> map;
		try {
			map = apiService.getCandleStick(order_currency, payment_currency, chart_intervals);
		} catch (IllegalArgumentException | JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Map<String, Object>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}

	@GetMapping("/coinList")
	public ResponseEntity<Map<String, String>> getCoinList() throws IOException {
		return new ResponseEntity<Map<String, String>>(apiService.getCoinEvent(), HttpStatus.OK);
	}

	// 현재가, 호가, 체결에 대한 정보를 수신할 수 있습니다.
//	@GetMapping("/connect")
//	public ResponseEntity<String> getConnect(
//			@RequestParam(value = "type") String type,
//			@RequestParam(value = "symbols") String[] symbols,
//			@RequestParam(value = "tickTypes" ,required = false) String[] tickTypes)
//			throws JsonMappingException, JsonProcessingException {
//		Map<String, Object> map = apiService.getCandleStick(order_currency, payment_currency, chart_intervals);
//		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
//	}

}
