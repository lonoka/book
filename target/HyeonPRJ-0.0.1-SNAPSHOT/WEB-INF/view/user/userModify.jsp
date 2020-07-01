<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.UserDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	UserDTO uDTO = (UserDTO) request.getAttribute("uDTO");
%>
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
function doUserCkeck(f) {
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
					<div class="col-lg-5 d-none d-lg-block bg-Modify-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">회원 정보 수정</h1>
							</div>
							<form name="f" class="user" action="/updateUserInfo.do"
								method="post" onsubmit="return doUserCkeck(this);">
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										name="user_id" placeholder="ID"
										value="<%=uDTO.getUser_id()%>" readonly="readonly">
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										name="user_name" placeholder="이름"
										value="<%=uDTO.getUser_name()%>">
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
										name="user_mail" placeholder="Email"
										value="<%=uDTO.getUser_mail()%>" readonly="readonly">
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="date" class="form-control form-control-user"
											name="user_date" value="<%=uDTO.getUser_date()%>">
									</div>
									<div class="col-sm-6">
										<%
											if (uDTO.getUser_gen().equals("0")) {
										%>
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
										<%
											} else {
										%>
										<div class="custom-control custom-checkbox small">
											<input type="radio" class="custom-control-input" id="gender1"
												name="user_gen" value="0"> <label
												class="custom-control-label" for="gender1">남자</label>
										</div>
										<div class="custom-control custom-checkbox small">
											<input type="radio" class="custom-control-input" id="gender2"
												name="user_gen" value="1" checked> <label
												class="custom-control-label" for="gender2">여자</label>
										</div>
										<%
											}
										%>
									</div>
								</div>
								<button id="submitbtn" type="submit"
									class="btn btn-primary btn-user btn-block">확인</button>
								<a href="index.do" class="btn btn-primary btn-user btn-block">취소</a>
							</form>
							<hr>

						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Bootstrap core JavaScript-->

	<!-- Core plugin JavaScript-->

	<!-- Custom scripts for all pages-->
	<script type="text/javascript">
		function check() {
			if ($("input[name=userName]").val() == "") {

				alert("이름을 입력해 주세요.");

				$("input[name=userName]").focus();

				return false;

			} else if ($("input[name=userPassword]").val() == "") {

				alert("비밀번호를 입력해 주세요.");

				$("input[name=userPassword]").focus();

				return false;

			} else if ($("input[name=PasswordRepeat]").val() == "") {

				alert("비밀번호 확인을 입력해 주세요.");

				$("input[name=PasswordRepeat]").focus();

				return false;

			} else if ($("input[name=userEmail]").val() == "") {

				alert("이메일을 입력해 주세요.");

				$("input[name=userEmail]").focus();

				return false;

			} else if ($("input[name=userDate]").val() == "") {

				alert("생년월일을 입력해 주세요.");

				$("input[name=userDate]").focus();

				return false;

			} else if ($("input[name=userTel]").val() == "") {

				alert("전화번호를 입력해 주세요.");

				$("input[name=userTel]").focus();

				return false;

			}

			else
				return true;
		}
	</script>
</body>

</html>
