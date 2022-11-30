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

	<!-- 로그인 안된 상태 -->
	<c:if test="${loginUser == null}">
		<a href="${contextPath}/user/login/form">로그인페이지</a><br>
		<a href="free/list">자유게시판 가기</a><br>
		<a href="gallery/list">갤러리게시판 가기</a><br>
		<a href="upload/list">업로드게시판 가기</a><br>
		<a href="admin/menu">관리자 페이지 가기</a><br>
	</c:if>
	
	<!-- 로그인 상태 -->
	<c:if test="${loginUser != null}">
		<div>
			<a href="${contextPath}/user/check/form">${loginUser.name}</a>님 마이페이지
		</div>
		<a href="${contextPath}/user/logout">로그아웃</a><br>
		<a href="free/list">자유게시판 가기</a><br>
		<a href="gallery/list">갤러리게시판 가기</a><br>
		<a href="upload/list">업로드게시판 가기</a><br>
		<a href="admin/menu">관리자 페이지 가기</a><br>
	</c:if>
</body>
</html>