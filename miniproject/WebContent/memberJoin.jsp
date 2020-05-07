<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
.wrongdata {
	border-color: red;
}
</style>
<script>
	/*function chkUid() {
		var uid = document.joinform.uid;
		if (uid.value.length() == 0) {
			return false;
		} else {
			return true;
		}
	}

	function chkPwd() {

	}

	function chkEmail() {

	}

	function chkAddress() {

	}

	function chkProfile() {

	}
	
	function dataCheck() {
		if (!chkUid()) return;
		if (!chkPwd()) return;
		if (!chkEmail()) return;
		if (!chkAddress()) return;
		if (!chkProfile()) return;
		document.joinform.submit();
	}*/

	function checkID() {
		window.name = "parent";
		newWin = window
				.open('checkID.jsp?uid=', 'child',
						'width=500, height=350, left=100, top=500 ,menubar=no, status=no, toolbar=no');
	}

	function viewProfile() {
		var files = document.getElementById('profile').files[0];
		var reader = new FileReader();

		reader.onload = (function(theFile) {
			return function(e) {
				document.getElementById('preview').src = e.target.result;
			};
		})(files);
		reader.readAsDataURL(files);
	}

	function postCode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						var fullAddr = '';
						var extraAddr = '';

						if (data.userSelectedType === 'R')
							fullAddr = data.roadAddress;
						else
							fullAddr = data.jibunAddress;

						if (data.userSelectedType === 'R') {
							if (data.bname !== '')
								extraAddr += data.bname;
							if (data.buildingName !== '')
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						document.getElementById("zipcode").value = data.zonecode; //5자리 새우편번호 사용
						//document.getElementById("jusocode").value = data.postcode;
						document.getElementById("address1").value = fullAddr;
						document.getElementById("address2").focus();
					}
				}).open();
	} //execDaumPostcode end==================================================
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="0" name="active" />
	</jsp:include>
	<div class="card-body">
		<h3>회원가입</h3>
		<form action="memberWrite.jsp" method="post"
			enctype="multipart/form-data" name="joinform">
			<table class="table">
				<tr>
					<td>
						<div class="form-group" style="width: 60%; min-width: 300px;">
							<label for="uid">ID</label>
							<div class="input-group input-group-sm">

								<input type="text" class="form-control" name="uid" id="uid"
									readonly required>
								<div class="input-group-append">
									<button class="btn btn-primary" type="button"
										onclick="checkID();">중복체크</button>
								</div>
							</div>
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<div class="form-group" style="width: 60%; min-width: 300px;">
							<label for="name">닉네임</label> <input type="text"
								class="form-control form-control-sm" name="name" required>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 60%; min-width: 300px;">
							<label for="pwd">비밀번호</label> <input type="password"
								class="form-control form-control-sm" name="pwd" required>
						</div>
						<div class="form-group" style="width: 60%; min-width: 300px;">
							<label for="pwdchk">비밀번호 확인</label> <input type="password"
								class="form-control form-control-sm" name="pwdchk" required>
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<div class="form-group" style="width: 70%; min-width: 350px;">
							<label for="email">이메일</label> <input type="text"
								class="form-control form-control-sm" name="email" required>
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<div class="form-group" style="width: 40%; min-width: 200px;">
							<label for="zipcode">우편번호</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" id="zipcode"
									name="zipcode" readonly required>
								<div class="input-group-append">
									<button class="btn btn-primary" type="button"
										onclick="postCode();">검색</button>
								</div>
							</div>
						</div>

						<div class="form-group" style="width: 90%; min-width: 350px;">
							<label for="address1">주소</label> <input type="text"
								class="form-control form-control-sm" id="address1"
								name="address1" readonly required>
						</div>

						<div class="form-group" style="width: 90%; min-width: 350px;">
							<label for="address2">상세주소</label> <input type="text"
								class="form-control form-control-sm" id="address2"
								name="address2" required>
						</div>

					</td>
				</tr>
				<tr>
					<td><label>프로필 사진</label>
						<div class="row">
							<div class="col-sm-4">
								<img src="./images/anonymous.png" class="rounded-circle"
									id="preview"
									style="width: 180px; height: 180px; border: 4px solid #BDBDBD;">
							</div>
							<div class="col-sm-8" style="vertical-align: text-bottom">
								<div class="form-group">
									<label for="profile">파일 첨부</label> <input type="file"
										class="form-control form-control" style="height: 45px;"
										name="profile" id="profile" onchange="viewProfile();">
								</div>
							</div>
						</div></td>
				</tr>
				<tr>
					<td style="text-align: center">
						<button class="btn btn-success" type="submit">
							<span class="li_user"></span> 회원가입
						</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>