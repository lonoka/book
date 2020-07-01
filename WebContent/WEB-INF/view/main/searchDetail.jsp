<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.BookDTO"%>
<%@ page import="poly.dto.LibraryDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	List<BookDTO> bList = (List<BookDTO>) request.getAttribute("bList");
	List<LibraryDTO> lList = (List<LibraryDTO>) request.getAttribute("lList");
	String cover_url = (String) request.getAttribute("cover_url");
	String rec_key = (String) request.getAttribute("rec_key");
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	BookDTO bDTO = bList.get(0);
	bDTO.setTitle_info(bDTO.getTitle_info().replaceAll(": ,", ": "));
	bDTO.setTitle_info(bDTO.getTitle_info().replaceAll("= ,", "= "));
	bDTO.setTitle_info(bDTO.getTitle_info().replaceAll("/ ,", "/ "));
	bDTO.setTitle_info(bDTO.getTitle_info().replaceAll(";,", " "));
	bDTO.setTitle_info(bDTO.getTitle_info().replaceAll(", ,", ", "));
	bDTO.setAuthor(bDTO.getTitle_info().substring(bDTO.getTitle_info().lastIndexOf("/")+2));
	bDTO.setTitle(bDTO.getTitle_info().substring(0,bDTO.getTitle_info().lastIndexOf("/")));
	bDTO.setPublish_info(bDTO.getPublish_info().replaceAll(":,", ": "));
	bDTO.setPublish_info(bDTO.getPublish_info().replaceAll(",,", " "));
	bDTO.setPublisher(bDTO.getPublish_info().substring(bDTO.getPublish_info().lastIndexOf(": ")+2,bDTO.getPublish_info().length()-4));
	
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
<style>
.modal_container {
	width: 500px;
}

@media ( max-width : 991.98px) {
	.star span:first-child span:nth-child(2) {
		display: none !important;
	}
}

@media ( max-width : 991.98px) {
	.star span:first-child span:nth-child() {
		width: 100%;
	}
}

@media ( max-width : 700.98px) {
	.title_text {
		font-size: 1.5rem;
	}
	.pills .review .desc {
		width: calc(100% - 10px);
		margin-left: 10px;
	}
	.lib_loc {
		width: 80% !important;
	}
}

@media ( max-width : 400px) {
	.btn_font {
		font-size: 12px;
		padding: 0.25rem 0.5rem;
	}
	.modal-body p {
		font-size: 12px;
	}
}
</style>
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
	<section class="ftco-section ftco-property-details">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12">
					<div class="property-details">
						<div class="img" style="background-image: url(<%=cover_url%>);"></div>
						<div class="text text-center">
							<h2 class="title_text"><%=bDTO.getTitle_info()%></h2>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 pills">
					<div class="bd-example bd-example-tabs">
						<div class="d-flex justify-content-center">
							<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">

								<li class="nav-item"><a class="nav-link active"
									id="pills-description-tab" data-toggle="pill"
									href="#pills-description" role="tab"
									aria-controls="pills-description" aria-expanded="true">도서정보</a>
								</li>
								<li class="nav-item"><a class="nav-link"
									id="pills-review-tab" data-toggle="pill" href="#pills-review"
									role="tab" aria-controls="pills-review" aria-expanded="true">도서관</a>
								</li>
							</ul>
						</div>

						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-description"
								role="tabpanel" aria-labelledby="pills-description-tab">
								<div class="row">
									<div class="col-md">
										<div class="ftco-footer-widget">
											<ul class="features"  style="margin-bottom:0;">
												<li class="check">출판사 : <%=bDTO.getPublish_info()%></li>
												<li class="check">도서형태 : <%=bDTO.getForm_info()%></li>
												<li class="check">총서사항 : <%=bDTO.getSeries_info()%></li>
												<li class="check">서지 주기사항 : <%=bDTO.getNote_info()%></li>
											</ul>
										</div>
									</div>
									<div class="col-md">
										<div class="ftco-footer-widget">
											<ul class="features"  style="margin-bottom:0;">
												<li class="check">표준번호/부호 : <%=bDTO.getStandard_info()%></li>
												<li class="check">분류기호 : <%=bDTO.getClassfy_info()%></li>
												<li class="check">가격정보 : <%=bDTO.getPrice_info()%></li>
											</ul>
										</div>
									</div>

								</div>
							</div>

							<div class="tab-pane fade" id="pills-review" role="tabpanel"
								aria-labelledby="pills-review-tab">
								<div class="row">
									<h3 class="head"><%=lList.size()%>개 도서관
									</h3>
									<%
										for (LibraryDTO lDTO : lList) {
									%>
									<div class="review d-flex">
										<div class="desc">
											<h4>
												<span class="text-left"><%=lDTO.getLib_name()%></span>
											</h4>
											<p class="star">
												<span> <span class="lib_loc">지역 : <%=lDTO.getLocal()%></span>
													<span class="lib_code">청구기호 : <%=lDTO.getCall_no()%></span>
												</span> <span class="text-right"><button data-toggle="modal"
														data-target="#Lib_code<%=lDTO.getLib_code()%>"
														class="btn btn-primary btn_font">상세정보</button></span>
											</p>
										</div>
									</div>
									<div class="modal fade" id="Lib_code<%=lDTO.getLib_code()%>"
										tabindex="-1" role="dialog"
										aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<!--Header-->
												<div class="modal-header">
													<h4 class="modal-title" id="myModalLabel"><%=lDTO.getLib_name()%></h4>
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">×</span>
													</button>
												</div>
												<!--Body-->
												<div class="modal-body" style="width: 500px;">
													<!-- 여기에 정보 넣어야함!!! 작성주잉었음 -->
													<p>
														TEL :
														<%=lDTO.getTel()%>
													</p>
													<p>
														FAX :
														<%=lDTO.getFax()%>
													</p>
													<p>
														주소 :
														<%=lDTO.getAddress()%>
													</p>
													<%
														if (lDTO.getHomepage().length() > 0 && !lDTO.getHomepage().equals("없음")) {
													%>
													<p>
														홈페이지 : <a href="http://<%=lDTO.getHomepage()%>"
															target="_blank" style="color: #666666;">http://<%=lDTO.getHomepage()%></a>
													</p>
													<%
														} else {
													%>
													<p>
														홈페이지 : 없음</a>
													</p>
													<%
														}
													%>

												</div>
												<!--Footer-->
												<div class="modal-footer">
													<button type="button" class="btn btn-outline-primary"
														data-dismiss="modal">닫기</button>
													<form action="/PathFind.do" method="post">
														<input type="hidden" name="eLoc" value="<%=lDTO.getAddress()%>"> 
														<input type="hidden" name="LocName" value="<%=lDTO.getLib_name()%>">
														<input type="hidden" name="Title" value="<%=bDTO.getTitle()%>">
														<input type="hidden" name="Author" value="<%=bDTO.getAuthor()%>">
														<input type="hidden" name="Publisher" value="<%=bDTO.getPublisher()%>">
														<input type="hidden" name="cover_url" value="<%=cover_url%>">
														<input type="hidden" name="Classfy" value="<%=bDTO.getClassfy_info()%>">
														<input type="hidden" name="rec_key" value="<%=rec_key%>">
														<button class="btn btn-primary">길찾기</button>
													</form>

												</div>
											</div>
										</div>
									</div>
									<%
										}
									%>


								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

</body>
</html>