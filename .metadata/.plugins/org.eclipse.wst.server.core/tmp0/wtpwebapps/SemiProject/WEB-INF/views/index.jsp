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
	<h1>로그인</h1>
	<div>
		<form action="${contextPath}">
			<input type="text" id="id" name="id"><br>
			<input type="text" id="pw" name="pw">
		</form>
	</div>
	
	<a href="free/list">자유게시판 가기</a>
	<a href="gallery/list">갤러리게시판 가기</a>
	<a href="upload/list">업로드게시판 가기</a>
	<a href="admin/list">관리자 페이지 가기</a>
</body>
</html>