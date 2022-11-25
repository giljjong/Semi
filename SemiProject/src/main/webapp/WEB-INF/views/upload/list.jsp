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
			url : '${contextPath}/upload/jlist',
			dataType: 'json',
			success: function(resData){
				$.each(resData, function( i , uploadList){
					$('<tr>')
					.append( $('<td>').text(uploadList.uploadBoardNo) )
					.append( $('<td>').html('<a href="${contextPath}/upload/detail?uploadNo=${upload.uploadNo}">' + uploadList.uploadTitle + '</a>'))
					.append( $('<td>').text(uploadList.createDate) )
					.append( $('<td>').text(uploadList.attachCnt) )
					.append( $('<td>').text(uploadList.ip) )
					.append( $('<td>').text(uploadList.hit) )
					.appendTo('#result');	
					/* <a href="${contextPath}/upload/detail?uploadNo=${upload.uploadNo}">${upload.title}</a> */
				})
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
			</table>
		</div>
		
	</div>
	
</body>
</html>