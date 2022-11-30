<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="블로그목록" name="title" />
</jsp:include>

<div>
	
	<h1>게시글 목록(전체 ${totalRecord}개)</h1>
	
	<div>
		<input type="button" value="게시글 작성하기" onclick="location.href='${contextPath}/gallery/write'">
	</div>
	
	<div>
		<table border="1">
			<thead>
				<tr>
					<td>글번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
					<td>좋아요</td>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${galleryBoardList}" var="galleryBoard" varStatus="vs">
					<tr>
						<td>${beginNo - vs.index}</td>	
						<td><a href="${contextPath}/gallery/increse/hit?galleryBoardNo=${galleryBoard.galleryBoardNo}">${galleryBoard.galleryTitle}</a></td>
						<td>${galleryBoard.id}</td>
						<td>${galleryBoard.createDate}</td>
						<td>${galleryBoard.hit}</td>
						
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
	
	</div>
</div>

</body>
</html>	
