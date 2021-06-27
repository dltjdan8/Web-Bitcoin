<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<%@ include file="./header.jsp"%>
	<div class="dropdown">
		<button type="button" class="btn btn-primary dropdown-toggle"
			data-toggle="dropdown">코인리스트</button>
		<div class="dropdown-menu" id="coinlist"></div>
	</div>
	<hr>
	<h3 id="assetsStatus"></h3>
	<div class="container p-3 my-3 border">
		<h2>가상자산 현재가 정보</h2>
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th>시가</th>
					<th>종가</th>
					<th>저가</th>
					<th>고가</th>
					<th>거래량</th>
					<th>거래금액</th>
					<th>전일종가</th>
					<th>최근 24시간 거래량</th>
					<th>최근 24시간 거래금액</th>
					<th>최근 24시간 변동가</th>
					<th>최근 24시간 변동률</th>
					<th>거래 시간</th>
				</tr>
			</thead>
			<tbody>
				<tr id="ticker">
				</tr>
			</tbody>
		</table>
	</div>

	<div class="container p-3 my-3 bg-dark text-white">
	
	</div>

	<div class="container p-3 my-3 bg-primary text-white">
	
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			coinListRequest();
			btciRequest();
			assetsStatusRequest("BTC");
			tickerRequest("BTC", "KRW");
			historyRequest("BTC", "KRW");
			orderBookRequest("BTC", "KRW");
			candleStickRequest("BTC", "KRW","24H");
			
			$("a.select-coin").on("click",function(){
				let coinName = $(this).attr("name");
				console.log(coinName);
				assetsStatusRequest(coinName);
				tickerRequest(coinName, "KRW");
				historyRequest(coinName, "KRW");
				orderBookRequest(coinName, "KRW");
				candleStickRequest(coinName, "KRW","24H");
			});
			
		});
		//코인 종류 크롤링 
		function coinListRequest(){
			$.ajax({
				url: 'api/coinList',
				type: 'get',
				async: false,
				dataType: 'json',
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					for (key in result) {
						$('#coinlist').append(`<a class='dropdown-item select-coin' href='#' name='${"${key}"}'>${"${result[key]}"}</a>`); 
					}
					console.log("완료");
				},
				error : function(request,status,error){
					alert("코인 종류 크롤링 "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
		//빗썸 거래소 가상자산 현재가 정보
		function tickerRequest(order_currency, payment_currency) {
			$.ajax({
				url : 'api/ticker',
				type : 'get',
				async: false,
				data : {
					'order_currency' : order_currency,
					'payment_currency' : payment_currency
				},
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					var ticker = result;
					var tickerHtml = `
						<td>${'${ ticker.opening_price }'}</td>
						<td>${'${ ticker.closing_price }'}</td>
						<td>${'${ ticker.min_price }'}</td>
						<td>${'${ ticker.max_price }'}</td>
						<td>${'${ ticker.units_traded }'}</td>
						<td>${'${ ticker.acc_trade_value }'}</td>
						<td>${'${ ticker.prev_closing_price }'}</td>
						<td>${'${ ticker.units_traded_24H }'}</td>
						<td>${'${ ticker.acc_trade_value_24H }'}</td>
						<td>${'${ ticker.fluctate_24H }'}</td>
						<td>${'${ ticker.fluctate_rate_24H }'}</td>
						<td>${'${ ticker.date }'}</td>
					`;
					$("#ticker").html(tickerHtml);
				},
				error : function(request,status,error){
					alert("현재가 정보 "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
		//입출금 가능 현황
		function assetsStatusRequest(order_currency) {
			$.ajax({
				url : 'api/assetsstatus',
				type : 'get',
				data : {
					'order_currency' : order_currency
				},
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					console.log("Status");
					console.log(result[0]);
					console.log(result[1]);
					$('#assetsStatus').text("현재 선택된 화폐는 " + order_currency+"이고 입금 : "+result[0]+" 출금 : "+result[1]);
				},
				error : function(request,status,error){
					alert("입출금 가능 현황 "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
		function btciRequest(order_currency) {
			$.ajax({
				url : 'api/btci',
				type : 'get',
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					console.log("btci");
					console.log(result.btai.market_index);
					console.log(result.btai.rate);
					console.log(result.btai.width);
					console.log(result.btmi.market_index);
					console.log(result.btmi.rate);
					console.log(result.btmi.width);
				},
				error : function(request,status,error){
					alert("btci "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
		function historyRequest(order_currency, payment_currency) {
			$.ajax({
				url : 'api/history',
				type : 'get',
				dataType : "json",
				data : {
					'order_currency' : order_currency,
					'payment_currency' : payment_currency
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					console.log("history");
					console.log(result);
				},
				error : function(request,status,error){
					alert("거래 기록 "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
		function orderBookRequest(order_currency, payment_currency) {
			$.ajax({
				url : 'api/orderbook',
				type : 'get',
				dataType : "json",
				data : {
					'order_currency' : order_currency,
					'payment_currency' : payment_currency
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					console.log("orderBook");
					console.log(result);
				},
				error : function(request,status,error){
					alert("주문 기록 "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
		function candleStickRequest(order_currency, payment_currency, chart_intervals) {
			$.ajax({
				url : 'api/candlestick',
				type : 'get',
				dataType : "json",
				data : {
					'order_currency' : order_currency,
					'payment_currency' : payment_currency,
					'chart_intervals' : chart_intervals
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					console.log("candleStick");
					console.log(result);
				},
				error : function(request,status,error){
					alert("candleStick "+"code : "+request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+error);
				}
			});
		};
	</script>
</body>
</html>
