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
	int totalpg  = (total-1)/10 +1;
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
						class="custom-select form-control search_form">
						<option value="userId">회원ID</option>
						<option value="userName">이름</option>
						<option value="userStat">상태</option>
					</select>
				</div>
				<div class="search_box">
					<div class="input-group">
						<input name="searchCont" type="search"
							class="form-control search_input" placeholder=""
							aria-controls="dataTable">
						<div class="input-group-append">
							<button onclick="test()" class="btn search_btn" type="button">
								<span class="ion-ios-search icon-color"></span>
							</button>
						</div>
					</div>
				</div>
			</div>
			<table class="table table-bordered" id="" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th class="table_1st"></th>
						<th class="table_2nd">회원ID</th>
						<th class="table_3rd">이름</th>
						<th class="table_4th">성별</th>
						<th class="table_5th">이메일</th>
						<th class="table_6th">권한</th>
						<th class="table_7th">상태</th>
						<th class="table_8th">탈퇴날짜</th>
					</tr>
				</thead>
				<tbody>
				<%
						if (total == 0) {
					%>
					<tr>
						<td colspan="8" style="text-align: center"><span
							class="txt_public">회원정보가 없습니다.</span></td>
					</tr>
					<%
						} else {
					%>
					<%
						for (UserDTO uDTO : uList) {
					%>
					<tr>
						<td class="table_1st"><input type="radio" class=""
							name="userCheck" value="<%=uDTO.getUser_id()%>"></td>
						<td class="table_2nd"><%=uDTO.getUser_id()%></td>
						<td class="table_3rd"><%=uDTO.getUser_name()%></td>
						<td class="table_4th">
							<%
								if (uDTO.getUser_gen().equals("0")) {
							%> M <%
								} else if (uDTO.getUser_gen().equals("1")) {
							%> F <%
								} else {
							%> O <%
								}
							%>
						</td>
						<td class="table_5th"><%=uDTO.getUser_mail()%></td>
						<td class="table_6th">
							<%
								if (uDTO.getUser_author().equals("0")) {
							%> 사용자 <%
								} else {
							%> 관리자 <%
								}
							%>
						</td>
						<td class="table_7th">
							<%
								if (uDTO.getUser_stat().equals("0")) {
							%> 정상 <%
								} else if (uDTO.getUser_stat().equals("1")) {
							%> 정지 <%
								} else {
							%> 탈퇴 <%
								}
							%>
						</td>
						<td class="table_8th">
							<%
								if (uDTO.getUser_del().equals("2000-01-01 00:00:00")) {
							%> - <%
								} else {
							%> <%=uDTO.getUser_del()%> <%
 	}
 %>

						</td>
					</tr>
					<%
						}
					%>
					<%
						}
					%>

				</tbody>
			</table>

			<div class="row">
				<div class="notice_btn">
					<div class="btn_list" style="margin-left: 0.25em; cursor: pointer;">회원
						탈퇴</div>
					<div class="btn_list" style="margin-left: 0.25em; cursor: pointer;">활동
						정지</div>
					<div class="btn_list" style="margin-left: 0.25em; cursor: pointer;">권한
						변경</div>
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
							%>
							<%
								for (int i = 1; i <= totalpg; i++) {
							%>
							<%
								if (i == pgNum) {
							%>
							<li class="active"><span><%=pgNum%></span></li>
							<%
								} else {
							%>
							<li><a href="/crmMovePage.do?pgNum=<%=i%>&searchCont=<%=searchCont%>&searchSelect=<%=searchSelect%>"><%=i%></a></li>
							<%
								}
							%>
							<%
								}
							%>
							<%
								} else {
							%>
							<%
								if (pgNum < 4) {
							%>
							<%
								for (int i = 1; i < 6; i++) {
							%>
							<%
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
							%>
							<%
								}
							%>
							<%
								} else {
							%>
							<%
								for (int i = pgNum - 2; i < pgNum + 3; i++) {
							%>
							<%
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
							%>
							<%
								}
							%>
							<%
								}
							%>
							<%
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
	</script>
</body>
</html>