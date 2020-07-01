<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.NoticeDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<!DOCTYPE html>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	NoticeDTO nDTO = (NoticeDTO) request.getAttribute("nDTO");
	String str = nDTO.getContents();	
	String title = nDTO.getTitle();
%>
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
			<div>
				<div class="help_cont">※ 공지사항 제목과 내용을 한번 더 확인해 주세요.</div>
			</div>
			<form method="post" id="regform" action="/NoticeModifyProc.do"
				onsubmit="return !!(check()&validation());">
				<hr>
				<div style="text-align: center">
					<div style="width: 10%; display: inline-block">제목</div>
					<div style="width: 80%; display: inline-block">
						<input type="text" placeholder="제목을 입력해주세요( 50 자 이하 )"
							name="title" id="title" maxlength="50" value='<%=title %>'
							style="width: 99%; padding: 0.25em">
					</div>
					<input type="hidden" name ="Notice_seq" value="<%= nDTO.getNotice_seq()%>">
				</div>
				<hr>
				<div style="text-align: center">
					<div style="width: 90%; display: inline-block">
						<textarea class="table_textbox" id="smarteditor"
							style="width: 99%; height: 20em;" name="contents"></textarea>
					</div>
				</div>
				<hr>
				<div style="text-align: center">
					<input type="button"
						onclick="location.href='/NoticeList.do?pgNum=1'"
						class="btn btn-primary" value="취소하기"> <input type="button"
						id="reg_btn" class="btn btn-primary" value="수정하기">
				</div>

			</form>

		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>
	<script src="/SE2/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
		function check() {
			if ($("input[name=title]").val() == "") {

				alert("제목을 입력해 주세요.");

				$("input[name=title]").focus();

				return false;

			}

			else {

				return true;
			}
		}
		var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함.
		$(document).ready(
				function() {
					document.querySelector('#smarteditor').value='<%=str%>';
					// Editor Setting
					nhn.husky.EZCreator.createInIFrame({
						oAppRef : oEditors, // 전역변수 명과 동일해야 함.
						elPlaceHolder : "smarteditor", // 에디터가 그려질 textarea ID 값과 동일 해야 함.
						sSkinURI : "/SE2/SmartEditor2Skin.html", // Editor HTML
						fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X
						htParams : {
							// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseToolbar : true,
							// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseVerticalResizer : true,
							// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
							bUseModeChanger : true,
						}
					});

					// 전송버튼 클릭이벤트
					$("#reg_btn").click(
							function() {
								if (confirm("저장하시겠습니까?")) {
									// id가 smarteditor인 textarea에 에디터에서 대입
									oEditors.getById["smarteditor"].exec(
											"UPDATE_CONTENTS_FIELD", []);
									// 이부분에 에디터 validation 검증
									if (validation()) {
										$("#regform").submit();
									}
								}
							})
				});

		// 필수값 Check
		function validation() {
			var contents = $.trim(oEditors[0].getContents());
			if (contents === '<p>&nbsp;</p>' || contents === '') { // 기본적으로 아무것도 입력하지 않아도 <p>&nbsp;</p> 값이 입력되어 있음. 
				alert("내용을 입력하세요.");
				oEditors.getById['smarteditor'].exec('FOCUS');
				return false;
			}

			return true;
		}

		// 글쓰기 저장 & 수정
		// function fWrite() {
		// 	if(validation()){
		// 		if(confirm("저장하시겠습니까?")) {
		// 			oEditors[0].exec("UPDATE_CONTENTS_FIELD", []); // Editor내용을 DB에 가져가기 위해 필수로 작성!
		// 														   // oEditors << 전역변수로 선언한 변수명과 동일해야 함.
		// 			$("#boardForm").attr('action','${pageContext.request.contextPath}/save').submit();
		// 		}
		// 	}
		// }
	</script>
</body>
</html>