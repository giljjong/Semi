<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>

<style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css');
</style>

</head>
<body>

	<div>
		<h3>게시글 작성&nbsp;<i class="fa-regular fa-pen-to-square"></i></h3>
		<form id="frm_free" method="post" action="${contextPath}/free/add">
			<div>
				<label for="id"><strong>ID</strong></label>
				<input type="text" name="id" placeholder="회원만 글쓰기가 가능합니다." size=24 style="font-size:2px;" required>
			</div>
			<div>
				<label for="freetitle"><strong>TITLE</strong></label>
				<input type="text" name="freeTitle" placeholder="제목은 필수입니다." size=17 style="font-size:2px;" required>
			</div>
			<div>
				<label for="freecontent"><strong>CONTENT</strong></label>
			</div>
			<div>
				<textarea rows="8" cols="30" name="freeContent" placeholder="내용을 입력하세요." style="font-size:2px;" required>${free.freeContent}</textarea>
			</div>
			<div>
				<button>작성완료</button>
				<input type="reset" value="입력초기화">
				<input type="button" value="게시판으로가기" onclick="location.href='${contextPath}/free/list'">
			</div>
		</form>
	</div>

</body>
</html>