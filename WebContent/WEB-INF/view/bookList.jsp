<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
</style>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js"></script>	
<script type="text/javascript">
	var nav = null;
	var map;
	var marker;
	/* 현재 위치(위도/경도)를 받아오기 위한 부분 */
	$(function() {
		if (nav == null) {
			nav = window.navigator;
		}
		if (nav != null) {
			var geoloc = nav.geolocation;
			if (geoloc != null) {
				/* Callback 성공 시, successCallback() 호출 */
				geoloc.getCurrentPosition(successCallback);
			} else {
				alert("geolocation not supported");
			}
		} else {
			alert("fef4dd1d3c9c7321ddb75c7f23bb319e");
		}
	});

	function successCallback(position) {
		/* 위도 */var latitude = position.coords.latitude;
		/* 경도 */var longitude = position.coords.longitude;

		/* Google Map으로 위도와 경도 초기화 */
		initialize(latitude, longitude);
	}

	function initialize(latitude, longitude) {
		/* 현재 위치의 위도와 경도 정보를 currentLocatioon 에 초기화 */
		var currentLocation = new google.maps.LatLng(latitude, longitude);
		var mapOptions = {
			center : currentLocation, /* 지도에 보여질 위치 */
			zoom : 14, /* 지도 줌 (0축소 ~ 18확대),  */
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		/* DIV에 지도 달아주기 */
		map = new google.maps.Map(document.getElementById("map_canvas"),
				mapOptions);
		/* 지도 위에 마커 달아주기 */
		marker = new google.maps.Marker({
			position : currentLocation,
			map : map
		});
		google.maps.event.addListener(marker, 'click', toggleBounce(marker));

		// This event listener will call addMarker() when the map is clicked.
		/* 지도에서 마우스 클릭시 마커 생성 */
		google.maps.event.addListener(map, 'click', function(event) {
			addMarker(event.latLng);
		});
	}

	// Add a marker to the map and push to the array.
	/*
	 * 이 소스는 마커를 하나만 추가할 수 있도록 구현해놓습니다.
	 * 개발자분들 재량에 따라 코드를 응용하도록 하세요.  
	 */
	function addMarker(location) {
		/* 기존에 있던 마커 삭제 후 */
		/*새 마커 추가하기. */
		marker.setMap(null);
		marker = new google.maps.Marker({
			position : location,
			map : map
		});
		/* 마커 토글바운스 이벤트 걸어주기(마커가 통통 튀도록 애니메이션을 걸어줌) */
		google.maps.event.addListener(marker, 'click', toggleBounce(marker));
	}

	function toggleBounce(marker) {
		if (marker.getAnimation() != null) {
			marker.setAnimation(null);
		} else {
			marker.setAnimation(google.maps.Animation.BOUNCE);
		}
	}
	google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>
	<div id="map_canvas" style="width: 600px; height: 600px; border: 1px solid black;"></div>
</body>

<script src="/js/jquery.min.js"></script>
<script src="/js/jquery-migrate-3.0.1.min.js"></script>
<script src="/js/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.easing.1.3.js"></script>
<script src="/js/jquery.waypoints.min.js"></script>
<script src="/js/jquery.stellar.min.js"></script>
<script src="/js/owl.carousel.min.js"></script>
<script src="/js/jquery.magnific-popup.min.js"></script>
<script src="/js/aos.js"></script>
<script src="/js/jquery.animateNumber.min.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/jquery.timepicker.min.js"></script>
<script src="/js/scrollax.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="/js/google-map.js"></script>
<script src="/js/main.js"></script>

</html>