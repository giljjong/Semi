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
<style>
	.blind {
		display: none;
	}
</style>

<script>
	$(function(){
		fn_upload_list();
		fn_upload_edit();
		fn_swtichDownloadList();
		fn_editList();
		fn_uploadRemove();
	})
	
	function fn_editList(){
		$.ajax({
			type : 'GET',
			url : '${contextPath}/upload/detail/ulist?uploadBoardNo=${uploadBoardNo}' ,
			dataType : 'json',
			success : function(resData){
				$('<ul>')
				 .append( $('<li>').text('아이디 : ' + resData.upload.id) )
				 .append( $('<li>').text('제목 : ' + resData.upload.uploadTitle) )
				 .append( $('<li>').text('내용 : ' + resData.upload.uploadContent) )
				 .append( $('<li>').text('작성일 : ' + resData.upload.createDate) )
				 .append( $('<li>').text('수정일 : ' + resData.upload.modifyDate) )
				 .append( $('<li>').text('아이피 : ' + resData.upload.ip) )
				 .append( $('<li>').text('조회수 : ' + resData.upload.hit) ) 
				 .appendTo('#uploadDetail'); 
				
				 $.each(resData.attachList, function(i, attach){
					 $('<ul>')
					 .append( $('<li>').append( $('<a>').text(attach.origin).attr('href', '${contextPath}/upload/download?attachNo=' + attach.attachNo)   ) )
					 .appendTo('#attachList');
				 })
				 
				if(resData.upload.id == "admin"){
					 $('<a>')
					 .text('모두 다운로드').attr('href', '${contextPath}/upload/downloadAll?uploadBoardNo=' + resData.upload.uploadBoardNo)
					 .appendTo('#allDownload'); 					
				}
				  
			},
			error : function(jqXHR){
				alert('상세보기 실패');
			}
			
		}) //리스트 ajax	
	}
	
	function fn_uploadRemove(){
		$('#btn_upload_remove').click(function(){
			if(confirm('첨부된 모든 파일이 삭제됩니다. 삭제하시겠습니까?')){
				$.ajax({
					type : 'POST',
					url : '${contextPath}/upload/remove',
					data : 'uploadBoardNo=' + ${uploadBoardNo} ,
					success : function (resData){
						alert('삭제가 성공했습니다.');
						location.href="${contextPath}/upload/list";
					}, 
					error : function (jqXHR){
						alert('삭제가 실패했습니다.');
						history.back();
					}
				})
			}
	   	}); // 삭제 
	}
	function fn_swtichDownloadList(){
		$('#btn_download_list').click(function(){
				$('#download_area').toggleClass('blind');				
		});
	}
	
	function fn_upload_edit(){
		$('#btn_upload_edit').click(function(){
			$('#frm_upload').attr('action', '${contextPath}/upload/edit?uploadBoardNo=${uploadBoardNo}');
			$('#frm_upload').submit();
		});
	}
	
	function fn_upload_list(){
		$('#btn_upload_list').click(function(){
			location.href='${contextPath}/upload/list';
		});
	}	
</script>
</head>
<body>
	<div>
		<h1>업로드 게시글 정보</h1>
		<div id="uploadDetail"></div>
	</div>
	<div>
		<form id= "frm_upload" method= "post">
		    <%-- <input type="hidden" name="uploadBoardNo" id="uploadBoardNo" value= "${uploadBoardNo}">  --%>
			<input type="button" value="게시글 편집" id="btn_upload_edit" >
			<input type="button" value="게시글 삭제" id="btn_upload_remove">
			<input type="button" value="게시글 목록" id="btn_upload_list">
		</form>
	</div>
	
	<hr>
	
		<h3>첨부 다운로드</h3>
		<input type="button" value="다운로드 목록" id="btn_download_list">
		<div id="download_area" class="blind">
		<div id ='attachList'></div>
		<div id = "allDownload"></div>
	</div>
</body>
</html>