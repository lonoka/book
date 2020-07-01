<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
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
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3163.2203396777727!2d126.8401003156477!3d37.54987223283934!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c9c4194c94d4f%3A0xce340043894710eb!2z7ZWc6rWt7Y-066as7YWN64yA7ZWZIOyEnOyauOqwleyEnOy6oO2NvOyKpCBLb3JlYSBQb2x5dGVjaG5pY3M!5e0!3m2!1sko!2skr!4v1563882837313!5m2!1sko!2skr"
							width="100%"></iframe>
					</div>
				</div>
			</div>
			<br>
			<div class="row d-flex mb-5 contact-info justify-content-center">
				<div class="col-md-8">
					<div class="row">
						<div class="col-md-4 text-center py-4">
							<div class="icon">
								<span class="icon-map-o"></span>
							</div>
							<p>
								<span>Address:</span> 서울특별시 강서구 화곡동 우장산로10길 112
							</p>
						</div>
						<div class="col-md-4 text-center border-height py-4">
							<div class="icon">
								<span class="icon-mobile-phone"></span>
							</div>
							<p>
								<span>Phone:</span>1577-1234
							</p>
						</div>
						<div class="col-md-4 text-center py-4">
							<div class="icon">
								<span class="icon-envelope-o"></span>
							</div>
							<p>
								<span>Email:</span>dabookshelf2019@gmail.com
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row block-9 justify-content-center mb-5">
				<div class="col-md-8 mb-md-5">
					<form action="/contactSend.do" class="bg-light p-5 contact-form"
						onsubmit="return check()" method="post">
						<div class="control-group form-group">
							<div class="controls">
								<label>Full Name:</label> <input class="form-control"
									name="contactName" required type="text">
								<p class="help-block"></p>
							</div>
						</div>
						<div class="control-group form-group">
							<div class="controls">
								<label>Phone Number:</label> <input class="form-control"
									name="contactTel" required type="tel">
							</div>
						</div>
						<div class="control-group form-group">
							<div class="controls">
								<label>Email Address:</label> <input class="form-control"
									name="contactEmail" required type="email">
							</div>
						</div>
						<div class="control-group form-group">
							<div class="controls">
								<label>Message:</label>
								<textarea class="form-control" cols="100" name="contactMessage"
									maxlength="999" required rows="10" style="resize: none"></textarea>
							</div>
						</div>
						<div class="form-group">
							<input type="submit" value="Send Message"
								class="btn btn-primary py-3 px-5">
						</div>
					</form>

				</div>
			</div>
		</div>
	</section>

	<script>
		function check() {
			if ($("input[name=contactName]").val() == "") {
				$("input[name=contactName]").focus();

				return false;

			} else if ($("input[name=contactTel]").val() == "") {
				$("input[name=contactTel]").focus();

				return false;

			} else if ($("input[name=contactEmail]").val() == "") {
				$("input[name=contactEmail]").focus();

				return false;

			} else if ($("textarea[name=contactMessage]").val() == "") {
				$("textarea[name=contactMessage]").focus();

				return false;

			} else
				return true;
		}
	</script>

	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

</body>
</html>