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
			data : 'pageNo=' ,
			success: function(resData){
				console.log(resData);
				$.each(resData.uploadList, function( i , uploadList){
					$('<tr>')
					.append( $('<td>').text(uploadList.uploadBoardNo) )
					.append( $('<td>').append( $('<a>').text(uploadList.uploadTitle).attr('href' ,'${contextPath}/upload/incrase/hit?uploadBoardNo=' + uploadList.uploadBoardNo ) ) )
					.append( $('<td>').text(uploadList.createDate) )
					.append( $('<td>').text(uploadList.attachCnt) )
					.append( $('<td>').text(uploadList.ip) )
					.append( $('<td>').text(uploadList.hit) )
					.appendTo('#result');	
					/* <a href="${contextPath}/upload/detail?uploadNo=${upload.uploadNo}">${upload.title}</a> */
							/* uploadList.uploadTitle */
							/* .attr('href', '${contextPath}/upload/detail?uploadNo=') */
				})
				
				var str = '' ;
				
				console.log(resData.beginPage);
				console.log(resData.endPage);
				console.log(resData.totalPage); 
				console.log(resData.page); 
				
			
			/* 	var str2 = 2;
				str2.appendTo('#paging'); */
				 /* str = $('<a>').text('2').attr('href', '${contextPath}?page=' + '2' );
				console.log(str);
				
				str.appendTo('#paging');   */
				
		 	    if(resData.beginPage != 1){
					str.append( $('<a>').text('◀').attr('href', '${contextPath}?page=' + resData.beginpage -1 ) );
					
				}
				
			 	for(let p = resData.beginPage; p <= resData.endPage; p++){
				 	if(p == resData.page){
				 		$(str).append(p); 
						console.log(p);
					}  
					else {
						$(str).append( $('<a>').text(p).attr('href', '${contextPath}?page=' + p ) );
						console.log(str);
					} 
				} 
				
				if(resData.endPage != resData.totalPage) {
					str.append( $('<a>').text('▶').attr('href', '${contextPath}?page=' + resData.endPage+1 ) ) ;
					console.log(str);
				}    
				console.log(str);
				/*  let p = resData.beginPage
				 var str2 = '';
				 str2 = $('<a>').text('◀').attr('href', '${contextPath}?page=' + resData.beginpage -1 ) ;
				 str2.append( $('<a>').text('▶').attr('href', '${contextPath}?page=' + resData.endPage+1 ) ); 
				 str2.append( p  ); 
				 str2.append( $('<a>').text(p).attr('href', '${contextPath}?page=' + p ) );
				 console.log(str2);   */
				 $(str).appendTo('#paging');   
				
				
				
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