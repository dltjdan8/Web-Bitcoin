<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<%@ include file="./header.jsp"%>
	<div class="container p-3 my-3 border">
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

	<div class="container p-3 my-3 bg-primary text-white"></div>

	<script type="text/javascript">
		$(document).ready(function() {
			tickerRequest("BTC", "KRW");
		});
		function tickerRequest(order_currency, payment_currency) {
			$.ajax({
				url : 'api/ticker',
				type : 'get',
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
					`
					$("#ticker").html(tickerHtml);
				}
			});
		};
	</script>
</body>
</html>
