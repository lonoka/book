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
<script>
	function checkID(findID) {
		if (findID.user_name.value == "") {
			alert("이름을 입력하세요.");
			findID.user_name.focus();
			return false;
		}
		if (findID.user_date.value == "") {
			alert("생년월일을 입력하세요.");
			findID.user_date.focus();
			return false;
		}
		if (findID.user_mail.value == "") {
			alert("Email을 입력하세요.");
			findID.user_mail.focus();
			return false;
		}
	}

	function checkPW(findPW) {
		if (findPW.user_name.value == "") {
			alert("이름을 입력하세요.");
			findPW.user_name.focus();
			return false;
		}
		if (findPW.user_id.value == "") {
			alert("아이디를 입력하세요.");
			findPW.user_id.focus();
			return false;
		}
		if (findPW.user_date.value == "") {
			alert("생년월일을 입력하세요.");
			findPW.user_date.focus();
			return false;
		}
		if (findPW.user_mail.value == "") {
			alert("Email을 입력하세요.");
			findPW.user_mail.focus();
			return false;
		}
	}
</script>
</head>

<body class="bg-gradient-saddle">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-2">아이디/비밀번호 찾기</h1>
										<p class="mb-4">회원가입시 등록한 정보를 입력하여 아이디/비밀번호를 찾을 수 있습니다.
											등록한 정보가 기억나지 않는다면 고객문의를 이용해주세요.</p>
									</div>
									<form name="findID" method="post" class="user" action="/findID.do"
										onsubmit="return checkID(this)">
										<div class="form-group">
											<input type="text" class="form-control form-control-user"
												name="user_name" placeholder="이름">
										</div>
										<div class="form-group">
											<input type="date" class="form-control form-control-user"
												name="user_date">
										</div>
										<div class="form-group">
											<input type="email" class="form-control form-control-user"
												name="user_mail" placeholder="Email">
										</div>
										<button type="submit"
											class="btn btn-primary btn-user btn-block">아이디 찾기</button>
									</form>
									<hr>
									<form name="findPW" method="post" class="user" action="/findPW.do"
										onsubmit="return checkPW(this)">
										<div class="form-group">
											<input type="text" class="form-control form-control-user"
												name="user_name" placeholder="이름">
										</div>
										<div class="form-group">
											<input type="text" class="form-control form-control-user"
												name="user_id" placeholder="아이디">
										</div>
										<div class="form-group">
											<input type="date" class="form-control form-control-user"
												name="user_date">
										</div>
										<div class="form-group">
											<input type="email" class="form-control form-control-user"
												name="user_mail" placeholder="Email">
										</div>
										<button type="submit"
											class="btn btn-primary btn-user btn-block">비밀번호 찾기</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	0
	<!-- Bootstrap core JavaScript-->

	<!-- Core plugin JavaScript-->

	<!-- Custom scripts for all pages-->


</body>

</html>
