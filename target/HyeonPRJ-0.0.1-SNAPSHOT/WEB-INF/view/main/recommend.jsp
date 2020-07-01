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
	<section class="ftco-section goto-here">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12 heading-section text-center ftco-animate mb-5">
					<span class="subheading">책장의 추천 도서</span>
					<h2 class="mb-2">맞춤 추천 도서</h2>
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
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-md-12 heading-section text-center ftco-animate mb-5">
				<span class="subheading">다른 추천도서 항목</span>
			</div>
		</div>
		<div style="text-align: center;">
			<div class="search_box">
				<div class="input-group" style="width:250px; margin:auto; ">
					<select name="searchSelect"
						class="custom-select form-control">
						<option value="userId">10대 남자</option>
						<option value="userName">10대 여자</option>
						<option value="userStat">소설</option>
						<option value="userStat">수필</option>
						<option value="userStat">전공도서</option>
					</select>
					<div class="input-group-append">
						<button onclick="test()" class="btn search_btn" type="button">
							<span class="ion-ios-search icon-color" style="font-size:20px;"></span>
						</button>
					</div>
				</div>
			</div>
		</div>

	</section>

	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

</body>
</html>