<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.BookDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	List<BookDTO> bList = (List<BookDTO>) request.getAttribute("bList");
	String title = (String) request.getAttribute("title");
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

<script type="text/javascript">
	function doChange1(srcE, targetId, targetId2) {
		var val = srcE.options[srcE.selectedIndex].text;
		var targetE = document.getElementById(targetId);
		var targetE2 = document.getElementById(targetId2);
		removeAll(targetE);
		removeAll(targetE2);

		if (val == '나이') {
			$('#sel1box').hide();
			$('#sel2box').css("display", "inline-block");
			$('#search_reset').css("display", "inline-block");
			addOption('10대', targetE);
			addOption('20대', targetE);
			addOption('30대', targetE);
			addOption('40대', targetE);
			addOption('50대', targetE);
		} else if (val == '분류') {
			$('#sel1box').hide();
			$('#sel2box').css("display", "inline-block");
			$('#search_reset').css("display", "inline-block");
			addOption('총류', targetE);
			addOption('철학', targetE);
			addOption('종교', targetE);
			addOption('사회과학', targetE);
			addOption('자연과학', targetE);
			addOption('기술과학', targetE);
			addOption('예술', targetE);
			addOption('언어', targetE);
			addOption('문학', targetE);
			addOption('역사', targetE);
		}
	}

	function doChange2(srcE, targetId) {
		var val = srcE.options[srcE.selectedIndex].text;
		var targetE = document.getElementById(targetId);
		removeAll(targetE);
		if (val == '10대') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('남자', targetE);
			addOption('여자', targetE);
		} else if (val == '20대') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('남자', targetE);
			addOption('여자', targetE);
		} else if (val == '30대') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('남자', targetE);
			addOption('여자', targetE);
		} else if (val == '40대') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('남자', targetE);
			addOption('여자', targetE);
		} else if (val == '50대') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('남자', targetE);
			addOption('여자', targetE);
		} else if (val == '총류') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('총류', targetE);
			addOption('도서학, 서지학', targetE);
			addOption('문헌정보학', targetE);
			addOption('백과사전', targetE);
			addOption('강연집, 수필집, 연설문집', targetE);
			addOption('일반 연속간행물', targetE);
			addOption('일반 학회, 단체, 협회, 기관', targetE);
			addOption('신문, 저널리즘', targetE);
			addOption('일반전집, 총서', targetE);
			addOption('향토자료', targetE);
		} else if (val == '철학') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('철학', targetE);
			addOption('형이상학', targetE);
			addOption('인식론, 인과론, 인간학', targetE);
			addOption('철학의 체계', targetE);
			addOption('경학', targetE);
			addOption('동양철학, 사상', targetE);
			addOption('서양철학', targetE);
			addOption('논리학', targetE);
			addOption('심리학', targetE);
			addOption('윤리학, 도덕철학', targetE);
		} else if (val == '종교') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('종교', targetE);
			addOption('비교종교', targetE);
			addOption('불교', targetE);
			addOption('기독교', targetE);
			addOption('도교', targetE);
			addOption('천도교', targetE);
			addOption('힌두교, 브라만교', targetE);
			addOption('이슬람교(회교)', targetE);
			addOption('기타 제종교', targetE);
		} else if (val == '사회과학') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('사회과학', targetE);
			addOption('통계자료', targetE);
			addOption('경제학', targetE);
			addOption('사회학, 사회문제', targetE);
			addOption('정치학', targetE);
			addOption('행정학', targetE);
			addOption('법률, 법학', targetE);
			addOption('교육학', targetE);
			addOption('풍속, 예절, 민속학', targetE);
			addOption('국방, 군사학', targetE);
		} else if (val == '자연과학') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('자연과학', targetE);
			addOption('수학', targetE);
			addOption('물리학', targetE);
			addOption('화학', targetE);
			addOption('천문학', targetE);
			addOption('지구과학', targetE);
			addOption('광물학', targetE);
			addOption('생명과학', targetE);
			addOption('식물학', targetE);
			addOption('동물학', targetE);
		} else if (val == '기술과학') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('기술과학', targetE);
			addOption('의학', targetE);
			addOption('농업, 농학', targetE);
			addOption('공학, 공업 일반, 토목공학, 환경공학', targetE);
			addOption('건축공학', targetE);
			addOption('기계공학', targetE);
			addOption('전기공학, 전자공학', targetE);
			addOption('화학공학', targetE);
			addOption('제조업', targetE);
			addOption('생활과학', targetE);
		} else if (val == '예술') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('예술', targetE);
			addOption('조각 및 조형미술', targetE);
			addOption('공예, 장식미술', targetE);
			addOption('서예', targetE);
			addOption('회화, 도화', targetE);
			addOption('사진예술', targetE);
			addOption('음악', targetE);
			addOption('공연예술 및 매체예술', targetE);
			addOption('오락, 스포츠', targetE);
		} else if (val == '언어') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('언어', targetE);
			addOption('한국어', targetE);
			addOption('중국어', targetE);
			addOption('일본어 및 기타 아시아제어', targetE);
			addOption('영어', targetE);
			addOption('독일어', targetE);
			addOption('프랑스어', targetE);
			addOption('스페인어', targetE);
			addOption('이탈리아어', targetE);
			addOption('기타 제어', targetE);
		} else if (val == '문학') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('문학', targetE);
			addOption('한국문학', targetE);
			addOption('중국문학', targetE);
			addOption('일본문학 및 기타 아시아문학', targetE);
			addOption('영미문학', targetE);
			addOption('독일문학', targetE);
			addOption('프랑스문학', targetE);
			addOption('스페인문학 및 포르투갈문학', targetE);
			addOption('이탈리아문학', targetE);
			addOption('기타 제문학', targetE);
		} else if (val == '역사') {
			$('#sel2box').hide();
			$('#sel3box').css("display", "inline-block");
			addOption('전체', targetE);
			addOption('역사', targetE);
			addOption('아시아', targetE);
			addOption('유럽', targetE);
			addOption('아프리카', targetE);
			addOption('북아메리카', targetE);
			addOption('남아메리카', targetE);
			addOption('오세아니아, 양극지방', targetE);
			addOption('미분류', targetE);
			addOption('지리', targetE);
			addOption('전기', targetE);
		}

	}

	function addOption(value, e) {
		var o = new Option(value);
		try {
			e.add(o);
		} catch (ee) {
			e.add(o, null);
		}
	}

	function removeAll(e) {
		for (var i = 0, limit = e.options.length; i < limit - 1; ++i) {
			e.remove(1);
		}
	}
	function search_reset() {
		var targetE1 = document.getElementById("sel1");
		var targetE2 = document.getElementById("sel2");
		var targetE3 = document.getElementById("sel3");
		removeAll(targetE1);
		removeAll(targetE2);
		removeAll(targetE3);
		addOption('전체', targetE1);
		addOption('회원', targetE1);
		addOption('비회원', targetE1);
		addOption('나이', targetE1);
		addOption('분류', targetE1);
		$('#sel2box').hide();
		$('#sel3box').hide();
		$('#sel1box').css("display", "inline-block");
		$('#search_reset').hide();
	}
	function test() {
		var val1 = $("#sel1 option:selected").text();
		var val2 = $("#sel2 option:selected").text();
		var val3 = $("#sel3 option:selected").text();

		if (val1 == "---선택---") {
			alert("조건을 선택해주세요.");
		} else if (val1 == "전체") {
			location.href = "/recSearch.do?val1=" + val1 + "&val2=" + val2
					+ "&val3=" + val3;
		} else if (val1 == "회원") {
			location.href = "/recSearch.do?val1=" + val1 + "&val2=" + val2
					+ "&val3=" + val3;
		} else if (val1 == "비회원") {
			location.href = "/recSearch.do?val1=" + val1 + "&val2=" + val2
					+ "&val3=" + val3;
		} else if (val1 == "나이" || val1 == "분류") {
			if (val2 == "---선택---") {
				alert("조건을 선택해주세요.");
			} else {
				if (val3 == "-------선택-------") {
					alert("조건을 선택해주세요.");
				} else {
					location.href = "/recSearch.do?val1=" + val1 + "&val2="
							+ val2 + "&val3=" + val3;
				}
			}
		}

	}
</script>
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
					<span class="subheading">책장의 추천 도서</span>
					<h2 class="mb-2"><%=title%></h2>
				</div>
			</div>
			<div class="row">
				<%
					for (BookDTO bDTO : bList) {
				%>
				<div class="col-md-4">
					<div class="property-wrap ftco-animate">

						<a
							href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=<%=bDTO.getCover_url()%>"
							class="img"
							style="background-image: url(<%=bDTO.getCover_url()%>);"></a>
						<div class="text">
							<h3>
								<a
									href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=<%=bDTO.getCover_url()%>">제목
									: <%=bDTO.getTitle()%></a>
							</h3>
							<p>
								<span class="">저자 : <%=bDTO.getAuthor()%></span>
							</p>
							<p>
								<span class="">출판사 : <%=bDTO.getPublisher()%></span>
							</p>
							<a
								href="searchDetail.do?rec_key=<%=bDTO.getRec_key()%>&cover_url=<%=bDTO.getCover_url()%>"
								class="d-flex align-items-center justify-content-center btn-custom">
								<span class="ion-ios-link"></span>
							</a>
						</div>


					</div>
				</div>
				<%
					}
				%>
				<div class="col-md-12 heading-section text-center ftco-animate"
					style="margin-bottom: 1em;">
					<span class="subheading">다른 추천도서 검색</span>
				</div>
				<div style="margin: auto">
					<span id="search_reset" class="search_box" style="display: none;">
						<button onclick="search_reset()" class="btn search_btn"
							type="button" style="height: 2.5em; width: 2.2em;">
							<span class="ion-ios-arrow-back icon-color"></span>
						</button>
					</span> <span id="sel1box" class="select_box"
						style="display: inline-block; width: 7em;"> <select
						id="sel1" name="searchSelect"
						onchange="doChange1(this,'sel2','sel3')"
						class="custom-select form-control search_form"
						style="background: url(/images/arrow.jpg) no-repeat 95% 40% !important;">
							<option value="default">---선택---</option>
							<option>전체</option>
							<option>회원</option>
							<option>비회원</option>
							<option>나이</option>
							<option>분류</option>
					</select>
					</span> <span id="sel2box" class="select_box"
						style="display: inline-block; width: 7em; display: none;">
						<select id="sel2" name="searchSelect"
						onchange="doChange2(this,'sel3')"
						class="custom-select form-control search_form"
						style="background: url(/images/arrow.jpg) no-repeat 95% 40% !important;">
							<option value="default">---선택---</option>
					</select>
					</span> <span id="sel3box" class="select_box"
						style="display: inline-block; width: 12em; display: none;">
						<select id="sel3" name="searchSelect"
						class="custom-select form-control search_form"
						style="background: url(/images/arrow.jpg) no-repeat 95% 40% !important;">
							<option value="default">-------선택-------</option>
					</select>
					</span> <span class="search_box" style="display: inline-block;">
						<button onclick="test()" class="btn search_btn" type="button"
							style="height: 2.5em; width: 2.2em;">
							<span class="ion-ios-search icon-color"></span>
						</button>
					</span>
				</div>
			</div>
		</div>
	</section>


	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

</body>
</html>