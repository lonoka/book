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
			<h4 class="mt-4 mb-3">개인정보취급방침</h4>

			<hr>
			<!-- Post Content Column -->
			<div class="col_lg_8">
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; amp; amp; amp; amp; amp; quot; Apple SD Gothic Neo&amp;amp; amp; amp; amp; amp; amp; quot; , &amp; amp; amp; amp; amp; amp; amp; quot; Malgun Gothic&amp;amp; amp; amp; amp; amp; amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">
					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">1. 개인정보의
							처리 목적</span></span>
				</p>
				<span
					style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
					style="box-sizing: border-box; font-size: 12px;">
						&nbsp;&lt;책방&gt;(‘BookShelf.com’이하 ‘BookShelf’) 은(는) 다음의 목적을 위하여
						개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.<br>- 고객 가입의사 확인,
						고객에 대한 서비스 제공에 따른 본인 식별.인증, 회원자격 유지.관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품
						또는 서비스의 공급.배송 등
				</span></span> <br> <br>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; amp; amp; amp; amp; amp; quot; Apple SD Gothic Neo&amp;amp; amp; amp; amp; amp; amp; quot; , &amp; amp; amp; amp; amp; amp; amp; quot; Malgun Gothic&amp;amp; amp; amp; amp; amp; amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">

					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">2.개인정보의 처리
							및 보유 기간</span></span>
				</p>

				<span
					style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
					style="box-sizing: border-box; font-size: 12px;">①
						&lt;책방&gt;(‘BookShelf.com’이하 ‘BookShelf’) 은(는) 정보주체로부터 개인정보를 수집할 때
						동의 받은 개인정보 보유․이용기간 또는 법령에 따른 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.<br>
						② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다.<br>☞ 아래 예시를 참고하여 개인정보 처리업무와
						개인정보 처리업무에 대한 보유기간 및 관련 법령, 근거 등을 기재합니다.<br>(예시)- 고객 가입 및 관리
						: 서비스 이용계약 또는 회원가입 해지시까지, 다만 채권․채무관계 잔존시에는 해당 채권․채무관계 정산시까지<br>-
						전자상거래에서의 계약․청약철회, 대금결제, 재화 등 공급기록 : 5년
				</span></span> <br> <br>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; amp; amp; amp; amp; amp; quot; Apple SD Gothic Neo&amp;amp; amp; amp; amp; amp; amp; quot; , &amp; amp; amp; amp; amp; amp; amp; quot; Malgun Gothic&amp;amp; amp; amp; amp; amp; amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">

					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">3. 정보주체와
							법정대리인의 권리·의무 및 그 행사방법 이용자는 개인정보주체로써 다음과 같은 권리를 행사할 수 있습니다.</span></span>
				</p>

				<span
					style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
					style="box-sizing: border-box; font-size: 12px;"> ① 정보주체는
						책방(‘BookShelf.com’이하 ‘BookShelf) 에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를
						행사할 수 있습니다.<br>1. 개인정보 열람요구<br>2. 오류 등이 있을 경우 정정 요구<br>3.
						삭제요구<br>4. 처리정지 요구
				</span></span> <br> <br>
				<p
					style="margin-top: 10px; margin-bottom: 10px; box-sizing: border-box; color: rgb(68, 68, 68); font-family: &amp; amp; amp; amp; amp; amp; amp; quot; Apple SD Gothic Neo&amp;amp; amp; amp; amp; amp; amp; quot; , &amp; amp; amp; amp; amp; amp; amp; quot; Malgun Gothic&amp;amp; amp; amp; amp; amp; amp; quot; , NanumGothic , Dotum, helvetica, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">

					<span
						style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
						style="box-sizing: border-box; font-size: 12px;">4. 처리하는
							개인정보의 항목 작성</span></span>
				</p>

				<span
					style="box-sizing: border-box; font-family: arial, helvetica, sans-serif;"><span
					style="box-sizing: border-box; font-size: 12px;">
						&lt;책방&gt;('BookShelf.com'이하 'BookShelf')은(는) 다음의 개인정보 항목을 처리하고
						있습니다.<br> - 필수항목 : 이메일, 비밀번호, 로그인ID, 성별, 생년월일, 이름<br>-
						선택항목 :
				</span></span>


				<hr>
			</div>
		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>