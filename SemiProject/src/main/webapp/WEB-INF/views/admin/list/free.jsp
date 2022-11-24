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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<div>
		<a href="${contextPath}/admin/list/user">회원 리스트</a>
		<a href="${contextPath}/admin/list/free">자유게시판 관리</a>
		<a href="${contextPath}/admin/list/gallery">갤러리게시판 관리</a>
		<a href="${contextPath}/admin/list/upload">업로드게시판 관리</a>
	</div>
	<div>
		<span>휴면 회원 수 : ${totalRecord}</span>
		<table border="1">
			<thead>
				<tr>
					<td>순번</td>
					<td>아이디</td>
					<td>상태</td>
					<td>포인트</td>
					<td>가입종류</td>
					<td>가입일</td>
					<td>휴면일</td>
					<td>강제탈퇴</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${sleepUsers}" var="sleepU">
					<tr>
						<td>${sleepU.userNo}</td>
						<td>${sleepU.id}</td>
						<td>휴면회원</td>
						<td>${sleepU.point}</td>
						<td>${sleepU.snsType}</td>
						<td>${sleepU.joinDate}</td>
						<td>${sleepU.sleepDate}</td>
						<td><a href="${contextPath}/admin/user/retire"><i class="fa-solid fa-trash-can"></i></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="paginate">
			<div class="pageWrap">
				${paging}
			</div>
		</div>
	</div>
</body>
</html>