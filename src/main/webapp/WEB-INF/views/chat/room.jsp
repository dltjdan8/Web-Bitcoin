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
	<div align="center">
		<div style="width: 500px; height: 500px; margin-top: 50px;">
			<div style="height: 80%;overflow: scroll;" id="chat-content">
			</div>
			<div style="height: 20%; margin-top: 30px">
				<input type="text" id="msg">
				<button id="btn" disabled="disabled">전송</button>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		// security context에 저장된 id와 nickname을 가져옴
		const userId = '<c:out value='${loginUser.username}'/>';
		const nickname = '<c:out value='${loginUser.nickname}'/>';
		$("document").ready(function() {
			var socket = null;
			connect();
		});

		function connect() {
			// servlet-context에 설정한 주소
			var was = new WebSocket("ws://localhost:8080/coin/replyEcho");
			socket = was;
			socket.onopen = function() {
				console.log('info: connection opened!');
				// 메세지를 받은 경우
				socket.onmessage = function(event) {
					let rawMessage = event.data;
					let messageArr = rawMessage.split("|");
					if (messageArr.length == 3) {
						let senderId = messageArr[0];
						let senderNickname = messageArr[1];
						let senderContent = messageArr[2];
						let senderRegdate = new Date();
						if(userId == senderId){
							str = "<div class='alert alert-info' style='text-align:right'>" + "나 : "+ senderContent;
							str += "<div style='color:#b9b189'>"+messageTime(senderRegdate)+"</div>";
							str += "</div>";
						}else{
							str = "<div class='alert alert-warning' style='text-align:left'>"+senderNickname + " : "+ senderContent;
							str += "<div style='color:#b9b189'>"+messageTime(senderRegdate)+"</div>";
							str += "</div>";
						}
						$("#chat-content").append(str);
						scrolldown();
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
			let content = $("#msg").val();
			$("#msg").val("");
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
		// db에 저장된 모든 채팅을 가져온다.
		function getAllChat() {
			$.get("/coin/chat/allChat.json", function(list) {
				console.log(list)
				for(var i=0;i<list.length;i++){
					console.log(list[i])
					if(userId == list[i].rid){
						str = "<div class='alert alert-info' style='text-align:right'>" + "나 : "+ list[i].content;
						str += "<div style='color:#b9b189'>"+messageTime(list[i].regdate)+"</div>";
						str += "</div>";
					}else{
						str = "<div class='alert alert-warning' style='text-align:left'>"+list[i].nickname + " : "+ list[i].content;
						str += "<div style='color:#b9b189'>"+messageTime(list[i].regdate)+"</div>";
						str += "</div>";
					}
					$("#chat-content").append(str);
					scrolldown();
				}
				 
			}).fail(function(xhr, status, err) {
				console.log(err)
			})
		}
		getAllChat();
		
		// 채팅창의 화면에서 최신 대화인 맨 아래쪽 글을 보여주기 위해 스크롤을 화면 맨 아래로 내려준다.
		function scrolldown() {
			$('#chat-content').scrollTop($('#chat-content')[0].scrollHeight);
		};
		
		function messageTime(timeValue) {
			let today = new Date();
			let dateObj = new Date(timeValue);
			console.log(dateObj);
			let yy = dateObj.getFullYear().toString().substring(2, 4);
			let mm = dateObj.getMonth()+1;
			let dd = dateObj.getDate();
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			
			date = dateObj.getDate() === today.getDate() ? '오늘 ' : mm + '월  '+ dd+'일';
			if(hh>12){
				hh = '오후 ' + (hh-12);
			}else if(hh<12){
				hh = '오전 ' + (hh);
			}else{
				hh = '오후 12시';
			}
			return '('+date + hh +'시' + mi +'분) ';
		}
		
		// 메세지에 내용이 있는 경우 전송버튼 활성화
		$("#msg").on("change keyup paste input", function() {
			let content = $("#msg").val().trim();
			if(!content){
				$("#btn").attr('disabled', true);
		    }else{
		    	$("#btn").attr('disabled', false);
		    }
		});
	</script>
</body>
</html>