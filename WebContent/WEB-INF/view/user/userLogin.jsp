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
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/css/sb-admin-2.min.css" rel="stylesheet">

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
							<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">책장 로그인</h1>
									</div>
									<form class="user" action="Loginbtn.do" method="post">
										<div class="form-group">
											<input type="text" class="form-control form-control-user"
												name="userId" placeholder="ID" required="required">
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user"
												name="userPassword" placeholder="Password" style="ime-mode:disabled;" required="required">
										</div>
										<div class="form-group">
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input"
													id="customCheck" name="userCheck"> <label
													class="custom-control-label" for="customCheck">ID
													기억하기</label>
											</div>
										</div>
										<button type="submit"
											class="btn btn-primary btn-user btn-block">Login</button>
										<hr>

									</form>

									<div class="text-center">
										<a class="small" href="/userRegForm.do">회원가입</a>
									</div>
									<div class="text-center">
										<a class="small" href="/userFind.do">아이디/비밀번호 찾기</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/js/sb-admin-2.min.js"></script>
	<script>
		window.onload = function() {
			var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
			$('input[name=userId]').val(userInputId);

			if ($('input[name=userId]').val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩
				// 아이디 저장하기 체크되어있을 시,
				$('input[name=userCheck]').attr("checked", true); // ID 저장하기를 체크 상태로 두기.
			}

			$('input[name=userCheck]').change(function() { // 체크박스에 변화가 발생시
				if ($('input[name=userCheck]').is(":checked")) { // ID 저장하기 체크했을 때,
					var userInputId = $('input[name=userId]').val();
					setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
				} else { // ID 저장하기 체크 해제 시,
					deleteCookie("userInputId");
				}
			});

			// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
			$('input[name=userId]').keyup(function() { // ID 입력 칸에 ID를 입력할 때,
				if ($('input[name=userCheck]').is(":checked")) { // ID 저장하기를 체크한 상태라면,
					var userInputId = $('input[name=userId]').val();
					setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
				}
			});
		};

		function setCookie(cookieName, value, exdays) {
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);
			var cookieValue = escape(value)
					+ ((exdays == null) ? "" : "; expires="
							+ exdate.toGMTString());
			document.cookie = cookieName + "=" + cookieValue;
		}

		function deleteCookie(cookieName) {
			var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);
			document.cookie = cookieName + "= " + "; expires="
					+ expireDate.toGMTString();
		}

		function getCookie(cookieName) {
			cookieName = cookieName + '=';
			var cookieData = document.cookie;
			var start = cookieData.indexOf(cookieName);
			var cookieValue = '';
			if (start != -1) {
				start += cookieName.length;
				var end = cookieData.indexOf(';', start);
				if (end == -1)
					end = cookieData.length;
				cookieValue = cookieData.substring(start, end);
			}
			return unescape(cookieValue);
		}
	</script>

</body>

</html>
