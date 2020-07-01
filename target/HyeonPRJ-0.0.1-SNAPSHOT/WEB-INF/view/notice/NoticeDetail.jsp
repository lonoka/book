<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.NoticeDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	NoticeDTO nDTO = (NoticeDTO) request.getAttribute("nDTO");
	String str = nDTO.getContents();
	str = str.replaceAll("& lt;", "<");
	str = str.replaceAll("& gt;", ">");
	str = str.replaceAll("& #40;", "(");
	str = str.replaceAll("& #41;", ")");
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
			<h4 class="mt-4 mb-3"><%=nDTO.getTitle()%></h4>

			<!-- Post Content Column -->
			<div class="col_lg_8">


				<hr>

				<!-- Date/Time -->
				<p>
					<%=nDTO.getChg_dt()%>
					<small>by <%=nDTO.getChg_id()%></small>
				</p>

				<hr>

				<!-- Post Content -->
				<div id="notice_content" style="width: 100%"><%=str%></div>



			</div>
			<!-- /.col-lg-8 -->
			<%
				if (userId == null) {
			%>
			<div class="notice-btn">
				<hr>
				<a href="" class="btn_move">이전</a> <a href="" class="btn_move">다음</a>
				<a href="/NoticeList.do?pgNum=1" class="btn_list">목록</a>
			</div>
			<%
				} else {
			%>
			<%
				if (userAuthor.equals("1")) {
			%>
			<div class="notice-btn">
				<hr>
				<a href="/NoticeModify.do?Notice_seq=<%=nDTO.getNotice_seq() %>" class="btn_move">수정</a> 
				<a href="/NoticeDelete.do?Notice_seq=<%=nDTO.getNotice_seq() %>" class="btn_move">삭제</a>
				<a href="/NoticeList.do?pgNum=1" class="btn_list">목록</a>
			</div>
			<%
				} else {
			%>
			<div class="notice-btn">
				<hr>
				<a href="" class="btn_move">이전</a> <a href="" class="btn_move">다음</a>
				<a href="/NoticeList.do?pgNum=1" class="btn_list">목록</a>
			</div>
			<%
				}
			%>
			<%
				}
			%>
			

			<!-- /.row -->
		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>