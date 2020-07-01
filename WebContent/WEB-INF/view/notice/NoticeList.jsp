<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.NoticeDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	List<NoticeDTO> nList = (List<NoticeDTO>) request.getAttribute("nList");
	if (nList == null) {
		nList = new ArrayList();
	}
	int pgNum = (int) request.getAttribute("pgNum");
	int total = (int) request.getAttribute("total");
	int totalpg = (total - 1) / 8 + 1;
	NoticeDTO n = new NoticeDTO();
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
					<span class="subheading">공지 사항</span>
				</div>
			</div>
			<div class="row">
				<%
					for (NoticeDTO nDTO : nList) {
				%>
				<%
					String str = nDTO.getContents();
						str = str.replaceAll("<[^>]*>", "");
						String title = nDTO.getTitle();
				%>
				<div class="col-md-3 d-flex ftco-animate">
					<div class="blog-entry justify-content-end">
						<div class="text">
							<h3 class="heading">
								<a
									href="/NoticeDetail.do?Notice_seq=<%=nDTO.getNotice_seq()%>&Rownum=<%=nDTO.getRownum()%>&pgNum=<%=pgNum%>">
									<p>
										<%
											if (title.length() > 25) {
													title = title.substring(0, 24);
										%>
										<%=title%>...
										<%
											} else {
										%>
										<%=title%>
										<%
											}
										%>
									</p>
								</a>
							</h3>
							<div class="meta mb-3">
								<div>
									<a href="#"><%=nDTO.getChg_dt()%></a>
								</div>
								<div>
									<a href="#"><%=nDTO.getChg_id()%></a>
								</div>
								<div>
									<a href="#" class="meta-chat"><span class="icon-chat"></span>
										<%=nDTO.getRead_cnt()%></a>
								</div>
							</div>
							<p>
								<%
									if (str.length() > 40) {
											str = str.substring(0, 39);
								%>
								<%=str%>...
								<%
									} else {
								%>
								<%=str%>
								<%
									}
								%>

							</p>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>


			<%
				if (userId != null) {
			%>
			<%
				if (userAuthor.equals("1")) {
			%>
			<div class="notice-btn">
				<a href="/NoticeReg.do" class="btn_list">글 등록</a>
			</div>
			<%
				}
			%>
			<%
				}
			%>

			<div class="row mt-5">
				<div class="col text-center">
					<div class="block-27">
						<ul>
							<li>
								<%
									if (pgNum == 1) {
								%> <a href="#">&lt;</a> <%
 	} else {
 %> <a href="/NoticeList.do?pgNum=<%=pgNum - 1%>">&lt;</a> <%
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
							<li><a href="/NoticeList.do?pgNum=<%=i%>"><%=i%></a></li>
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
							<li><a href="/NoticeList.do?pgNum=<%=i%>"><%=i%></a></li>
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
							<li><a href="/NoticeList.do?pgNum=<%=i%>"><%=i%></a></li>
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
							<li><a href="/NoticeList.do?pgNum=<%=i%>"><%=i%></a></li>
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
							<li><a href="/NoticeList.do?pgNum=<%=i%>"><%=i%></a></li>
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
 %> <a href="/NoticeList.do?pgNum=<%=pgNum + 1%>">&gt;</a> <%
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
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>