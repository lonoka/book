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
	<iframe id="map_find" frameborder="0" marginheight="0" marginwidth="0"
		scrolling="no" src="" width="100%" height="100%"></iframe>
	<script type='text/javascript'>
	
	var sLoc = "서울 강서구 화곡동 1089-25";
	var eLoc = "서울 서초구 반포대로 201반포동";

	$(document).ready(function(){
	var url = "http://map.daum.net/?sName=" + sLoc + "&eName=" + eLoc;
	document.getElementById("map_find").src = url;
	});
	</script>

</body>
</html>