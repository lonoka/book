<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.BookDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	List<BookDTO> bList = (List<BookDTO>) request.getAttribute("bList");
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

	<div class="hero-wrap ftco-degree-bg"
		style="background-image: url('images/bg_1.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text justify-content-center align-items-center">
				<div class="col-lg-8 col-md-6 ftco-animate d-flex align-items-end">
					<div class="text text-center">
						<h1 class="mb-4" style="color: azure;">
							The Simplest <br>Way to Find Book
						</h1>
						<p style="font-size: 18px; color: azure;">Resolve to edge in a
							little reading every day, if it is but a single sentence. If you
							gain fifteen minutes a day, it will make itself felt at the end
							of the year.</p>
						<form action="/searchBook.do" class="search-location mt-md-5"
							onsubmit="return searchCheck();">
							<div class="row justify-content-center">
								<div class="col-lg-10 align-items-end">
									<div class="form-group">
										<div class="form-field">
											<input type="text" class="form-control form-control-search"
												name="keyword" placeholder="제목,저자,발행자에서 검색합니다.">
											<button type="submit" style="cursor: pointer;">
												<span class="ion-ios-search"></span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="mouse">
			<a href="#" class="mouse-icon">
				<div class="mouse-wheel">
					<span class="ion-ios-arrow-round-down"></span>
				</div>
			</a>
		</div>
	</div>
	<br>
	<section class="ftco-section goto-here">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12 heading-section text-center ftco-animate mb-5">
					<span class="subheading">책장의 추천 도서</span>
					<h2 class="mb-2">사람들이 가장 많이 찾은 도서</h2>
				</div>
			</div>
			<div class="row">
				<%
					for (BookDTO bDTO : bList) {
				%>
				<div class="col-md-4">
					<div class="property-wrap ftco-animate">

						<a
							href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=<%=bDTO.getCover_url()%>"
							class="img"
							style="background-image: url(<%=bDTO.getCover_url()%>);"></a>
						<div class="text">
							<h3>
								<a
									href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=<%=bDTO.getCover_url()%>">제목
									: <%=bDTO.getTitle()%></a>
							</h3>
							<p>
								<span class="">저자 : <%=bDTO.getAuthor()%></span>
							</p>
							<p>
								<span class="">출판사 : <%=bDTO.getPublisher()%></span>
							</p>
							<a
								href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=<%=bDTO.getCover_url()%>"
								class="d-flex align-items-center justify-content-center btn-custom">
								<span class="ion-ios-link"></span>
							</a>
						</div>


					</div>
				</div>
				<%
					}
				%>
				<div class="col-md-12 heading-section text-center ftco-animate mb-5">
					<span class="subheading"><a href="/recommend.do">다른 추천도서 보러가기</a></span>
				</div>
			</div>
		</div>
	</section>

	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

</body>
</html>