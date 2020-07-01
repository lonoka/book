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
	var emailCheck = 0;
	function checkId() {
		var inputed = f.user_id.value;
		var CheckForm = /^[a-z0-9]{5,16}$/;
		if (!CheckForm.test(inputed)) {
			$('#wrongId').show();
			$('#failId').hide();
			$('#successId').hide();
			idCheck = 0;
		} else {
			$.ajax({
				data : {
					user_id : inputed
				},
				url : "checkId.do",
				success : function(data) {
					if (inputed == "" && data == '0') {
						$('#wrongId').hide();
						$('#failId').show();
						$('#successId').hide();
						idCheck = 0;
					} else if (data == '0') {
						$('#wrongId').hide();
						$('#failId').hide();
						$('#successId').show();
						idCheck = 1;
					} else if (data == '1') {
						$('#wrongId').hide();
						$('#failId').show();
						$('#successId').hide();
						idCheck = 0;
					}
				}
			})
		}
	}
	function checkPw() {
		var inputed = f.password.value;
		if (inputed.length < 6) {
			$('#wrongPw').show();
			$('#wrongPw2').hide();
		} else {
			$('#wrongPw').hide();
			$('#wrongPw2').hide();
		}
	}
	function checkPw2() {
		var inputed = f.password.value;
		var inputed2 = f.RepeatPassword.value;
		if (inputed != inputed2) {
			$('#wrongPw2').show();
		} else {
			$('#wrongPw2').hide();
		}
	}
	function checkMail() {
		var inputed = f.user_mail.value;
		var CheckForm = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (!CheckForm.test(inputed)) {
			$('#successMail').hide();
			$('#failMail').hide();
			$('#wrongMail').show();
			emailCheck = 0;
		} else {
			$.ajax({
				data : {
					user_mail : inputed
				},
				url : "checkMail.do",
				success : function(data) {
					if (inputed == "" && data == '0') {
						$('#successMail').hide();
						$('#failMail').show();
						$('#wrongMail').hide();
						emailCheck = 0;
					} else if (data == '0') {
						$('#successMail').show();
						$('#failMail').hide();
						$('#wrongMail').hide();
						emailCheck = 1;
					} else if (data == '1') {
						$('#successMail').hide();
						$('#failMail').show();
						$('#wrongMail').hide();
						emailCheck = 0;
					}
				}
			})
		}
	}
	function doRegUserCkeck(f) {
		if (idCheck == 0) {
			alert("사용하실수 없는 아이디 입니다.");
			return false;
		}
		if (emailCheck == 0) {
			alert("사용하실수 없는 이메일 입니다.");
			return false;
		}
		if (f.password.value.length < 6) {
			alert("6글자 이상의 비밀번호를 사용해주세요.");
			return false;
		}
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
										name="user_id" oninput="checkId()" placeholder="ID"
										required="required">
									<div id="wrongId"
										style="display: none; color: red; font-size: 12px;">5~16자의
										영문 소문자,숫자만 사용 가능합니다.</div>
									<div id="failId"
										style="display: none; color: red; font-size: 12px;">사용하실
										수 없는 아이디입니다.</div>
									<div id="successId"
										style="display: none; color: saddlebrown; font-size: 12px;">사용하실
										수 있는 아이디입니다.</div>
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										name="user_name" placeholder="이름" required="required">
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="password" class="form-control form-control-user"
											name="password" maxlength="16" oninput="checkPw()"
											placeholder="비밀번호" style="ime-mode: disabled;"
											required="required">
									</div>
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user"
											name="RepeatPassword" oninput="checkPw2()"
											placeholder="비밀번호 재입력" style="ime-mode: disabled;"
											required="required">
									</div>
									<div id="wrongPw"
										style="display: none; color: red; font-size: 12px; margin-left:20px;">6~16자의
										비밀번호를 사용해주세요.</div>
									<div id="wrongPw2"
										style="display: none; color: red; font-size: 12px; margin-left:20px;">비밀번호가
										일치하지 않습니다.</div>
								</div>
								<div class="form-group">
									<input type="email" class="form-control form-control-user"
										name="user_mail" oninput="checkMail()" placeholder="Email"
										required="required">
									<div id="wrongMail"
										style="display: none; color: red; font-size: 12px;">잘못된
										이메일 형식입니다.</div>
									<div id="successMail"
										style="display: none; color: saddlebrown; font-size: 12px;">사용
										가능한 Email입니다.</div>
									<div id="failMail"
										style="display: none; color: red; font-size: 12px;">이미
										등록된 Email입니다.</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="date" class="form-control form-control-user"
											name="user_date" placeholder="" required="required">
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
								<a class="small" href="/userTerms.do">이용자약관</a>
							</div>
							<div class="text-center">
								<a class="small" href="/privatePolicy.do">개인정보취급방침</a>
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
