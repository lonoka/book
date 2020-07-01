<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.UserDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
%>
<%
	List<UserDTO> uList = (List<UserDTO>) request.getAttribute("uList");
%>
<%
	int total = (int) request.getAttribute("total");
	int pgNum = (int) request.getAttribute("pgNum");
	String searchCont = (String) request.getAttribute("searchCont");
	String searchSelect = (String) request.getAttribute("searchSelect");
	int totalpg = (total - 1) / 10 + 1;
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
.div_content_container {
	display: table;
	table-layout: fixed;
	width: 100%;
	border: 1px solid #dee2e6;
}

.div_content_box {
	display: table-cell;
	border: 1px solid #dee2e6;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	padding-top: 12px;
	padding-bottom: 12px;
}

@media ( max-width :900px) {
	.btn_list {
		width: 70px !important;
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


	<section class="ftco-section contact-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12 heading-section text-center ftco-animate mb-5">
					<span class="subheading">회원 관리</span>
				</div>
			</div>
			<div class="row" style="margin: 0; margin-bottom: 1em;">
				<div class="select_box">
					<select name="searchSelect"
						class="custom-select form-control search_form"
						style="background: url(/images/arrow.jpg) no-repeat 95% 40% !important;">
						<option value="userId">회원ID</option>
						<option value="userName">이름</option>
						<option value="userStat">상태</option>
					</select>
				</div>
				<div class="search_box">
					<div class="input-group">
						<input name="searchCont" type="search"
							class="form-control search_input" placeholder=""
							aria-controls="dataTable" style="width: 175px">
						<div class="input-group-append">
							<button onclick="test()" class="btn search_btn" type="button">
								<span class="ion-ios-search icon-color"></span>
							</button>
						</div>
					</div>
				</div>
			</div>
			<div class="div_content_container"
				style="color: #666666; font-weight: bold;">
				<div style="display: table-row;">
					<div class="table_1st div_content_box"></div>
					<div class="table_2nd div_content_box">회원ID</div>
					<div class="table_3rd div_content_box">이름</div>
					<div class="table_4th div_content_box">성별</div>
					<div class="table_5th div_content_box">이메일</div>
					<div class="table_6th div_content_box">권한</div>
					<div class="table_7th div_content_box">상태</div>
					<div class="table_8th div_content_box">탈퇴날짜</div>
				</div>
			</div>
			<%
				if (total == 0) {
			%>
			<div class="div_content_container"
				style="color: #666666; font-weight: bold;">
				<div style="display: table-row;">
					<div class="div_content_box" style="text-align: center;">회원
						정보가 없습니다.</div>
				</div>
			</div>
			<%
				} else {
			%>
			<%
				for (UserDTO uDTO : uList) {
			%>
			<div class="div_content_container">
				<div style="display: table-row;">
					<div class="table_1st div_content_box">
						<input type="radio" class="" name="userCheck"
							value="<%=uDTO.getUser_id()%>">
					</div>
					<div class="table_2nd div_content_box"><%=uDTO.getUser_id()%></div>
					<div class="table_3rd div_content_box"><%=uDTO.getUser_name()%></div>
					<div class="table_4th div_content_box">
						<%
							if (uDTO.getUser_gen().equals("0")) {
						%>
						M
						<%
							} else if (uDTO.getUser_gen().equals("1")) {
						%>
						F
						<%
							} else {
						%>
						O
						<%
							}
						%>
					</div>
					<div class="table_5th div_content_box"><%=uDTO.getUser_mail()%></div>
					<div class="table_6th div_content_box">
						<%
							if (uDTO.getUser_author().equals("0")) {
						%>
						사용자
						<%
							} else {
						%>
						관리자
						<%
							}
						%>
					</div>
					<div class="table_7th div_content_box">
						<%
							if (uDTO.getUser_stat().equals("0")) {
						%>
						정상
						<%
							} else if (uDTO.getUser_stat().equals("1")) {
						%>
						정지
						<%
							} else {
						%>
						탈퇴
						<%
							}
						%>
					</div>
					<div class="table_8th div_content_box">
						<%
							if (uDTO.getUser_del() == null) {
						%>
						-
						<%
							} else {
						%>
						<%=uDTO.getUser_del()%>
						<%
							}
						%>
					</div>
				</div>
			</div>

			<%
				}
			%>
			<%
				}
			%>

			<div class="row" style="margin-top: 1em;">
				<div class="notice_btn">
					<div class="btn_list" style="margin-left: 0.25em; cursor: pointer;">회원
						탈퇴</div>
					<div class="btn_list" style="margin-left: 0.25em; cursor: pointer;">활동
						정지</div>
					<div class="btn_list" style="margin-left: 0.25em; cursor: pointer;">권한
						변경</div>
					<div onclick="userDetail()" class="btn_list"
						style="margin-left: 0.2em; margin-right: 0.2em; cursor: pointer;">상세
						보기</div>
				</div>
			</div>
			<div class="row">
				<div class="col text-center">
					<div class="block-27">
						<ul>
							<li>
								<%
									if (pgNum == 1) {
								%> <a href="#">&lt;</a> <%
 	} else {
 %> <a
								href="/crmMovePage.do?pgNum=<%=pgNum - 1%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>">&lt;</a>
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
							<li><a
								href="/crmMovePage.do?pgNum=<%=i%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>"><%=i%></a></li>
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
							<li><a
								href="/crmMovePage.do?pgNum=<%=i%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>"><%=i%></a></li>
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
							<li><a
								href="/crmMovePage.do?pgNum=<%=i%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>"><%=i%></a></li>
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
							<li><a
								href="/crmMovePage.do?pgNum=<%=i%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>"><%=i%></a></li>
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
							<li><a
								href="/crmMovePage.do?pgNum=<%=i%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>"><%=i%></a></li>
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
 %> <a
								href="/crmMovePage.do?pgNum=<%=pgNum + 1%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>">&gt;</a>
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
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script>
		function test() {
			if ($("input[name=searchCont]").val() == "") {
				alert("검색어를 입력해 주세요.");
				$("input[name=searchCont]").focus();
			} else {
				document.location.href = "/crmSearch.do?pgNum=1&searchCont="
						+ $("input[name=searchCont]").val() + "&searchSelect="
						+ $("select[name=searchSelect]").val();
			}

			/* if (confirm("권한을 변경하시겠습니까?") == true) {
				document.location.href = "/manager/ModifyAuthorProc.do?userCheck="
						+ $("input:radio[name=userCheck]:checked").val();
			} else {
				return false;
			} */
		}
		function modifyAuthor() {
			//alert($("input:radio[name=userCheck]:checked").val());

			if (confirm("권한을 변경하시겠습니까?") == true) {
				document.location.href = "/ModifyAuthorProc.do?userCheck="
						+ $("input:radio[name=userCheck]:checked").val();
			} else {
				return false;
			}
		}
		function modifyStat() {
			//alert($("input:radio[name=userCheck]:checked").val());

			if (confirm("유저상태를 변경하시겠습니까?") == true) {
				document.location.href = "/ModifyStatProc.do?userCheck="
						+ $("input:radio[name=userCheck]:checked").val();
			} else {
				return false;
			}
		}
		function modifyDel() {
			//alert($("input:radio[name=userCheck]:checked").val());

			if (confirm("유저상태를 변경하시겠습니까?") == true) {
				document.location.href = "/ModifyDelProc.do?userCheck="
						+ $("input:radio[name=userCheck]:checked").val();
			} else {
				return false;
			}
		}
		function userDetail() {
			document.location.href = "/checkUserDetail.do?userCheck="
					+ $("input:radio[name=userCheck]:checked").val();
		}
	</script>
</body>
</html>