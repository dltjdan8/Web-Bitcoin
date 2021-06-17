<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal" var="loginUser"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div style="height: 300px; margin-top: 30px" align="center">
		<div style="height: 80%" id="chat-content">
			<div class='alert alert-info' style='text-align:right'>나 : 내용
				<div style='color:#8bafc1'>날짜</div>
			</div>
			<div class='alert alert-warning' style='text-align:left'>상대방 : 내용
				<div style='color:#b9b189'>날짜</div>
			</div>
		</div>
		<div style="height: 20%">
			<input type="text" id="msg">
			<button id="btn">Send Message</button>
		</div>
	</div>
	 
	<script type="text/javascript">
		const userId = '<c:out value='${loginUser.username}'/>';
		const nickname = '<c:out value='${loginUser.nickname}'/>';
		let inputValue = $("input#msg").val();
		$("document").ready(function() {
			var socket = null;
			connect();
		});

		function connect() {
			var was = new WebSocket("ws://localhost:8080/coin/replyEcho");
			socket = was;
			socket.onopen = function() {
				console.log('info: connection opened!');

				socket.onmessage = function(event) {
					var rawMessage = event.data;
					var messageArr = rawMessage.split("|");
					var messageSender = null; // 전송자 id
					var originMessage = null; // 메세지 내용
					if (messageArr.length == 2) {
						messageSender = messageArr[0];
						originMessage = messageArr[1];
						console.log(messageSender + "가 [" + originMessage + "] 보냄");
					} else {
						socket.close();
						console.log("커넥션 닫음");
					}

				}

				socket.onclose = function(event) {
					console.log("Info : connection closed");
					setTimeout(function() {
						connect();
					}, 1000);
				}
				socket.onerror = function(err) {
					console.log("Error : connection error");
				}
			}
		};
		$("#btn").on("click", function(e) {
			let content = $("input#msg").val();
			// 소캣 메세지 전송
			send(JSON.stringify({rid : userId, nickname: nickname, content: content}));
		});
		
		function send(message) {
			if (!socket) {
				console.log("error! 소켓이 없음!");
				return;
			}
			socket.send(message);
		};
	</script>
</body>
</html>