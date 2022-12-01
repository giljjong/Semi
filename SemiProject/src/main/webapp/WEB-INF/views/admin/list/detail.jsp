<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<% 	Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
	int p = Integer.parseInt(opt.orElse("1")); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/resources/css/jquery-ui.min.css">
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${contextPath}/resources/css/admin.css">
<script>

	$(function(){
		
		var id;
		
		fn_autoList();
		fn_searchList();
		fn_deleteSelectBoard();
		fn_inputShow();
		
		$('.start_datepicker').datepicker({
			dateFormat: 'yymmdd',  // 실제로는 yyyymmdd로 적용됨
			changeMonth: true,
	      	changeYear: true
		});
		
		$('.end_datepicker').datepicker({
			dateFormat: 'yymmdd',  // 실제로는 yyyymmdd로 적용됨
			changeMonth: true,
	      	changeYear: true
		});
		
	});
	
	function fn_autoList(){
		$('#boardList, #span_cnt').empty();
		
		$.ajax({
			type : 'get',
			url : '${contextPath}/admin/list/allBoards/id',
			data : 'id=${id}&type=${type}&page=' + <%=p%>,
			dataType : 'json',
			success : function(resData) {
				
				$('<span>').html(resData.totalRecord +  '개')
				.appendTo('#span_cnt');
				
				$('.pageWrap').html(resData.paging);
				
				if(resData.status == 200) {
					$('#board_type').show();

					$.each(resData.boards, function(i, board){

						var tr = $('<tr>');
						
						tr
						.append($('<td class="center">').html('<input type="checkbox" class="check_board" name="id" value="'+ board.id +'">'))
						.append($('<td class="center">').html((resData.totalRecord - board.rn + 1)));
						
						if(board.freeBoardNo != 0) {
							tr
							.append($('<td>').text(board.freeBoardNo).addClass('blind'))
							.append($('<td class="center">').html('<input type="hidden" name="board" value="FREE_BOARD">' + '자유게시판'))
						} else if(board.galleryBoardNo != 0){
							tr
							.append($('<td >').text(board.galleryBoardNo).addClass('blind'))
							.append($('<td class="center">').html('<input type="hidden" name="board" value="GALLERY_BOARD">' + '갤러리게시판'))
						} else if(board.uploadBoardNo != 0){
							tr
							.append($('<td>').text(board.uploadBoardNo).addClass('blind'))
							.append($('<td class="center">').html('<input type="hidden" name="board" value="UPLOAD_BOARD">' + '업로드게시판'))
						}
						
						tr
						.append($('<td class="center title">').html(board.title))
						.append($('<td class="center">').html(board.id))
						.append($('<td class="center">').html(board.ip))
						.append($('<td class="center">').html(board.createDate))
						.append($('<td class="center">').html(board.hit))
						.appendTo($('#boardList'));
						
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
			$('#boardList, #span_cnt').empty();
			
			if($('#query').val() == '' && $('#first').val() == '' && $('#last').val() == '' && $('#start').val() == '' && $('#stop').val() == '') {
				$('#column').val('');
			};
			
			$.ajax({
				type : 'get',
				url : '${contextPath}/admin/search/boards/id',
				data : $('#frm_search').serialize(),
				dataType : 'json',
				success : function(resData) {
					
					$('#board_type').hide();
					
					$('<span>').html('총 게시글 : ' + resData.totalRecord + '개')
					.appendTo('#span_cnt');
					
					$('.pageWrap').html(resData.paging);
					
					if(resData.status == 200) {
						
						$.each(resData.boards, function(i, board){
							var tr = $('<tr>');
							
							tr
							.append($('<td class="center">').html('<input type="checkbox" class="check_board" name="id" value="'+ board.id +'">'))
							.append($('<td class="center">').html((resData.totalRecord - board.rn + 1)));
							
							if(board.freeBoardNo != 0) {
								$('#board_type').show();
								tr
								.append($('<td>').text(board.freeBoardNo).addClass('blind'))
								.append($('<td class="center">').html('<input type="hidden" name="board" value="FREE_BOARD">' + '자유게시판'))
							} else if(board.galleryBoardNo != 0){
								$('#board_type').show();
								tr
								.append($('<td>').text(board.galleryBoardNo).addClass('blind'))
								.append($('<td class="center">').html('<input type="hidden" name="board" value="GALLERY_BOARD">' + '갤러리게시판'))
							} else if(board.uploadBoardNo != 0){
								$('#board_type').show();
								tr
								.append($('<td class="center">').text(board.uploadBoardNo).addClass('blind'))
								.append($('<td class="center">').html('<input type="hidden" name="board" value="UPLOAD_BOARD">' + '업로드게시판'))
							}
							
							tr
							.append($('<td class="center title">').html(board.title))
							.append($('<td class="center">').html(board.id))
							.append($('<td class="center">').html(board.ip))
							.append($('<td class="center">').html(board.createDate))
							.append($('<td class="center">').html(board.hit))
							.appendTo($('#boardList'));
						});
					} else {
						alert(resData.message);
					}
				}
			});
		});
	}

	function fn_deleteSelectBoard(){
			
		var id = new Array();
		var boardNo = new Array();
		var board = new Array();
		$(document).on('click', '.check_board', function(event){
			if($(this).is(":checked")) {
				id.push($(this).val());
				boardNo.push($(this).parent().next().next().text());
				board.push($(this).parent().next().next().next().children().first().val());
			} else if($(this).is(":checked") == false){
				for(var i = 0; i < id.length; i++){
					if($(this).val() == id[i]){
						id.splice(i, 1);
						boardNo.splice(i, 1);
						board.splice(i, 1);
					}
				}
			}
		});
		
		var objParams = {
                "id"      : id,
                "boardNo" : boardNo,
                "board"   : board
            };
		
		$('.delete_icon').click(function() {
			if(confirm('체크한 항목을 삭제하시겠습니까?')){
				$.ajax({
					type : 'post',
					url : '${contextPath}/admin/board/remove',
					data : objParams,
					dataType : 'json',
					success : function(resData){
						alert(resData.message);
						fn_autoList();
						id = [];
						boardNo = [];
						board = [];
					}
				})
			}
		})
	}

	function fn_inputShow(){
		
		$('#area2').hide();
		$('#area3').hide();
		
		$('#area2').css('display', 'none');
	
		$('#column').change(function(){
			$('.input').val('');
			let combo = $(this);
			if(combo.val() == 'CREATE_DATE'){
				$('#area1').hide();
				$('#area2').hide();
				$('#area3').show();
			} else {
				$('#area1').show();
				$('#area2').hide();
				$('#area3').hide();
			}
		});
	};
</script>
</head>
<header>
	<div class="head_bar">
		<div id="logo_div">
			<a href="../index.jsp"><img id="logo" src="https://www.gdu.co.kr/images/main/logo.png"></a>
		</div>
		<ul class="gnb_barAll">
			<li><a href="${contextPath}/admin/menu"  class="gnb_bar">전체메뉴</a></li>
			<li><span class="snb_bar"></span><a href="${contextPath}/admin/list/board" class="gnb_bar">게시판 관리</a></li>
			<li><span class="snb_bar"></span><a href="${contextPath}/admin/list/user" class="gnb_bar">회원관리</a></li>
			<li><span class="snb_bar"></span><a href="#"  class="gnb_bar">게시판 가기</a></li>
		</ul>
	</div>
</header>
<body>
	<div class="allForm">
		<div class="user_detail_box">
			<div class="profile_box">
				<div class="pro_img">
					<img id="profile" src="${contextPath}/resources/images/img_profile.png"><br><span class="profile_text">${state}</span>
				</div>
				<div class="profile_name">
					${id}님	
				</div>
			</div>
			<p class="total_span">작성한 게시글 : <span id="span_cnt"></span></p>
		</div>
		<div class="detail_queryForm">
			<form id="frm_search">
				<select id="board" name="board" class="select">
					<option value="">전체</option>
					<option value="FREE_BOARD">자유게시판</option>
					<option value="GALLERY_BOARD">사진게시판</option>
					<option value="UPLOAD_BOARD">업로드게시판</option>
				</select>
				<select id="column" name="column" class="select">
					<option value="">:::선택:::</option>
					<option value="TITLE">제목</option>
					<option value="CONTENT">내용</option>
					<option value="TITLE_CONTENT">제목 + 내용</option>
					<option value="CREATE_DATE">작성일자</option>
				</select>
				<input type="hidden" name="page" value="<%=p%>">
				<span id="area1">
					<input type="text" id="query" name="query" class="input searchBox">
				</span>
				<span id="area2">
					<input type="text" id="first" name="first" class="input searchBox">
					~
					<input type="text" id="last" name="last" class="input searchBox">
				</span>
				<span id="area3">
					<input type="text" id="start" name="start" class="start_datepicker input searchBox">
					~
					<input type="text" id="stop" name="stop" class="end_datepicker input v">
				</span>
				<span>
					<input type="button" value="검색" id="btn_search" class="btn_primary">
					<input type="button" value="전체회원조회" id="btn_all" class="btn_primary">
					<button class="delete_icon"><i class="fa-solid fa-trash-can"></i></button>
				</span>
				<input type="hidden" name="id" value="${id}">
				<input type="hidden" name="type" value="${type}">
			</form>
		</div>
			<table class="tbl_board">
				<thead class="head_font thead_board">
					<tr>
						<td class="choice">선택</td>
						<td class="no">순번</td>
						<td id="board_type">종류</td>
						<td class="title_tr">제목</td>
						<td class="id">아이디</td>
						<td class="ip">IP</td>
						<td class="date">작성일자</td>
						<td class="hit">조회수</td>
					</tr>
				</thead>
				
				<tbody id="boardList">
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