<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>BookShelf</title>

<!-- Custom fonts for this template-->
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/css/sb-admin-2.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	var idCheck = 0;
	var pwCheck = 0;
	function checkId() {
		var inputed = f.user_id.value;
		var CheckForm = /^[a-z0-9]{5,16}$/;
		if (!CheckForm.test(inputed)) {
			$('#submitbtn').prop("disabled", true);
			$('#wrongId').show();
			$('#failId').hide();
			$('#successId').hide();
		} else {
			$.ajax({
				data : {
					user_id : inputed
				},
				url : "checkId.do",
				success : function(data) {
					if (inputed == "" && data == '0') {
						$('#submitbtn').prop("disabled", true);
						$('#wrongId').hide();
						$('#failId').show();
						$('#successId').hide();
					} else if (data == '0') {
						$('#submitbtn').prop("disabled", false);
						$('#wrongId').hide();
						$('#failId').hide();
						$('#successId').show();
					} else if (data == '1') {
						$('#submitbtn').prop("disabled", true);
						$('#wrongId').hide();
						$('#failId').show();
						$('#successId').hide();
					}
				}
			})
		}
	}
	function checkMail() {
		var inputed = f.user_mail.value;
		var CheckForm = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (!CheckForm.test(inputed)) {
			$('#submitbtn').prop("disabled", true);
			$('#failMail').hide();
		}else{
			$.ajax({
				data : {
					user_mail : inputed
				},
				url : "checkMail.do",
				success : function(data) {
					if (inputed == "" && data == '0') {
						$('#submitbtn').prop("disabled", true);
						$('#successMail').hide();
						$('#failMail').show();
					} else if (data == '0') {
						$('#submitbtn').prop("disabled", false);
						$('#successMail').show();
						$('#failMail').hide();
					} else if (data == '1') {
						$('#submitbtn').prop("disabled", true);
						$('#successMail').hide();
						$('#failMail').show();
					}
				}
			})
		}
	}
	function doRegUserCkeck(f) {
		if (f.user_id.value == "") {
			alert("아이디를 입력하세요.");
			f.user_id.focus();
			return false;
		}
		if (f.user_name.value == "") {
			alert("이름을 입력하세요.");
			f.user_name.focus();
			return false;
		}
		if (f.password.value == "") {
			alert("비밀번호를 입력하세요.");
			f.password.focus();
			return false;
		}
		if (f.RepeatPassword.value == "") {
			alert("비밀번호 재입력을 입력하세요.");
			f.RepeatPassword.focus();
			return false;
		}
		if (f.user_mail.value == "") {
			alert("Email을 입력하세요.");
			f.user_mail.focus();
			return false;
		}
		if (f.user_date.value == "") {
			alert("생년월일을 입력하세요.");
			f.user_date.focus();
			return false;
		}
		if (f.password.value != f.RepeatPassword.value) {
			alert("비밀번호가 같지 않습니다.");
			f.RepeatPassword.focus();
			return false;
		}
	}
</script>
</head>

<body class="bg-gradient-saddle">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">책장 회원가입</h1>
							</div>
							<form name="f" class="user" action="/user/insertUserInfo.do"
								method="post" onsubmit="return doRegUserCkeck(this);">
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										name="user_id" oninput="checkId()" placeholder="ID">
									<div id="wrongId"
										style="display: none; color: red; font-size: 12px;">5~16자의
										영문 소문자,숫자와 특수기호(_),(-)만 사용 가능합니다.</div>
									<div id="failId"
										style="display: none; color: red; font-size: 12px;">사용하실
										수 없는 아이디입니다.</div>
									<div id="successId"
										style="display: none; color: saddlebrown; font-size: 12px;">사용하실
										수 있는 아이디입니다.</div>
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										name="user_name" placeholder="이름">
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="password" class="form-control form-control-user"
											name="password" maxlength="16" placeholder="비밀번호">
									</div>
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user"
											name="RepeatPassword" placeholder="비밀번호 재입력">
									</div>
								</div>
								<div class="form-group">
									<input type="email" class="form-control form-control-user"
										name="user_mail" oninput="checkMail()" placeholder="Email">
									<div id="successMail"
										style="display: none; color: saddlebrown; font-size: 12px;">사용 가능한 Email입니다.</div>
									<div id="failMail"
										style="display: none; color: red; font-size: 12px;">이미 등록된 Email입니다.</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="date" class="form-control form-control-user"
											name="user_date" placeholder="">
									</div>
									<div class="col-sm-6">
										<div class="custom-control custom-checkbox small">
											<input type="radio" class="custom-control-input" id="gender1"
												name="user_gen" value="0" checked> <label
												class="custom-control-label" for="gender1">남자</label>
										</div>
										<div class="custom-control custom-checkbox small">
											<input type="radio" class="custom-control-input" id="gender2"
												name="user_gen" value="1"> <label
												class="custom-control-label" for="gender2">여자</label>
										</div>
									</div>
								</div>
								<button id="submitbtn" type="submit"
									class="btn btn-primary btn-user btn-block">회원 가입</button>
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="">이용자약관</a>
							</div>
							<div class="text-center">
								<a class="small" href="">개인정보취급방침</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Bootstrap core JavaScript-->

	<!-- Core plugin JavaScript-->

	<!-- Custom scripts for all pages-->

</body>

</html>
