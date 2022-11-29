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
	
	
	$(document).ready(function(){			
			$.ajax({
				
				type : 'get',
				url : '${contextPath}/upload/ulist',
				dataType: 'json',
				data : 'pageNo=' + ${pageNo} ,
				success: function(resData){
					console.log(resData);
					$('#paging').empty();
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
					alert('등록이 실패했습니다.');
				}
		})
		
		
	})
</script>
</head>
<body>
	<div>
		<div>
			<a href= "${contextPath}/upload/write">작성</a>
		</div>
		<div>
			<form id="frm_search" action="${contextPath}/upload/search">
				제목  
				<span id="titlesearch">
					<input type="text" id="title" name="title">
				</span>
				<span>
					<input type="submit" value="검색">
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