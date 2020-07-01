<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mailForm</title>
<style>
body {
	color: #1e1e1e;
	line-height: 24px;
	font-family: 'NotoSans Regular', 'Malgun Gothic', '맑은 고딕',
		'Apple SD Gothic Neo', '돋움', dotum, sans-serif;
	font-size: 14px;
	background-color: #ffffff;
	margin: 0;
}

.btn {
	width: 120px;
	height: 40px;
	background-color: #ffffff;
	border: 1px solid #000000;
	cursor:pointer;
}

.btn:hover {
	background-color: #000000;
	color: #ffffff
}

.row {
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	margin-right: -.75rem;
	margin-left: -.75rem
}

.controls {
	width: 100%;
	margin-bottom: 1rem;
}

@media ( min-width :576px) {
	.form-group {
		display: -webkit-box;
		display: -ms-flexbox;
		display: flex;
		-webkit-box-flex: 0;
		-ms-flex: 0 0 auto;
		flex: 0 0 auto;
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		-ms-flex-flow: row wrap;
		flex-flow: row wrap;
		-webkit-box-align: center;
		-ms-flex-align: center;
		align-items: center;
		margin-bottom: 0
	}
}

.form-control {
	display: block;
	width: 100%;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	font-weight: 400;
	line-height: 1.5;
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

@media ( prefers-reduced-motion : reduce) {
	.form-control {
		transition: none;
	}
}

.form-control::-ms-expand {
	background-color: transparent;
	border: 0;
}

.form-control:focus {
	color: #495057;
	background-color: #fff;
	border-color: #80bdff;
	outline: 0;
	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.form-control::-webkit-input-placeholder {
	color: #6c757d;
	opacity: 1;
}

.form-control::-moz-placeholder {
	color: #6c757d;
	opacity: 1;
}

.form-control:-ms-input-placeholder {
	color: #6c757d;
	opacity: 1;
}

.form-control::-ms-input-placeholder {
	color: #6c757d;
	opacity: 1;
}

.form-control::placeholder {
	color: #6c757d;
	opacity: 1;
}

.form-control:disabled, .form-control[readonly] {
	background-color: #e9ecef;
	opacity: 1;
}

select.form-control:focus::-ms-value {
	color: #495057;
	background-color: #fff;
}

textarea {
	font-family: inherit;
	font-size: inherit;
	line-height: inherit;
	overflow: auto;
	resize: vertical;
}

textarea.form-control {
	height: auto;
}

.was-validated textarea.form-control:valid, textarea.form-control.is-valid
	{
	padding-right: calc(1.5em + 0.75rem);
	background-position: top calc(0.375em + 0.1875rem) right
		calc(0.375em + 0.1875rem);
}
</style>
</head>
<body>
	<div style="margin: auto; width: 500px;">
		<div class="row">
			<form action="/mail/sendMail.do" onsubmit="return check()"
				method="post">
				<div class="form-group">
					<div class="controls">
						<h2>메일 발송</h2>
						<label>toMail :</label> <input class="form-control" name="toMail"
							required type="text">
					</div>
				</div>
				<div class="form-group">
					<div class="controls">
						<label>title :</label> <input class="form-control" name="title"
							required type="tel">
					</div>
				</div>
				<div class="form-group">
					<div class="controls">
						<label>content :</label>
						<textarea class="form-control" cols="100" name="contents"
							maxlength="999" required rows="10" style="resize: none"></textarea>
					</div>
				</div>
				<!-- For success/fail messages -->
				<button class="btn" type="submit">Mail 전송</button>
				<button class="btn" type="reset">취소</button>
			</form>
		</div>
	</div>
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
</body>
</html>