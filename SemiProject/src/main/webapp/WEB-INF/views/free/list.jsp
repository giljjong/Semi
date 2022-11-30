<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		if('${recordPerPage}' != ''){
			$('#recordPerPage').val(${recordPerPage});			
		} else {
			$('#recordPerPage').val(5);
		}
		
		$('#recordPerPage').change(function(){
			location.href = '${contextPath}/free/list?recordPerPage=' + $(this).val();
		});
		
	});
</script>
<style>
	.lnk_remove {
		cursor: pointer;
	}
	.blind {		/* 있지만 보이지 않도록 처리 */
		display: none;
	}
</style>
<style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css');
</style>
<style>
	.freebrd > table th {
		text-align: center;
	}
	.freebrd > table {
		width: 500px;
		height: 50px;	
	}
	
	.btn_reply_write {
		border-radius: 4px;
		background-color: white;
		border: 1px solid tomato;
		color: tomato;
		text-align: center;
		font-size: 6px;
		font-color: tomato;

		transition: all 0.5s;
		cursor: pointer;
		margin: 5px;
	    vertical-align:middle;
	}
	.btn_reply_write:hover { 
		background: tomato; 
		color: white; 
	}
	.btn_reply_write:hover span:after {
	  opacity: 1;
	  right: 0;
	}	
	
	.reply {
		border-radius: 4px;
		background-color: white;
		border: 1px solid tomato;
		color: tomato;
		text-align: center;
		font-size: 6px;
		font-color: tomato;
		transition: all 0.5s;
		cursor: pointer;
		margin: 5px;
	    vertical-align:middle;
	}
	.reply:hover { 
		background: tomato; 
		color: white; 
	}
	.reply:hover span:after {
	  opacity: 1;
	  right: 0;
	}
	
</style>
</head>
<body>

	<div>
	<h3>자유게시판</h3>
		<a href="${contextPath}/free/write">게시글 작성<i class="fa-regular fa-pen-to-square"></i></a> | <a
				href="${contextPath}/free/list">첫페이지로<i class="fa-solid fa-rotate-left"></i></a>	<!-- fa-spin 고민중 -->
	</div>
	
	<hr>
	
	<div>	<!-- 스타일 체크    style="float: left;" -->
		<select id="recordPerPage">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
			<option value="25">25</option>
			<option value="30">30</option>
		</select>
	</div>

	<div class="freebrd">
		<table border="0">		<!-- 디자인 참고 위해 삭제 -->
			<thead>
				<tr>
					<th>NO</th>
					<th>ID</th>
					<th>TITLE</th>
					<th>IP</th>
					<th>DATE</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="free" items="${freeBoardList}" varStatus="vs">
					<c:if test="${free.state == 1}">
						<tr>
							<td><center>${beginNo - vs.index}</center></td>
							<td>${free.id}</td>
							<td>
								<!-- DEPTH에 따른 들여쓰기 -->
								<c:forEach begin="1" end="${free.depth}" step="1">
									&nbsp;&nbsp;&nbsp;&nbsp;
								</c:forEach>
								<!-- 답글은 [RE] 표시 -->
								<c:if test="${free.depth > 0}">
									<span style="color:tomato"><i class="fa-solid fa-reply fa-rotate-180 fa-xs"></span></i>
								</c:if>
								<!-- 제목 -->			
									${free.freeTitle}
									
								
								
								<!-- 답글달기 버튼 -->
								<input type="button" value="reply" class="btn_reply_write">

								<script>
									$('.btn_reply_write').click(function(){
										$('.reply_write_tr').addClass('blind');
										$(this).parent().parent().next().next().removeClass('blind');
									});
								</script>
							</td>
							
							<td><center>${free.ip}</center></td>
							<td><center>${free.createDate}</center></td>							
							<td><center>
								<form method="post" action="${contextPath}/free/remove">	<!-- data속성 : date-(-뒤에는 자유롭게 작성) -->
									<input type="hidden" name="freeBoardNo" value="${free.freeBoardNo}">
									
									
									<a class="lnk_remove" id="lnk_remove${free.freeBoardNo}">
										<i class="fa-sharp fa-solid fa-trash fa-sm"></i>
									</a>
									
								</form></center></td>
								<script>
									$('#lnk_remove${free.freeBoardNo}').click(function(){
										if(confirm('해당 글을 삭제하시겠습니까? 데이터 삭제시 복구가 불가능합니다.')){
											$(this).parent().submit();
										}		
											// $('.frm_remove').submit();
											// alert( $('.frm_remove'). data('aaa') ); 	 /* data()안에는 data속성에서 준 값을 동일하게 입력 */
											//}	
									});
								</script>
							</td>
						</tr>
						
						<tr>
							<!-- 내용 -->
							<td colspan="2"><strong><center>CONTENT</center></strong></td>
							
							<td colspan="3">								
									
									<c:forEach begin="1" end="${free.depth}" step="1">
									&nbsp;&nbsp;&nbsp;&nbsp;
									</c:forEach>
									<!-- 답글은 [RE] 표시 -->
									<c:if test="${free.depth > 0}">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									
									${free.freeContent}
							</td>
							<td>
									
									
								<center>
								<form method="get" action="${contextPath}/free/edit">	<!-- data속성 : date-(-뒤에는 자유롭게 작성) -->
									<input type="hidden" name="freeBoardNo" value="${free.freeBoardNo}">
									
									
									<a class="lnk_edit" id="lnk_edit${free.freeBoardNo}">
										<i class="fa-solid fa-eraser fa-sm"></i>
									</a>
									
								</form>
								</center>
								<script>
									$('#lnk_edit${free.freeBoardNo}').click(function(){
										if(confirm('수정 페이지로 이동합니다.')){
											$(this).parent().submit();
										}		
											// $('.frm_remove').submit();
											// alert( $('.frm_remove'). data('aaa') ); 	 /* data()안에는 data속성에서 준 값을 동일하게 입력 */
											//}	
									});
								</script>
									
									
							</td>								
						</tr>
					
						
						<tr class="reply_write_tr blind">		<!-- class는 공백으로 구분 --><!-- class 처리를 통해 있지만 보이지 않도록 처리 -->
							<td colspan="6">
								<form method="post" action="${contextPath}/free/reply/add">
									<div><input type="text" name="id" placeholder="아이디는 필수입니다." style="font-size:2px;" required></div>
									<div><input type="text" name="freeTitle" placeholder="제목은 필수입니다." style="font-size:2px;" required></div>
									<div><textarea rows="6" cols="22" name="freeContent" placeholder="내용을 입력하세요." style="font-size:2px;" required></textarea></div>
									<div><button class="reply">답글작성</button></div>
									<input type="hidden" name="depth" value="${free.depth}">	<!-- 답글달기와 같은 form안에만 있으면 됨 -->
									<input type="hidden" name="groupNo" value="${free.groupNo}">
									<input type="hidden" name="groupOrder" value="${free.groupOrder}">
								</form>
							</td>
						<tr>
					</c:if>
					<c:if test="${free.state == 0}">
						<tr>
							<td>${beginNo - vs.index}</td>
							<td colspan="6"><center><font size="2" color="gray">삭제된 게시글입니다.</font></center></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6">${paging}</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
</html>