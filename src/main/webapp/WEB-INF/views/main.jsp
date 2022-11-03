<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>순간포착</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="css/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="css/styles.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"></script>
<script>
function popUp(){
	alert("로그인을 해주세요");
}

function boardList() {
	 $.ajax({
   	url : "${cpath}/boardList",
   	type : "get",
   	dataType : "json",
   	success : callBack,
   	error : function(){alert("error");}
   });
}
function callBack(data){
	 var bList = "<table class='table table-bordered table-hover'>";
	 bList+="<tr>";
	 bList+="<th>번호</th>";
	 bList+="<th>위반사항</th>";
	 bList+="<th>작성일</th>";
	 bList+="<th>작성자</th>";
	 bList+="</tr>";
	 // data에 저장된 JSON데이터를 핸들링 -> 반복문
	 // [{"idx":1},{"title":"게시판",,,,},{   }]
	 $.each(data,(index,obj)=>{
		
	 let name = obj.name.split("");
	 let lastname = name[0];
	 let hidename = name[0]+"**";	 
		 
	 bList+="<tr>";
  	 bList+="<td>"+obj.bo_num+"</td>";
  	 bList+="<td id='t"+obj.bo_num+"'><a href='javascript:cview("+obj.bo_num+")'>"+obj.vr_ill+"</a></td>";
  	 bList+="<td>"+obj.bo_date+"</td>";
  	 bList+="<td id='w"+obj.bo_num+"'>"+hidename+"</td>";
  	 bList+="</tr>";        	     	 
		 
	 });
	 
	 bList+="<tr>";
	 

	 bList+="<button class='btn btn-sm btn-info' onclick='accbtn()'>제 보</button>";
	 
	 
	 bList+="</tr>";
	 bList+="</table>";
	 $("#mybox").css("display", "none");
	 $("#content").css("display", "none");
	 $("#video").css("display", "none");
	 $("#list").html(bList);
	 $("#accuse").css("display", "block");
	 $("#file").css("display", "none");
	 $("#list").css("display", "block");
	 $("#main").css("display", "none");
	 $("#now").css("display", "none");
	 $("#manual").css("display", "none");
}
	function accbtn() {
		$("#video").css("display", "none");
		$("#accuse").css("display", "block");
		$("#file").css("display", "block");
		$("#content").css("display", "none");
		$("#list").css("display", "none");
	}
	function idCheck() {
		// 1. id 가져오기
		let id = $('#id').val();
		// 2. ajax
		$.ajax({
			url : "${cpath}/idCheck",
			type : "post",
			data : {
				'id' : id
			},
			success : function(res) {
				if (res.id != id) {
					//사용가능한 아이디
					alert("사용가능한 아이디입니다.");
				} else {
					//중복된 아이디
					alert("중복된 아이디입니다.");
				}
				console.log(id);
			
			},
			error : function() {
				alert("error");
			}
		})
	}
function cloud() {
		 $.ajax({
	   	url : "${cpath}/cloud",
	   	type : "get",
	   	dataType : "json",
	   	success : cloudBox,
	   	error : function(){alert("error");}
	   });
	}
		 
function cloudBox(data) { // { }
	 var cList = "<table class='table table-bordered table-hover'>";
	 cList+="<tr>";
	 cList+="<th>파일명</th>";
	 cList+="</tr>";
	 // data에 저장된 JSON데이터를 핸들링 -> 반복문
	 // [{"idx":1},{"title":"게시판",,,,},{   }]
	 $.each(data,(index,obj)=>{
		 cList+="<tr>";
		 cList+="<td><a href='#' style='text-decoration:none' onclick='video_play("+obj.vo_title+")'>"+obj.vo_title+"</td></a>";
	  	 cList+="</tr>";
		 });
		 cList+="</table>";
	 $("#cloud").html(cList);
	 $("#mybox").css("display", "block");
	 $("#cloud").css("display", "block");
	 $("#accuse").css("display", "none");
	 $("#file").css("display", "none");
	 $("#list").css("display", "none");
	 $("#main").css("display", "none");
	 $("#now").css("display", "none");
	 $("#manual").css("display", "none");
	 $("#video").css("display", "block");

	}
	
	function video_play(vo_title) {		
		$("#video").css("display","block")
		$("#video").html('<source src="original/'+vo_title+'.mp4" type="video/mp4" muted></source>' );
		var video = document.getElementById('video');
		video.load();
	}
 
	function fileLoad() {
		// 1. filename 가져오기
		let vr_title = $('#vr_title').val()
		// 2. ajax
		$.ajax({
			url : "${cpath}/fileload",
			type : "post",
			data : {
				'vr_title' : vr_title
			},
			success : vr_video,
			error : function() {
				alert("error");
			}
		})
	}
	
	function vr_video(data) {
		
		$("#ill").html(data.vr_ill)
		$("#time").html(data.vr_illtime)
		$("#place").html(data.vr_long+" "+data.vr_lati)
		$("#plate").html(data.vr_plate)
		$("#content").css("display","block")
		$("#popup1").css("display","none")
		
	}
	function fileclear() {
		$("#vr_title").val("");
		$("#ill").html("");
		$("#time").html("");
		$("#place").html("");
		$("#plate").html("");
	}
	
	function login() {
		$("#video").css("display", "none");
			$(".joinForm").css("display", "none");
	        $(".login").css("display", "block"); 
	        $(".loginForm").css("display", "block"); 
	        $("#loginForm").css("display", "block"); 
	        $("body").append('<div class="backcon"></div>'); 
	}
	
	function logout(){
		$.ajax({
			url : "${cpath}/logout.do",
			type : "post",
			success : main,
			error : function() {
				alert("error");
			}
		})
	}
	
	function popClose(){
        $(".loginForm").css("display", "none")
        $("#loginForm").css("display", "none")
  	    $(".backcon").remove();
	}
	function join() {
		$(".login").css("display", "none");
		$(".joinForm").css("display", "block");
	}

	function main() {
		$("#now").css("display", "block");
		$("#main").css("display", "block");
		$("#mybox").css("display", "none");
		$("#accuse").css("display", "none");
		$("#manual").css("display", "none");
		$("#login").css("display", "block");
		$("#video").css("display", "none");
			
	}

	function accuse() {
		let vr_ill = $("#ill").text();
		let ill_time = $("#time").text();
		let name = $("#name").text();
		
		$.ajax({
			url : "${cpath}/insert",
			type : "post",
			data : {
				"vr_ill" : vr_ill,
				"ill_time" : ill_time,
				"name" : name
			},
			success : boardList,
			error : function() { alert("error");}
		});
		
		$("#video").css("display", "none");
		$("#list").css("display", "block");
		$("#now").css("display", "none");
		$("#main").css("display", "none");
		$("#mybox").css("display", "none");
		$("#cloud").css("display", "none");		
		$("#accuse").css("display", "block");
		$("#manual").css("display", "none");
	}

	function manual() {
		$("#video").css("display", "none");
		$("#list").css("display", "none");
		$("#now").css("display", "none");
		$("#main").css("display", "none");
		$("#mybox").css("display", "none");
		$("#accuse").css("display", "none");
		$("#manual").css("display", "block");
	}
</script>
</head>
<body id="page-top">

	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3"
		id="mainNav">
		<div class="container px-4 px-lg-5">
			<a href="main.do"><img src="css/images/logo.png" width="300"
				height="80"> </a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>


			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto my-2 my-lg-0">
					<c:if test="${empty uvo}">
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="popUp()"> <img src="css/images//d.png" width="20"
								height="20">now
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="popUp()">my box</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="popUp()">accuse</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="popUp()">manual</a></li>
						<li class="nav-item"><a class="nav-link" href="#" id="login"
							onclick="login()">log-in</a></li>
					</c:if>
					<c:if test="${!empty uvo}">
						<li class="nav-item"><a class="nav-link" href="main.do">
								<img src="css/images/d.png" width="20" height="20">now
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="cloud()">my box</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="boardList()">accuse</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="manual()">manual</a></li>
						<li class="nav-item"><a class="nav-link" href="main.do"
							id="logout" onclick="logout()">log-out</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>



	<!-- 메인페이지 -->
	<!-- Masthead-->

	<div class="container">

		<div id="grid">

			<!-- 상단라인선 -->
			<div class="progress">
				<div class="progress-bar" role="progressbar"></div>
			</div>


			<!-- 센터버튼 -->
			<div class="bs-component" id="now">
				<button type="button" class="btn btn-primary">
					<img src="css/images/a.png" width="30" height="30"> REC
				</button>

				<button type="button" class="btn btn-primary">
					<img src="css/images/b.png" width="30" height="30"> CAPTURE
				</button>

				<button type="button" class="btn btn-primary">
					<img src="css/images/c.png" width="30" height="30"> MAP
				</button>
			</div>

			<!-- 동영상이미지,로그인,회원가입 -->
			<c:if test="${empty uvo}">
				<img onclick="login()" src="original/no_login.png" width="900"
					height="600" style="margin-left: 7%">

				<div class="loginForm" style="display: none">
					<form action="${cpath}/login.do" id="loginForm" method="post">
						<div class="login">
							<div class="close" onclick="popClose()">X</div>
							<h2>Log-in</h2>
							<div class="login_id">
								<h4>ID</h4>
								<input type="text" name="id" placeholder="id를 입력해주세요">
							</div>
							<div class="login_pw">
								<h4>Password</h4>
								<input type="password" name="pw" placeholder="비밀번호를 입력해주세요">
							</div>

							<div class="checkbox">
								<input type="checkbox"> Remember Me?
							</div>
							<div class="login_sns">
								<li><a href="https://www.instagram.com/"><i class="fab fa-instagram"></i></a></li>
								<li><a href="https://www.facebook.com/"><i class="fab fa-facebook-f"></i></a></li>
								<li><a href="https://twitter.com/"><i class="fab fa-twitter"></i></a></li>
							</div>
							<div class="submit">
								<input class="" type="submit" value="로그인">
								<button type="button" onclick="join()">회원가입</button>
							</div>
						</div>

					</form>
					<div>
						<form class="joinForm" action="${cpath}/join.do" method="post"
							style="display: none">
							<div class="close" onclick="popClose()">X</div>
							<div class="sign-up">
								<h2>Sign-up</h2>
								<h4 class="col-md-3">아이디 :</h4>
								<input class="col-md-8" type="text" name="id" id="id">
								<button class="col-md-1" type="button"
									style="margin:0%; left:3.5%; top:14px; width:110px" onclick="idCheck()">중복
									확인</button>
								<h4 class="col-md-3">비밀번호 :</h4>
								<input class="col-md-8" type="password" name="pw" id="pw">
								<h4 class="col-md-3">비밀번호 확인:</h4>
								<input class="col-md-8" type="password" name="pwcheck"
									id="pwcheck">

								<h4 class="col-md-3">블랙박스번호 :</h4>
								<input class="col-md-8" type="text" name="bb_num">

								<h4 class="col-md-3">이름 :</h4>
								<input class="col-md-8" type="text" name="name">

								<h4 class="col-md-3">주민번호 :</h4>
								<input class="col-md-8" type="text" name="rrn">

								<h4 class="col-md-3">휴대폰번호 :</h4>
								<input class="col-md-8" type="text" name="phone">

								<h4 class="col-md-3">주소 :</h4>
								<input class="col-md-8" type="text" name="address">
							</div>

							<input class="join-f-btn" style="margin: 5%" type="submit"
								value="가입 완료">

						</form>
					</div>


				</div>
			</c:if>

			<!-- 로그인완료! -->
			<div id="main">
				<c:if test="${!empty uvo}">
					<video id="now" width="900" height="600" style="margin-left: 7%"
						autoplay="autoplay" src="original/202204291828(1280).mp4" muted
						type="video/mp4">
					</video>
				</c:if>
			</div>
			<div id="mybox">
				<div class="col-md-3" id="cloud" onclick="cloud()"></div>
				<c:if test="${!empty uvo}">
					<video id="video" width="900" height="600" controls="controls" muted>
					</video>
				</c:if>
			</div>


			<div id="accuse" style="display: none">
				<div id="list"></div>

				<!-- 제보하기 파일 올리기 부분 -->
				<div class="popup-wrap1" id="popup1">
					<div id="file">

						<!--  실질적 파일 몸통 -->
						<div class="file-head">
							<span class="head-title">제보하기</span>
						</div>
						<div class="file-body">
							<div class="file-content">
								<input type="file" name="vr_title" id="vr_title"> <a
									href="#" onclick="fileclear()">X</a>
							</div>
						</div>

						<div class="file-foot">
							<button onclick="boardList()">CANCEL</button>
							<button class="file-submit" onclick="fileLoad()">SUBMIT</button>
						</div>
					</div>
				</div>

				<div id="content" style="display: none">
					<form id="insert">
						<table class="table1">
							<tr>
								<th>위반사항</th>
								<td id="ill"></td>
							</tr>
							<tr>
								<th>위반시간</th>
								<td id="time"></td>
							</tr>
							<tr>
								<th>위반장소</th>
								<td id="place"></td>
							</tr>
							<tr>
								<th>위반번호</th>
								<td id="plate"></td>
							</tr>
							<tr>
								<th rowspan="4">제보자 인적사항</th>
								<td id="name">${uvo.name}</td>
							</tr>
							<tr>

								<td>${uvo.rrn}</td>
							</tr>
							<tr>

								<td>${uvo.address}</td>
							</tr>
							<tr>

								<td>${uvo.phone}</td>
							</tr>
						</table>
						<div style="text-align: center">
							<button class="content-btn2" style="margin: 2.5%"
								onclick="accuse()">등록</button>
							<button class="content-btn2" style="margin: 2.5%"
								onclick="boardList()">취소</button>
						</div>
					</form>
				</div>
			</div>

			<div id="manual" style="display: none">
				<div class="m">
					<img
						src="http://www.adinews.co.kr/news/photo/200707/img_1355_0.JPG"
						style="float: left; display: flex; justify-content: center; margin-left: 2%; width: 150px; height: 150px;">
					<p class="p-title">1.안전모 미착용</p>
					<p class="p-content">
						도로교통법 제 50조 (특정 운전자의 준수사항)<br> 이륜자동차와 원동기장치자전거의 운전자는 행정안전부령으로
						정하는<br> 인명보호 장구를 착용하고 운행하여야하며 동승자에게도 착용하도록 하여야한다 <br>
						범칙금 2만원
					</p>
				</div>
				<div class="m">
					<img
						src="data:image/jpeg;base64,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"
						style="float: left; display: flex; justify-content: center; margin-left: 2%; width: 150px; height: 150px;">
					<p class="p-title">2. 신호위반</p>
					<p class="p-content">
						도로교통법 제 5조 (신호 또는 지시에 따를 의무)<br> 도로를 통행하는 보행자, 차마 또는 노면전차의
						운전자는<br>교통안전시설이 표시하는 신호 또는 지시를 따라야 한다.<br> 범칙금 4만원
					</p>
				</div>
				<div class="m">
					<img
						src="http://image.imnews.imbc.com/replay/2019/nwtoday/article/__icsFiles/afieldfile/2019/10/18/today_20191018_074050_2_51_Large.jpg"
						style="float: left; display: flex; justify-content: center; margin-left: 2%; width: 150px; height: 150px;">
					<p class="p-title">3. 불법구조변경</p>
					<p class="p-content">
						자동차관리법 제 34조 (자동차의 튜닝)<br> 자동차소유자가 국토교통부령으로 정하는 항목에 대하여<br>튜닝을
						하려는 경우에는 시장·군수·구청장의 승인을 받아야한다<br> 1년 이하의 징역 300만원 이하의 벌금
					</p>
				</div>
				<div class="m">
					<img src="https://s1.dmcdn.net/v/TEPL81XCIr-1hH-Lx/x360"
						style="float: left; display: flex; justify-content: center; margin-left: 2%; width: 150px; height: 150px;">
					<p class="p-title">4. 난폭운전</p>
					<p class="p-content">
						도로교통법 제 46조 3 (난폭운전 금지)<br> 자동차의 운전자는 다음 각 호 중 둘 이상의 행위를 연달아
						하거나, 하나의 행위를 지속 또는 반복하여 다른 사람에게 위협 또는 위해를 가하거나 교통상의 위험을 발생하게 하여서는
						아니된다. 신호 또는 지시위반, 중앙선 침범, 속도의 위반, 횡단,유턴,후진금지위반 안전거리 미확보, 진로변경 금지
						위반 급제동 금지위반 정당한 사유 없는 소음발생 고속도로에서의 앞지르기 방법 위반 1년 이하의 징역 또는 500만원의
						벌금
					</p>
				</div>
			</div>
		</div>
	</div>







	<!-- Footer-->
	<footer class="bg-light py-5">
		<div class="col-md-8">
			<div class="small text-center text-muted" style="margin-top: auto">Copyright &copy; 2022
				- 빅데이터 분석서비스 개발자과정</div>
		</div>
		<div class="col-md-4" style="margin-top: -0.7%">
			<a href="https://minwon.police.go.kr/"> <img
				src="css/images/k1.png" width="100" height="40"
				style="margin-left: 0px"></a> <a
				href="http://onetouch.police.go.kr/"> <img
				src="css/images/s1.png" width="100" height="40"
				style="margin-left: 10px"></a> <a
				href="https://www.kotsa.or.kr/main.do"> <img
				src="css/images/ts1.png" width="100" height="30"
				style="margin-left: 10px"></a>
		</div>
	</footer>


</body>
</html>

