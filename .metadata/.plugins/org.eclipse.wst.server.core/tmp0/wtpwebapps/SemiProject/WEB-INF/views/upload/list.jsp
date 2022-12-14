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
				<tbody>
					<c:forEach items="${uploadList}" var="upload">
						<tr>
							<td>${upload.uploadBoardNo}</td>
							<td>${upload.uploadtitle}</td>
							<td>${upload.createDate}</td>
							<td>${upload.attachCnt}</td>
							<td>${upload.ip}</td>
							<td>${upload.hit}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
</body>
</html>