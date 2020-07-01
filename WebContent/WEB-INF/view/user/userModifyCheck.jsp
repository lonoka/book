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
					<span class="subheading">MYPAGE</span>
				</div>
			</div>
			<!-- Pie Chart -->
			<div class="col-xl-4 col-lg-5" style="margin: auto;">
				<div class="card shadow mb-4">
					<!-- Card Header - Dropdown -->
					<div
						class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">회원 정보 수정</h6>
					</div>
					<!-- Card Body -->
					<form name="PwCheck" action="userModify.do" onsubmit="return checkPW(this)" method="post">
						<div class="card-body" style="text-align: center;">
							<div>비밀번호를 입력해 주세요.</div>
							<input type="password" class="form-control form-control-user"
								name="userPassword" placeholder="Password"
								style="ime-mode: disabled;" required="required">
						</div>
						<div class="modal-footer" style="text-align: right;">
							<a href="/mypage.do" class="btn btn-primary">취소</a>
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