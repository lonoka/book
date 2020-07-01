<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	String sLoc = (String) request.getAttribute("sLoc");
	String eLoc = (String) request.getAttribute("eLoc");
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
#google_map {
	height: 500px;
	width: 100%;
}

@media ( max-width : 991.98px) {
	#google_map {
		height: 300px;
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
				<div class="col-md-10">
					<div id="" class="bg-white">
						<iframe id="google_map" frameborder="0" marginheight="0"
							marginwidth="0" scrolling="no"
							src="http://map.daum.net/?sName=<%=sLoc%>&eName=<%=eLoc%>"
							width="100%"></iframe>
					</div>
				</div>
			</div>
			<br>


		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fef4dd1d3c9c7321ddb75c7f23bb319e&libraries=services">	
	</script>
	<script type='text/javascript'>
		var filter = "win16|win32|win64|mac|macintel";
		if (navigator.platform) {
			if (filter.indexOf(navigator.platform.toLowerCase()) < 0) {
				alert('mobile 접속');
			} else {
				//pc
				alert('pc 접속');
			}
		}
	</script>

</body>
</html>