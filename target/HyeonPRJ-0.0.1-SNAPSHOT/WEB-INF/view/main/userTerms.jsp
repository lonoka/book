<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.NoticeDTO"%>
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

			<!-- Page Heading/Breadcrumbs -->
			<h4 class="mt-4 mb-3">이용자 약관</h4>

			<hr>
			<!-- Post Content Column -->
			<div class="col_lg_8">
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">
					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">제 1 장 총 칙</span></span>
				</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">&nbsp;</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">
					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">제 1 조 (목적)<br
							style="box-sizing: border-box;">이 약관은 {COMPANY_NAME}(이하
							"사이트"라 합니다)에서 제공하는 인터넷서비스(이하 "서비스"라 합니다)의 이용 조건 및 절차에 관한 기본적인 사항을
							규정함을 목적으로 합니다.
					</span></span>
				</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">&nbsp;</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">
					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">제 2 조 (약관의
							효력 및 변경)<br style="box-sizing: border-box;">① 이 약관은 서비스 화면이나
							기타의 방법으로 이용고객에게 공지함으로써 효력을 발생합니다.<br
							style="box-sizing: border-box;">② 사이트는 이 약관의 내용을 변경할 수 있으며,
							변경된 약관은 제1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.
					</span></span>
				</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">&nbsp;</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">
					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">제 3 조 (용어의
							정의)<br style="box-sizing: border-box;">이 약관에서 사용하는 용어의 정의는
							다음과 같습니다.<br style="box-sizing: border-box;">① 회원 : 사이트와 서비스
							이용계약을 체결하거나 이용자 아이디(ID)를 부여받은 개인 또는 단체를 말합니다.<br
							style="box-sizing: border-box;">② 신청자 : 회원가입을 신청하는 개인 또는 단체를
							말합니다.<br style="box-sizing: border-box;">③ 아이디(ID) : 회원의 식별과
							서비스 이용을 위하여 회원이 정하고 사이트가 승인하는 문자와 숫자의 조합을 말합니다.<br
							style="box-sizing: border-box;">④ 비밀번호 : 회원이 부여 받은 아이디(ID)와
							일치된 회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.<br
							style="box-sizing: border-box;">⑤ 해지 : 사이트 또는 회원이 서비스 이용계약을
							취소하는 것을 말합니다.
					</span></span>
				</p>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; quot; Apple SD Gothic Neo&amp;amp; quot; , &amp; amp; quot; Malgun Gothic&amp;amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">&nbsp;</p>


				<hr>
			</div>
		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>