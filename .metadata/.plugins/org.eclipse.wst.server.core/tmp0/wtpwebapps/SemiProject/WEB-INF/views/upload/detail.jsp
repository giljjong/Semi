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
		$('#btn_upload_edit').click(function(){
			$('#frm_upload').attr('action', '${contextPath}/upload/edit');
			$('#frm_upload').submit();
		});
		
		$('#btn_upload_remove').click(function(){
			if(confirm('첨부된 모든 파일이 삭제됩니다. 삭제하시겠습니까?')){
				$('#frm_upload').attr('action', '${contextPath}/upload/remove');
				$('#frm_upload').submit();
			}
		});
		
		$('#btn_upload_list').click(function(){
			location.href='${contextPath}/upload/list';
		});
	})
</script>
</head>
<body>
	<div>
		<h1>업로드 게시글 정보</h1>
		<ul>
			<li>아이디 : ${upload.id}</li>
			<li>제목 : ${upload.uploadTitle}</li>
			<li>내용 : ${upload.uploadContent}</li>
			<li>작성일 : ${upload.createDate}</li>
			<li>수정일 : ${upload.modifyDate}</li>
			<li>아이피 : ${upload.ip}</li>
			<li>조회수 : ${upload.hit}</li>
		</ul>
	</div>
	<div>
		<form id= "frm_upload" method= "post">
			<input type="hidden" name="uploadBoardNo" value= "${upload.uploadBoardNo }">
			<input type="button" value="게시글 편집" id="btn_upload_edit" >
			<input type="button" value="게시글 삭제" id="btn_upload_remove">
			<input type="button" value="게시글 목록" id="btn_upload_list">
		</form>
	</div>
	
	<hr>
	
	<div>
		<h3>첨부 다운로드</h3>
		<c:forEach items= "${attachList}" var="attach">
			<div>
				<a href="${contextPath}/upload/download?attachNo=${attach.attachNo}">${attach.origin}</a>
			</div>
		</c:forEach>
		<div>
			<a href="${contextPath}/upload/downloadAll?uploadBoardNo=${upload.uploadBoardNo}">모두 다운로드</a>
		</div>
	</div>
</body>
</html>