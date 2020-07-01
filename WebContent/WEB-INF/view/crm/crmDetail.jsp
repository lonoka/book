<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.UserDTO"%>
<%@ page import="poly.dto.recDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
	List<recDTO> rList = (List<recDTO>) request.getAttribute("rList");
	UserDTO uDTO = (UserDTO) request.getAttribute("uDTO");
	recDTO rDTO = (recDTO) request.getAttribute("rDTO");
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

<link href="/css/sb-admin-2.min.css" rel="stylesheet">
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
<style type="text/css">
.info_title {
	margin-top:0.5px;
	margin-bottom : 0.5px;
	display: inline-block;
	width: 25%;
	display: inline-block;
	font-weight:bold;
}

.info_cont {
	margin-top:0.5px;
	margin-bottom : 0.5px;
	display: inline-block;
	width: 70%;
}

ul {
	padding-inline-start: 0px !important;
}

@media ( max-width :900px) {
	ul {
		font-size: 14px;
	}
}
</style>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
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
					<span class="subheading">회원 관리</span>
				</div>
			</div>
			<div class="row">
				<!-- Pie Chart -->
				<div class="col-xl-4 col-lg-5">
					<div class="card shadow mb-4">
						<!-- Card Header - Dropdown -->
						<div
							class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">분류별 검색 기록</h6>
						</div>
						<!-- Card Body -->
						<div class="card-body">
							<div class="chart-area">
								<canvas id="myPieChart"></canvas>
							</div>
						</div>
					</div>
				</div>
				<!-- Area Chart -->
				<div class="col-xl-8 col-lg-7">
					<div class="card shadow mb-4">
						<!-- Card Header - Dropdown -->
						<div
							class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">상세 검색 기록</h6>
						</div>
						<!-- Card Body -->
						<div class="card-body">
							<div class="chart-area">
								<canvas id="myAreaChart"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
				<div
					class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
					<h6 class="m-0 font-weight-bold text-primary">회원 정보</h6>
					<div class="dropdown no-arrow">
						<a class="dropdown-toggle" href="/crmUserModify.do?userId=<%=uDTO.getUser_id() %>" role="button" id=""> 수정 </a>
					</div>
				</div>
				<!-- Card Body -->
				<div class="card-body">
					<div class="row">
						<div class="col-md">
							<div class="ftco-footer-widget">
								<ul class="features"
									style="margin-bottom: 0; list-style-type: none;">
									<li class="check"><div class="info_title">ID</div>
										<div class="info_cont"><%=uDTO.getUser_id()%></div></li>
									<li class="check"><div class="info_title">이름</div>
										<div class="info_cont"><%=uDTO.getUser_name()%></div></li>
									<li class="check"><div class="info_title">Email</div>
										<div class="info_cont"><%=uDTO.getUser_mail()%></div></li>
									<li class="check"><div class="info_title">생년월일</div>
										<div class="info_cont"><%=uDTO.getUser_date()%></div></li>
									<li class="check"><div class="info_title">성별</div>
										<div class="info_cont"><%=uDTO.getUser_gen()%></div></li>
									<li class="check"><div class="info_title">가입일</div>
										<div class="info_cont"><%=uDTO.getReg_dt()%></div></li>
								</ul>
							</div>
						</div>
						<div class="col-md">
							<div class="ftco-footer-widget">
								<ul class="features"
									style="margin-bottom: 0; list-style-type: none;">
									<li class="check"><div class="info_title">수정자</div>
										<div class="info_cont"><%=uDTO.getChg_id()%></div></li>
									<li class="check"><div class="info_title">수정일</div>
										<div class="info_cont"><%=uDTO.getChg_dt()%></div></li>
									<li class="check"><div class="info_title">회원권한</div>
										<div class="info_cont"><%=uDTO.getUser_author()%></div></li>
									<li class="check"><div class="info_title">회원상태</div>
										<div class="info_cont"><%=uDTO.getUser_stat()%></div></li>
									<%if(uDTO.getUser_del()==null){ %>
									<li class="check"><div class="info_title">삭제일</div>
										<div class="info_cont"> - </div></li>
									<%} else {%>
									<li class="check"><div class="info_title">삭제일</div>
										<div class="info_cont"><%=uDTO.getUser_del()%></div></li>
									<%} %>
								</ul>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>

	<%@include file="/WEB-INF/view/main/frame/Footer.jsp"%>

	<!-- Custom scripts for all pages-->
	<script src="/js/sb-admin-2.min.js"></script>
	<script>
		var num0 = "<%=rDTO.getNum0()%>";
		var num1 = "<%=rDTO.getNum1()%>";
		var num2 = "<%=rDTO.getNum2()%>";
		var num3 = "<%=rDTO.getNum3()%>";
		var num4 = "<%=rDTO.getNum4()%>";
		var num5 = "<%=rDTO.getNum5()%>";
		var num6 = "<%=rDTO.getNum6()%>";
		var num7 = "<%=rDTO.getNum7()%>";
		var num8 = "<%=rDTO.getNum8()%>";
		var num9 = "<%=rDTO.getNum9()%>";
		var ctx = document.getElementById("myPieChart");
		var myPieChart = new Chart(ctx, {
			type : 'doughnut',
			data : {
				labels : [ "총류", "철학", "종교", "사회과학", "자연과학", "기술과학", "예술",
						"언어", "문학", "역사" ],
				datasets : [ {
					data : [ num0, num1, num2, num3, num4, num5, num6, num7,
							num8, num9 ],
					backgroundColor : [ "#00AF50", "#E83D36", "#A6A6A6",
							"#FF7F00", "#924B0D", "#01B0F1", "#FECF37",
							"#92D051", "#0170C1", "#7F53AA" ],
					hoverBackgroundColor : [ "#00AF50", "#E83D36", "#A6A6A6",
							"#FF7F00", "#924B0D", "#01B0F1", "#FECF37",
							"#92D051", "#0170C1", "#7F53AA" ]
				} ]
			},
			options : {
				legend:{
					display: false
				},
				
				maintainAspectRatio : false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
				cutoutPercentage : 70,
			}
		});
	</script>
	<script>
		var chartLabels = [];
		var chartData = [];
		var mylist = [];
		var loop = 0;
		<%for (int i = 0; i < rList.size(); i++) {%>
		mylist[loop] = {
				name :"<%=rList.get(i).getClassfy()%>",
				count:"<%=rList.get(i).getCount()%>"
		};
		loop++;
		<%}%>
		if (loop > 10) {
			for (var i = 0; i < 10; i++) {
				chartLabels.push(mylist[i].name);
				chartData.push(mylist[i].count);
			}
		} else {
			for (var i = 0; i < loop; i++) {
				chartLabels.push(mylist[i].name);
				chartData.push(mylist[i].count);
			}
		}
		var ctx = document.getElementById("myAreaChart");
		var myBarChart = new Chart(ctx, {
			type : 'bar',
			data : {

				labels : chartLabels,
				datasets : [ {
					label : '상세 검색 기록',
					data : chartData,
					barThickness : 40,
					backgroundColor : [ "#FFDF0D", "#FFD70D", "#E8B50C",
							"#E8AD0C", "#FFAA01", "#FEA000", "#E8870C",
							"#E87C0C", "#FF710D", "#FF650D" ],
					hoverBackgroundColor : [ "#FFDF0D", "#FFD70D", "#E8B50C",
							"#E8AD0C", "#FFAA01", "#FEA000", "#E8870C",
							"#E87C0C", "#FF710D", "#FF650D" ]
				} ]
			},
			options : {
				legend : {
					display : false
				},
				maintainAspectRatio : false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true,
							callback : function(value) {
								if (Number.isInteger(value)) {
									return value;
								}
							},
							stepSize : 1

						}
					} ]
				}
			}
		});
	</script>

	<!-- Page level plugins -->

</body>
</html>