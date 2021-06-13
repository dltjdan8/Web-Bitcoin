<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"
	%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- csrf간련 데이터 저장 -->
<meta name="csrfHeaderName" content="${_csrf.headerName}">
<meta name="csrfTokenValue" content="${_csrf.token}">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>header.jsp</title>
<!-- 다음 우편번호 검색 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
	<!-- Grey with black text -->
	<nav class="navbar navbar-expand-sm bg-light navbar-light">
		<!-- Brand/logo -->
		<img alt="logo" src="${path}/img/logo.png" href="${path}/" width="50"
			height="50"> <a class="navbar-brand" href="${path}/">BitCoin</a>
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#loginModal">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#registModal">회원가입</a></li>
			</ul>

		<sec:authorize access="isAuthenticated()">
			<form id="logoutForm" action="/user/logout" method="post">
				<sec:csrfInput />
			</form>
			<span id="logoutBtn" class="top-bar-menu-item"
				style="cursor: pointer;">로그아웃</span>
			<span class="top-bar-menu-item"><a href="/user/myPage">내정보</a></span>
			<script>
				$("#logoutBtn").on("click", function() {
					$("#logoutForm").submit();
				});
			</script>
		</sec:authorize>
	</nav>

	<!-- The Modal -->
	<div class="modal" id="loginModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">로그인</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form id="loginForm" action="${path}/user/login" method="post">
					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<label for="id">User ID:</label> <input type="text"
								class="form-control" placeholder="Enter ID" id="id" name="id">
						</div>
						<div class="form-group">
							<label for="pwd">Password:</label> <input type="password"
								class="form-control" placeholder="Enter password" id
								="pwd" name="pwd">
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">로그인</button>
						<button type="reset" class="btn btn-danger">초기화</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal" id="registModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">회원가입</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="panel-body" style="margin-top: 20px;">
						<form id="registerForm" action="user/regist" method="post">
							<div class="form-group" align="left">
								<div class="col-sm-12">＊아이디</div>
								<div class="col-sm-12">
									<input id="rid" name="rid" type="text" class="form-control"
										placeholder="아이디" autofocus autocomplete="off">
									<button id="reduplicationCheck" class="btn" type="button"
										style="color: green; font-size: 13px">중복체크</button>
								</div>
								<div class="col-sm-12" id="idComment"></div>
							</div>

							<div class="form-group" align="left">
								<div class="col-sm-12">＊비밀번호</div>
								<div class="col-sm-12">
									<input id="rpwd" name="rpwd" type="password"
										class="form-control" placeholder="비밀번호" autocomplete="off">
									<div id="pwdComment" style="color: red"></div>
								</div>
							</div>

							<div class="form-group" align="left">
								<div class="col-sm-12">＊비밀번호 재입력</div>
								<div class="col-sm-12">
									<input id="rePwd" type="password" class="form-control"
										placeholder="비밀번호" autocomplete="off">
									<div id="rePwdComment" style="color: red"></div>
								</div>
							</div>
							<div class="form-group" align="left">
								<div class="col-sm-12">＊이름</div>
								<div class="col-sm-12">
									<input id="name" name="name" type="text" class="form-control"
										placeholder="이름" autocomplete="new-password">
									<div id="nameComment"></div>
								</div>
							</div>
							<div class="form-group" align="left">
								<div class="col-sm-12">＊닉네임</div>
								<div class="col-sm-12">
									<input id="nickname" name="nickname" type="text"
										class="form-control" placeholder="닉네임" autocomplete="off">
									<div id="nicknameComment"></div>
								</div>
							</div>
							<div class="form-group" align="left">
								<div class="col-sm-12">＊생년월일</div>
								<input id="birthday" type="hidden" name="birthday">
								<div class="col-sm-12"
									style="padding-left: 15px; padding-right: 15px; margin: 0 auto;">
									<div align="center"
										style="height: 45px; font-family: 'Nunito Sans', sans-serif">
										<input id="year" name="year" maxlength="4" type="text"
											placeholder="년" autocomplete="off" style="width: 32%">
										<select aria-label="월" id="month"
											style="width: 32%; height: 30px;">
											<option value="">월</option>
											<option value="01">1월</option>
											<option value="02">2월</option>
											<option value="03">3월</option>
											<option value="04">4월</option>
											<option value="05">5월</option>
											<option value="06">6월</option>
											<option value="07">7월</option>
											<option value="08">8월</option>
											<option value="09">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select> <input id="date" name="date" maxlength="2" type="text"
											placeholder="일" autocomplete="off" style="width: 32%">
									</div>
									<div id="birthdayComment" class="col-sm-12"></div>
								</div>
							</div>


							<div class="form-group" align="left">
								<div class="col-sm-12">＊성별</div>
								<div class="col-sm-12">
									<div class="radio custom-control">
										<label><input name="gender" type="radio" checked
											value="man">남성</label>
									</div>
									<div class="radio custom-control">
										<label><input name="gender" type="radio" value="woman">여성</label>
									</div>
								</div>
							</div>

							<div class="form-group" align="left">
								<div class="col-sm-12">＊이메일</div>
								<div class="col-sm-12">
									<input id="email" name="email" type="email"
										class="form-control" placeholder="이메일" autocomplete="off">
									<div id="emailComment"></div>
								</div>
							</div>

							<div class="form-group" align="left">
								<div class="col-sm-12">기본 배송지</div>
								<div class="col-sm-12">
									<div style="margin-top: 10px; margin-bottom: 10px">
										<input type="text" id="postalCode" name="postalCode"
											class="form-control" placeholder="우편번호"
											style="width: 50%; display: inline;" readonly="readonly">
										<input type="button" class="form-control"
											onclick="startDaumPostcode()" value="우편번호 검색"
											style="width: 45%; display: inline; float: right;">
									</div>
									<input type="text" id="roadAddress" name="roadAddress"
										class="form-control" placeholder="도로명주소" readonly="readonly"
										style="margin-bottom: 10px"> <input type="text"
										id="detailAddress" name="detailAddress" class="form-control"
										placeholder="상세주소" autocomplete="new-password">
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-12">
									<input id="registerBtn" type="submit" value="회원가입"
										style="border: hidden; margin-top: 20px; font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
								</div>
							</div>
							<sec:csrfInput />
						</form>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<script>
	function startDaumPostcode() {
		new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById("postalCode").value = data.zonecode;
			document.getElementById("roadAddress").value = data.roadAddress;
		}
		}).open();
	}
</script>
	<script type="text/javascript">
	let submitCheck = 0;

	let pwdCheck = 0;
	let idCheck = 0; 
	let nameCheck = 0;
	let nicknameCheck = 0;
	let birthdayCheck = 0;
	let emailCheck = 0;
	
	// 유효한 생년월일인지 체크
	function birthdayValidate() {
		// 생년월일은 현재시간으로 100년전 부터 10년전에 태어난 사람만 허용하기 위해 변수로 선언
		let now = new Date();
		let hundredYearsAgoTime = now.getTime() - (365 * 24 * 60 * 60 * 1000 * 100);
		let minBirthdayDate = new Date(hundredYearsAgoTime);
		
		let tenYearsAgoTime = now.getTime() - (365 * 24 * 60 * 60 * 1000 * 10);
		let maxBirthdayDate = new Date(tenYearsAgoTime);
		
		let yearVal = $("#year").val().trim();
		let monthVal = $("#month").val();
		let dateVal = $("#date").val().trim();
		
		let birthdayInput = new Date(yearVal, monthVal, dateVal);

		if(birthdayInput > minBirthdayDate && birthdayInput < maxBirthdayDate && dateVal < 32 && dateVal > 0){
			$("#birthday").val(yearVal + "-" + monthVal +"-" + dateVal);
			return true;
		}else{
			return false;
		}
	}
	
	$("#registerBtn").on("click", function(e) {
		e.preventDefault();
		
		let idVal = $("#rid").val().trim();
		if(!idVal){
			$("#idComment").attr("style","color : red; font-size:13px;");
			$("#idComment").html("아이디를 입력해주세요");
		}
		
		let pwdVal = $("#rpwd").val().trim();
		if(!pwdVal){
			$("#rePwdComment").attr("style","color : red; font-size:13px;");
			$("#rePwdComment").html("비밀번호를 입력해주세요");
		}
		
		let nameVal = $("#name").val().trim();
		if(!nameVal){
			$("#nameComment").attr("style","color : red; font-size:13px;");
			$("#nameComment").html("이름을 입력해주세요");
			nameCheck = 0;
		}else{
			nameCheck = 1;
		}
		
		let nicknameVal = $("#nickname").val().trim();
		if(!nicknameVal){
			$("#nicknameComment").attr("style","color : red; font-size:13px;");
			$("#nicknameComment").html("닉네임을 입력해주세요");
			nicknameCheck = 0;
		}else{
			nicknameCheck = 1;
		}
		
		if(birthdayValidate()){
			birthdayCheck = 1;
			$("#birthdayComment").html("");
		}else{
			birthdayCheck = 0;
			$("#birthdayComment").attr("style","color : red; font-size:13px;");
	    	$("#birthdayComment").html("정확한 생년월일을 입력해주세요");
		}
		
		let emailVal = $("#email").val().trim();
		if(!emailVal){
			$("#emailComment").attr("style","color : red; font-size:13px;");
			$("#emailComment").html("이메일을 입력해주세요");
			emailCheck = 0;
		}else{
			emailCheck = 1;
		}
		let postalCode = $("#postalCode").val().trim();
		let detailAddress = $("#detailAddress").val().trim();
		if(postalCode){
			if(!detailAddress){
				alert('기본 배송지를 저장하기 위해서 상세 주소를 반드시 입력해주세요');
				return;
			}
		}
		submitCheck = pwdCheck * idCheck * nameCheck * nicknameCheck * birthdayCheck * emailCheck;
		if(submitCheck === 1){
			registerForm.submit();
		}
		else{
			console.log("pwdCheck : "+pwdCheck + ", idCheck : "+idCheck);
			console.log("nameCheck : "+nameCheck + ", nicknameCheck : "+nicknameCheck);
			console.log("birthdayCheck : "+birthdayCheck + ", emailCheck : "+emailCheck);
			console.log("---------------");
			alert('모든 항목들을 작성해주세요');
		}
	});
	
	// 중복체크 
	// db로 부터 ajax통신으로 아이디 중복체크 결과를 받아온다.
	// 성공시 idCheck를 1로 변경
	$("#reduplicationCheck").on("click", function(e) {
		e.preventDefault();
		let idVal = $("#rid").val().trim();
		if(!idVal){
			$("#idComment").attr("style","color : red; font-size:13px;");
			$("#idComment").html("id를 입력하세요");
			return;
		}
		getIdValidate(idVal, function(result) {
			if(result === "ok"){
				$("#idComment").attr("style","color : blue; font-size:13px;");
		    	$("#idComment").html("사용가능한 id입니다");
		    	idCheck = 1;
			}else{
				$("#idComment").attr("style","color : red; font-size:13px;");
		   		$("#idComment").html("이미 사용중인 id입니다");
			}
		});
		
	});
	var csrfHeaderName = $("meta[name='csrfHeaderName']").attr("content");
	var csrfTokenValue = $("meta[name='csrfTokenValue']").attr("content");

	function getIdValidate(id, callback, error) {
		console.log(id);
		$.ajax({
			type : 'post',
			url : 'user/validate',
			data : 'id='+id,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err) {
				if(error){
					error(err);
				}
			}
		});
	}
	// id를 입력 및 중복체크 여부 확인
	$("#rid").on("change keyup paste input", function() {
		idCheck = 0;
		let idVal = $("#rid").val().trim();
		if(!idVal){
			$("#idComment").attr("style","color : red; font-size:13px;");
	    	$("#idComment").html("id를 입력해주세요");
	    }else{
	    	$("#idComment").attr("style","color : red; font-size:13px;");
	    	$("#idComment").html("중복체크를 해주세요");
	    }
	});
	
	// 패스워드 일치 여부
	$("#rePwd").on("change keyup paste input", function() {
		let pwdVal = $("#rpwd").val().trim();
		let rePwdVal = $(this).val().trim();
	    if(rePwdVal === pwdVal) {
	    	$("#rePwdComment").attr("style","color : blue; font-size:13px;");
	    	$("#rePwdComment").html("일치");
	    	pwdCheck = 1;
	    }else{
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호 불일치");
	    	pwdCheck = 0;
	    }
	    if(rePwdVal.length === 0 && pwdVal.length > 0){
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호를 재입력해주세요");
	    }else if(rePwdVal.length === 0 && pwdVal.length === 0){
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호를 입력해주세요");
	    }
	});
	
	$("#rpwd").on("change keyup paste input", function() {
		let pwdVal = $(this).val().trim();
	    let rePwdVal = $("#rePwd").val().trim();
	    $("#pwdComment").html("");
	    if(rePwdVal === pwdVal) {
	    	$("#rePwdComment").attr("style","color : blue; font-size:13px;");
	    	$("#rePwdComment").html("일치");
	    	pwdCheck = 1;
	    }else{
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호 불일치");
	    	pwdCheck = 0;
	    }
	    if(pwdVal.length === 0){
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호를 입력해주세요");
	    }
	});
	
	// 이름을 입력하지 않을 경우 comment 메세지
	$("#name").on("change keyup paste input", function() {
		let nameVal = $(this).val().trim();
		if(!nameVal){
			$("#nameComment").attr("style","color : red; font-size:13px;");
	    	$("#nameComment").html("이름을 입력해주세요");
	    }else{
	    	$("#nameComment").html("");
	    }
	});
	
	// 닉네임을 입력하지 않을 경우 comment 메세지
	$("#nickname").on("change keyup paste input", function() {
		let nicknameVal = $(this).val().trim();
		if(!nicknameVal){
			$("#nicknameComment").attr("style","color : red; font-size:13px;");
	    	$("#nicknameComment").html("닉네임을 입력해주세요");
	    }else{
	    	$("#nicknameComment").html("");
	    }
	});
	
	// 이메일을 입력하지 않을 경우 comment 메세지
	$("#email").on("change keyup paste input", function() {
		let emailVal = $(this).val().trim();
		if(!emailVal){
			$("#emailComment").attr("style","color : red; font-size:13px;");
	    	$("#emailComment").html("이메일을 입력해주세요");
	    }else{
	    	$("#emailComment").html("");
	    }
	});
	
</script>
</body>
</html>