package com.bit.coin.service;

import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.bit.coin.model.BtciDto;
import com.bit.coin.model.OrderBookDto;
import com.bit.coin.model.TickerPublicDto;
import com.bit.coin.model.TransactionHistoryDto;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class ApiServiceImpl implements ApiService {
	private final String HISTORY_URL = "https://api.bithumb.com/public/transaction_history/";
	private final String TICKER_URL = "https://api.bithumb.com/public/ticker/";
	private final String STATUS_URL = "https://api.bithumb.com/public/assetsstatus/";
	private final String BTCI_URL = "https://api.bithumb.com/public/btci";
	private final String BOOK_URL = "https://api.bithumb.com/public/orderbook/";
	private final String STICK_URL = "https://api.bithumb.com/public/candlestick/";

	@Override
	@JsonIgnoreProperties(ignoreUnknown = true)
	public List<TransactionHistoryDto> getHistoryList(String order_currency, String payment_currency)
			throws JsonMappingException, JsonProcessingException {
		RestTemplate template = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(HISTORY_URL + order_currency + "_" + payment_currency)
				.build(false);
		ResponseEntity<String> response = template.exchange(uri.toUriString(), HttpMethod.GET,
				new HttpEntity<String>(headers), String.class);
		System.out.println("response : " + response.getStatusCodeValue());
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		JsonNode node = mapper.readTree(response.getBody());
		TransactionHistoryDto[] list = mapper.readValue(node.required("data").toString(),
				TransactionHistoryDto[].class);
		return Arrays.asList(list);
	}

	@Override
	@JsonIgnoreProperties(ignoreUnknown = true)
	public TickerPublicDto getTicker(String order_currency, String payment_currency)
			throws JsonMappingException, JsonProcessingException {
		RestTemplate template = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(TICKER_URL + order_currency + "_" + payment_currency)
				.build(false);
		ResponseEntity<String> response = template.exchange(uri.toUriString(), HttpMethod.GET,
				new HttpEntity<String>(headers), String.class);
		System.out.println("response : " + response.getStatusCodeValue());
		System.out.println("response : " + response);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		JsonNode node = mapper.readTree(response.getBody());
		TickerPublicDto dto = mapper.readValue(node.required("data").toString(), TickerPublicDto.class);
		return dto;
	}

	@Override
	public String[] getStatus(String order_currency) throws JsonMappingException, JsonProcessingException {
		RestTemplate template = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(STATUS_URL + order_currency).build(false);
		ResponseEntity<String> response = template.exchange(uri.toUriString(), HttpMethod.GET,
				new HttpEntity<String>(headers), String.class);
		System.out.println("response : " + response.getStatusCodeValue());
		System.out.println("response : " + response);
		ObjectMapper mapper = new ObjectMapper();
		JsonNode node = mapper.readTree(response.getBody()).required("data");
		String[] status = { node.findValue("withdrawal_status").asText(), node.findValue("deposit_status").asText() };
		System.out.println(Arrays.toString(status));
		return status;
	}

	@Override
	public Map<String, Object> getBtci() throws JsonMappingException, JsonProcessingException {
		RestTemplate template = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(BTCI_URL).build(false);
		ResponseEntity<String> response = template.exchange(uri.toUriString(), HttpMethod.GET,
				new HttpEntity<String>(headers), String.class);
		System.out.println("response : " + response.getStatusCodeValue());
		System.out.println("response : " + response);
		ObjectMapper mapper = new ObjectMapper();
		JsonNode node = mapper.readTree(response.getBody()).required("data");
		Map<String, Object> map = new HashMap<>();
		map.put("btai", mapper.readValue(node.required("btai").toString(), BtciDto.class));
		map.put("btmi", mapper.readValue(node.required("btmi").toString(), BtciDto.class));
		return map;
	}

	@Override
	public Map<String, Object> getOrderBook(String order_currency, String payment_currency)
			throws JsonMappingException, IllegalArgumentException, JsonProcessingException {
		RestTemplate template = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(BOOK_URL + order_currency + "_" + payment_currency)
				.build(false);
		ResponseEntity<String> response = template.exchange(uri.toUriString(), HttpMethod.GET,
				new HttpEntity<String>(headers), String.class);
		System.out.println("response : " + response.getStatusCodeValue());
		System.out.println("response : " + response);
		ObjectMapper mapper = new ObjectMapper();
		JsonNode node = mapper.readTree(response.getBody()).required("data");
		Map<String, Object> map = new HashMap<>();
		map.put("timestamp", node.required("timestamp"));
		map.put("bids", mapper.readValue(node.required("bids").toString(), OrderBookDto[].class));
		map.put("asks", mapper.readValue(node.required("asks").toString(), OrderBookDto[].class));
		return map;
	}

	@Override
	public Map<String, Object> getCandleStick(String order_currency, String payment_currency, String chart_intervals)
			throws JsonMappingException, IllegalArgumentException, JsonProcessingException {
		RestTemplate template = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		UriComponents uri = UriComponentsBuilder
				.fromHttpUrl(STICK_URL + order_currency + "_" + payment_currency + "/" + chart_intervals).build(false);
		ResponseEntity<String> response = template.exchange(uri.toUriString(), HttpMethod.GET,
				new HttpEntity<String>(headers), String.class);
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("response : " + response.getStatusCodeValue());
		System.out.println("response : " + mapper.readTree(response.getBody()).required("data").toString());
		JsonNode node = mapper.readTree(response.getBody());
		Map<String, Object> map = new HashMap<>();
		long today = System.currentTimeMillis();
		System.out.println(today);
		String[][] data = mapper.readValue(node.required("data").toString(), String[][].class);
		Arrays.sort(data, new Comparator<String[]>() {
			@Override
			public int compare(String[] a, String[] b) {
				// TODO Auto-generated method stub
				return Long.parseLong(a[0]) - Long.parseLong(b[0]) > 0 ? 1 : -1;
			}

		});
		for (int i = 0; i < data.length; i++) {
			Date date = new Date();
			date.setTime(Long.parseLong(data[i][0]));
			data[i][0] = date.toString();
		}
		map.put("data", data);
		return map;
	}

}
