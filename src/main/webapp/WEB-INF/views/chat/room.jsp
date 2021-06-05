<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<input type="text" id="msg" class="form-control">
	<button id="btn">Send Message</button>
	
	<script type="text/javascript">
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
					console.log('rawMessage : ' + rawMessage);
					var messageArr = rawMessage.split("||");
					var messageSender = null;
					var originMessage = null;
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
			if (!socket) {
				return;
			}
			let msg = $("input#msg").val();
			// 소캣 메세지 전송
			console.log(msg);
			socket.send(msg);
		});
	</script>
</body>
</html>