<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.UserDTO"%>
<%@ page import="poly.dto.recDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	UserDTO uDTO = (UserDTO) request.getAttribute("uDTO");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>BookShelf</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap"
	rel="stylesheet">

<link href="/css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="/css/animate.css">

<link rel="stylesheet" href="/css/owl.carousel.min.css">
<link rel="stylesheet" href="/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/css/magnific-popup.css">

<link rel="stylesheet" href="/css/aos.css">

<link rel="stylesheet" href="/css/ionicons.min.css">

<link rel="stylesheet" href="/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/css/jquery.timepicker.css">


<link rel="stylesheet" href="/css/flaticon.css">
<link rel="stylesheet" href="/css/icomoon.css">
<link rel="stylesheet" href="/css/style.css">
<script type="text/javascript">
function doModifyUserCkeck(f) {
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
<style type="text/css">
.info_title {
	margin-top: 0.5px;
	margin-bottom: 0.5px;
	padding-left: 10px;
	float: left;
	display: inline-block;
	width: 25%;
	border-top: 0.125px solid saddlebrown;
	border-bottom: 0.125px solid saddlebrown;
	border-right: 0.25px solid saddlebrown;
	display: inline-block;
}

.info_cont {
	margin-top: 0.5px;
	margin-bottom: 0.5px;
	padding-left: 10px;
	float: left;
	display: inline-block;
	border-top: 0.125px solid saddlebrown;
	border-bottom: 0.125px solid saddlebrown;
	width: 70%;
}

ul {
	padding-inline-start: 0px !important;
}

@media ( max-width :900px) {
	ul {
		font-size: 12px;
	}
}
</style>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
</head>
<body>

	<%
		if (userId == null) {
	%>
	<%@include file="/WEB-INF/view/main/frame/TopbarLogout.jsp"%>
	<%
		} else {
	%>
	<%
		if (userAuthor.equals("1")) {
	%>
	<%@include file="/WEB-INF/view/main/frame/TopbarLoginAdmin.jsp"%>
	<%
		} else {
	%>
	<%@include file="/WEB-INF/view/main/frame/TopbarLoginUser.jsp"%>
	<%
		}
	%>
	<%
		}
	%>

	<!-- END nav -->
	<section class="ftco-section goto-here">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12 heading-section text-center ftco-animate mb-5">
					<span class="subheading">회원 관리</span>
				</div>
			</div>
			<!-- Pie Chart -->
			<div class="col-xl-8 col-lg-7" style="margin: auto;">
				<div class="card shadow mb-4">
					<!-- Card Header - Dropdown -->
					<div
						class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">회원 정보 수정</h6>
					</div>
					<!-- Card Body -->
					<form name="f" action="updateCrmUserInfo.do"
						onsubmit="return doModifyUserCkeck(this)" method="post">
						<div class="card-body" style="text-align: left;">
							<div class="form-group">
								<input type="text" class="form-control form-control-user"
									name="user_id" placeholder="ID" value="<%=uDTO.getUser_id()%>"
									readonly required="required">
							</div>
							<div class="form-group">
								<input type="text" class="form-control form-control-user"
									name="user_name" placeholder="이름"
									value="<%=uDTO.getUser_name()%>" required="required">
							</div>
							<div class="form-group row">
								<div class="col-sm-6 mb-3 mb-sm-0">
									<input type="password" class="form-control form-control-user"
										name="password" maxlength="16" placeholder="비밀번호"
										style="ime-mode: disabled;" required="required">
								</div>
								<div class="col-sm-6">
									<input type="password" class="form-control form-control-user"
										name="RepeatPassword" placeholder="비밀번호 재입력"
										style="ime-mode: disabled;" required="required">
								</div>
							</div>
							<div class="form-group">
								<input type="email" class="form-control form-control-user"
									name="user_mail" placeholder="Email"
									value="<%=uDTO.getUser_mail()%>" readonly required="required">
							</div>
							<div class="form-group row">
								<div class="col-sm-6 mb-3 mb-sm-0">
									<input type="date" class="form-control form-control-user"
										name="user_date" placeholder=""
										value="<%=uDTO.getUser_date()%>" required="required">
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
						</div>
						<div class="modal-footer" style="text-align: right;">
							<a href="/crm.do?pgNum=1" class="btn btn-primary">취소</a>
							<button type="submit" class="btn btn-primary">확인</button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</section>

	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

	<!-- Custom scripts for all pages-->
	<script src="/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script>
		function checkPW(PwCheck) {
			if (PwCheck.userPassword.value == "") {
				alert("비밀번호를 입력하세요.");
				PwCheck.userPassword.focus();
				return false;
			}
		}
	</script>
</body>
</html>