<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.BookDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	List<BookDTO> bList = (List<BookDTO>) request.getAttribute("bList");
	int pgNum = (int) request.getAttribute("pgNum");
	int total = (int) request.getAttribute("total");
	String keyword = (String) request.getAttribute("keyword");
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	int totalpg = (total - 1) / 9 + 1;
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
					<span class="subheading">검색 결과</span>
				</div>
			</div>
			<div class="row">
				<%
					for (BookDTO bDTO : bList) {
				%>
				<div class="col-md-4">
					<div class="property-wrap ftco-animate">
						<%
							if (bDTO.getCover_url() != null) {
						%>
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
						<%
							} else {
						%>
						<a
							href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=/images/errorbook.jpg"
							class="img" style="background-image: url(/images/errorbook.jpg);"></a>
						<div class="text">
							<h3>
								<a
									href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=/images/errorbook.jpg">제목
									: <%=bDTO.getTitle()%></a>
							</h3>
							<p>
								<span class="">저자 : <%=bDTO.getAuthor()%></span>
							</p>
							<p>
								<span class="">출판사 : <%=bDTO.getPublisher()%></span>
							</p>
							<a
								href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=/images/errorbook.jpg"
								class="d-flex align-items-center justify-content-center btn-custom">
								<span class="ion-ios-link"></span>
							</a>
						</div>
						<%
							}
						%>

					</div>
				</div>
				<%
					}
				%>
			</div>
			<div class="row mt-5">
				<div class="col text-center">
					<div class="block-27">
						<ul>
							<li>
								<%
									if (pgNum == 1) {
								%> <a href="#">&lt;</a> <%
 	} else {
 %> <a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=pgNum - 1%>">&lt;</a>
								<%
									}
								%>
							</li>
							<%
								if (totalpg < 5) {
									for (int i = 1; i <= totalpg; i++) {
										if (i == pgNum) {
							%>
							<li class="active"><span><%=pgNum%></span></li>
							<%
								} else {
							%>
							<li><a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=i%>"><%=i%></a></li>
							<%
								}
									}
								} else {
									if (pgNum < 4) {
										for (int i = 1; i < 6; i++) {
											if (i == pgNum) {
							%>
							<li class="active"><span><%=pgNum%></span></li>
							<%
								} else {
							%>
							<li><a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=i%>"><%=i%></a></li>
							<%
								}
										}
									} else if (totalpg - 1 == pgNum) {
										for (int i = pgNum - 3; i <= totalpg; i++) {
											if (i == pgNum) {
							%>
							<li class="active"><span><%=pgNum%></span></li>
							<%
								} else {
							%>
							<li><a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=i%>"><%=i%></a></li>
							<%
								}
										}
									} else if (totalpg == pgNum) {
										for (int i = pgNum - 4; i <= totalpg; i++) {
											if (i == pgNum) {
							%>
							<li class="active"><span><%=pgNum%></span></li>
							<%
								} else {
							%>
							<li><a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=i%>"><%=i%></a></li>
							<%
								}
										}
									} else {
										for (int i = pgNum - 2; i < pgNum + 3; i++) {
											if (i == pgNum) {
							%>
							<li class="active"><span><%=pgNum%></span></li>
							<%
								} else {
							%>
							<li><a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=i%>"><%=i%></a></li>
							<%
								}
										}
									}
								}
							%>

							<li>
								<%
									if (pgNum == totalpg) {
								%> <a href="#">&gt;</a> <%
 	} else {
 %> <a href="/movePage.do?keyword=<%=keyword%>&pgNum=<%=pgNum + 1%>">&gt;</a>
								<%
									}
								%>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

</body>
</html>