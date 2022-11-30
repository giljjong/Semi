<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>

<script>
$(function(){
	fn_uploadList();
	fn_allList();
	fn_searchList();
	fn_write();
})

	
		function fn_uploadList(){	
			$.ajax({	
				type : 'get',
				url : '${contextPath}/upload/ulist',
				dataType: 'json',
				data : 'pageNo=' + ${pageNo} ,
				success: function(resData){
					$('#paging').empty();
					$('#result').empty();
					$.each(resData.uploadList, function( i , uploadList){
						$('<tr>')
						.append( $('<td>').text(uploadList.uploadBoardNo) )
						.append( $('<td>').append( $('<a>').text(uploadList.uploadTitle).attr('href' ,'${contextPath}/upload/incrase/hit?uploadBoardNo=' + uploadList.uploadBoardNo ) ) )
						.append( $('<td>').text(uploadList.createDate) )
						.append( $('<td>').text(uploadList.attachCnt) )
						.append( $('<td>').text(uploadList.ip) )
						.append( $('<td>').text(uploadList.hit) )
						.appendTo('#result');	
					
					})	
					
					var str = '' ;	
			 	    if(resData.beginPage != 1){
						str += '<a href=${contextPath}/upload/list?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
					}  
				 	for(let p = resData.beginPage; p <= resData.endPage; p++){
					 	if(p == resData.page){
					 		str += '<strong>' + p + '</strong>' ;
						}  
						else {
							str += '<a href=${contextPath}/upload/list?pageNo=' + p +'>'+ p + '</a>';
						} 
					} 
					if(resData.endPage != resData.totalPage) {
						str += '<a href=${contextPath}/upload/list?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
						console.log(str);
					}     
					 
					   
					 $('#paging').append(str);   	
				},
				error: function(jqXHR){
					alert('리스트 불러오기가 실패했습니다.');
				}
		})
	}
	
	function fn_searchList(){
		$('#btn_search').click(function (){
			$.ajax({
				type : 'get',
				url : '${contextPath}/upload/search',
				data : 'pageNo=' + ${pageNo} + '&column=' + $('#column').val() + '&query=' + $('#query').val(),
				dataType : 'json',
				success : function (resData){
					console.log(resData)
					$('#paging').empty();
					$('#result').empty();
					$.each(resData.uploadList, function( i , uploadList){
						$('<tr>')
						.append( $('<td>').text(uploadList.uploadBoardNo) )
						.append( $('<td>').append( $('<a>').text(uploadList.uploadTitle).attr('href' ,'${contextPath}/upload/incrase/hit?uploadBoardNo=' + uploadList.uploadBoardNo ) ) )
						.append( $('<td>').text(uploadList.createDate) )
						.append( $('<td>').text(uploadList.attachCnt) )
						.append( $('<td>').text(uploadList.ip) )
						.append( $('<td>').text(uploadList.hit) )
						.appendTo('#result');	
					
					})	
					
					var str = '' ;	
			 	    if(resData.beginPage != 1){
						str += '<a href=${contextPath}/upload/list?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
					}  
				 	for(let p = resData.beginPage; p <= resData.endPage; p++){
					 	if(p == resData.page){
					 		str += '<strong>' + p + '</strong>' ;
						}  
						else {
							 /* str += '<a href=${contextPath}/upload/list?pageNo=' + p + '>'+ p + '</a>'; */
							 str += '<a href=${contextPath}/upload/search?pageNo=' + p + '&column=' + resData.column + '&query=' + resData.query  + '>'+ p + '</a>'; 
						} 
					} 
					if(resData.endPage != resData.totalPage) {
						str += '<a href=${contextPath}/upload/list?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
						console.log(str);
					}     
					 
					   
					 $('#paging').append(str);   	
				},
				error: function(jqXHR){
					alert('리스트 불러오기가 실패했습니다.');
				
				} 
			})
		})		
	}
	
	function fn_allList(){
		$('#btn_all').click(function (){
			fn_uploadList();	
		})
	}
	
	function fn_write(){
		$('#btn_write').click(function (){

			if(${loginUser != null}){
				$('#frm_write').attr('action', '${contextPath}/upload/write');
				$('#frm_write').submit();				
			} else {
				alert('로그인을 해야지 작성이 가능합니다.');
				event.preventDefault();
				return;
			}
		})
	}
	
			
			
		
</script>
</head>
<body>
	${loginUser.id}
	<div>
		<div>
			<form id="frm_write" >
				<input type="button" value="작성" id="btn_write" >
			</form>
			
			<a href= "${contextPath}/upload/write">작성</a>
		</div>
		<div>
			<form id="frm_search" action="${contextPath}/upload/search">
				<select id="column" name="column">
					<option value="">::선택::<option>
					<option value="UPLOAD_TITLE">제목</option>
					<option value="ID">아이디</option>
				</select>
				<span id="area1">
					<input type="text" id="query" name="query">
				</span>
				<span>
					<input type="button" value="검색" id="btn_search">
					<input type="button" value="전체사원조회" id="btn_all"> 
				</span>
			</form>
		</div>
		<hr>
		
		<div>
			<table border="1">
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성일</td>
						<td>첨부개수</td>
						<td>아이피</td>
						<td>조회수</td>
					</tr>
				</thead>
				<tbody id ="result">
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6" id="paging" >
						
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		
	</div>
	
</body>
</html>