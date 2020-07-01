<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	String sLoc = "서울특별시 강서구 화곡6동 화곡로 302";
	String eLoc = "서울특별시 서초구 반포대로 201반포동";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>API Demo - Kakao JavaScript SDK</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>

</head>
<body>
	<a id="navi" href="#" onclick="navi();"> <img
		src="/assets/img/about/buttons/navi/kakaonavi_btn_medium.png" />
	</a>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fef4dd1d3c9c7321ddb75c7f23bb319e&libraries=services">	
	</script>
	<script type='text/javascript'>
		var endLoc = "<%=eLoc%>";
		var xLoc = 0;
		var yLoc = 0;
		$(document).ready(function(){
			var geocoder = new kakao.maps.services.Geocoder();

			var callback = function(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					xLoc = result[0].x;
					yLoc = result[0].y;
				}
			};

			geocoder.addressSearch(endLoc, callback);
		});
		
		//<![CDATA[
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('fef4dd1d3c9c7321ddb75c7f23bb319e');
		// 카카오 로그인 버튼을 생성합니다.
		function navi() {
			Kakao.Navi.start({
				name : "현대백화점 판교점",
				x : Number(xLoc),
				y : Number(yLoc),
				coordType : 'wgs84'
			});
		}
		//]]>
	</script>

</body>
</html>