<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	String eLoc = (String) request.getAttribute("eLoc");
	String LocName = (String) request.getAttribute("LocName");
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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>

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
#map_find {
	height: 700px;
	width: 100%;
}

@media ( max-width : 991.98px) {
	#map_find {
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
					<div id="" class="bg-white">
						<iframe id="map_find" frameborder="0" marginheight="0"
							marginwidth="0" scrolling="no" src="" width="100%"></iframe>
					</div>
			<br>
		</div>
	</section>
	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fef4dd1d3c9c7321ddb75c7f23bb319e&libraries=services">	
	</script>
	<script>
	var sLoc = "";
	var eLoc = "<%=eLoc%>";
	var LocName = "<%=LocName%>";
		var xLoc = 0;
		var yLoc = 0;
		// 좌표 검색
		var latitude = 0;
		var longitude = 0;
		// 좌표 검색 끝
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('fef4dd1d3c9c7321ddb75c7f23bb319e');

		navigator.geolocation.getCurrentPosition(function(pos) {
			latitude = pos.coords.latitude;
			longitude = pos.coords.longitude;
			console.log(latitude);
			console.log(longitude);
			var geocoder = new kakao.maps.services.Geocoder();
			var coord = new kakao.maps.LatLng(latitude, longitude);
			var callback = function(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					xLoc = result[0].x;
					yLoc = result[0].y;
					Kakao.Navi.start({
						name : LocName,
						x : Number(xLoc),
						y : Number(yLoc),
						coordType : 'wgs84'
					});

				}
			};

			var callback2 = function(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					sLoc = result[0].address.address_name;
					var url = "http://map.daum.net/?sName=" + sLoc + "&eName="
							+ eLoc;
					document.getElementById("map_find").src = url;
				}
			};

			geocoder.coord2Address(coord.getLng(), coord.getLat(), callback2);
			geocoder.addressSearch(eLoc, callback);
		});
	</script>

</body>
</html>