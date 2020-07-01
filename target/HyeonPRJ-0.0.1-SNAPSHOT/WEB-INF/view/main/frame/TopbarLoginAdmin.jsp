<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav
	class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
	id="ftco-navbar">
	<div class="container">
		<a class="navbar-brand" href="/index.do">책장</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#ftco-nav" aria-controls="ftco-nav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
		</button>

		<div class="collapse navbar-collapse" id="ftco-nav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a href="/Logoutbtn.do" class="nav-link">Logout</a></li>
				<li class="nav-item"><a href="/mypage.do" class="nav-link">MYPAGE</a></li>
				<li class="nav-item"><a href="/crm.do?pgNum=1" class="nav-link">회원관리</a></li>
				<li class="nav-item"><a href="/NoticeList.do?pgNum=1" class="nav-link">공지사항</a></li>
				<li class="nav-item"><a href="/contact.do" class="nav-link">고객문의</a></li>
			</ul>
		</div>
	</div>
</nav>