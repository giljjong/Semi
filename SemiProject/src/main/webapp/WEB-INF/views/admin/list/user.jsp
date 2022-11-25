<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(document).ready(function(){
		fn_autoList();
		fn_searchList();
		fn_showHide();
	});

	function fn_autoList(){
		$('#userList, #span_cnt').empty();
		$.ajax({
			type : 'get',
			url : '${contextPath}/admin/list/allUsers',
			dataType : 'json',
			success : function(resData) {
				
				$('<span>').html('총 인원 수 : ' + resData.totalRecord)
				.append($('<span>').html('휴면 회원 : ' + resData.sleepUserCnt))
				.appendTo('#span_cnt');
				
				$('.pageWrap').html(resData.paging);
				
				if(resData.status == 200) {

					$.each(resData.users, function(i, user){

						$('<tr>')
						.append($('<td>').html(user.userDTO.userNo))
						.append($('<td>').html(user.userDTO.id))
						.append(user.sleepUserDTO.sleepDate == null ? $('<td>').html('정상회원') : $('<td>').html('휴면회원'))
						.append($('<td>').html(user.userDTO.point))
						.append(user.userDTO.snsType == null ? $('<td>').html('자체 회원') : $('<td>').html('Naver 가입'))
						.append($('<td>').html(user.userDTO.joinDate))
						.append($('<td>').html(user.userDTO.accessLogDTO.lastLoginDate))
						.append(user.sleepUserDTO.sleepDate == null ? $('<td>').html('') : $('<td>').html(user.sleepUserDTO.sleepDate))
						.append($('<td>').html('<a href="${contextPath}/admin/user/retire"><i class="fa-solid fa-trash-can"></i></a>'))
						.appendTo($('#userList'));
						
					});
				} else {
					alert(resData.message);
				}
			}
		});
	};
	
	function fn_searchList(){
		$('#btn_all').click(function(){
			fn_autoList();
		});
		
		$('#btn_search').click(function(){
			
			$('#userList, #span_cnt').empty();
			
			$.ajax({
				type : 'get',
				url : '${contextPath}/admin/list/searchUsers',
				data : $('#frm_search').serialize(),
				dataType : 'json',
				success : function(resData) {
					
					$('<span>').html('총 인원 수 : ' + resData.totalRecord)
					.appendTo('#span_cnt');
					
					$('.pageWrap').html(resData.paging);
					
					if(resData.status == 200) {

						$.each(resData.users, function(i, user){

							$('<tr>')
							.append($('<td>').html(user.userDTO.userNo))
							.append($('<td>').html(user.userDTO.id))
							.append(user.sleepUserDTO.sleepDate == null ? $('<td>').html('정상회원') : $('<td>').html('휴면회원'))
							.append($('<td>').html(user.userDTO.point))
							.append(user.userDTO.snsType == null ? $('<td>').html('자체 회원') : $('<td>').html('Naver 가입'))
							.append($('<td>').html(user.userDTO.joinDate))
							.append($('<td>').html(user.userDTO.accessLogDTO.lastLoginDate))
							.append(user.sleepUserDTO.sleepDate == null ? $('<td>').html('') : $('<td>').html(user.sleepUserDTO.sleepDate))
							.append($('<td>').html('<a href="${contextPath}/admin/user/retire"><i class="fa-solid fa-trash-can"></i></a>'))
							.appendTo($('#userList'));
							
						});
					} else {
						alert(resData.message);
					}
				}
			});
		});
		
	}
	
	function fn_showHide(){
		$('#area2').css('display', 'none');
			
			$('#column').change(function(){
				let combo = $(this);
				if(combo.val() == 'ID'){
					$('#area1').show();
					$('#area2').hide();
				} else {
					$('#area1').hide();
					$('#area2').show();
				}
			});
	}
</script>
</head>
<body>
	<div>
		<a href="${contextPath}/admin/list/free">자유게시판 관리</a>
		<a href="${contextPath}/admin/list/gallery">갤러리게시판 관리</a>
		<a href="${contextPath}/admin/list/upload">업로드게시판 관리</a>
	</div>
	<div>
		<form id="frm_search">
			<select id="state" name="state">
				<option value="">:::선택:::</option>
				<option value="active">정상회원</option>
				<option value="sleep">휴면회원</option>
			</select>
			<select id="column" name="column">
				<option value="">:::선택:::</option>
				<option value="ID">아이디</option>
				<option value="CREATE_DATE">가입일</option>	
				<option value="SLEEP_DATE">휴면일자</option>
				<option value="POINT">포인트</option>
			</select>
			<span id="area1">
				<input type="text" id="query" name="query">
			</span>
			<span id="area2">
				<input type="text" id="start" name="start">
				~
				<input type="text" id="stop" name="stop">
			</span>
			<span>
				<input type="button" value="검색" id="btn_search">
				<input type="button" value="전체회원조회" id="btn_all">
			</span>
		</form>
	</div>
	<div>
		<div id="span_cnt">
		</div>
		<table border="1">
			<thead>
				<tr>
					<td>순번</td>
					<td>아이디</td>
					<td>상태</td>
					<td>포인트</td>
					<td>가입종류</td>
					<td>가입일</td>
					<td>마지막접속일</td>
					<td id="sleepData">휴면날짜</td>
					<td>강제탈퇴</td>
				</tr>
			</thead>
			<tbody id="userList">
		
			</tbody>
		</table>
		<div class="paginate">
			<div class="pageWrap">
				${paging}
			</div>
		</div>
	</div>
</body>
</html>