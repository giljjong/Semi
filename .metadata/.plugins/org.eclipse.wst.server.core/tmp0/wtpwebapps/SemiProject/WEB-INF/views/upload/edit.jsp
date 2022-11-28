<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>
$(function(){
	fn_fileCheck();
	fn_removeAttach();
});

function fn_fileCheck(){
	
	$('#files').change(function(){
		
		// 첨부 가능한 파일의 최대 크기
		let maxSize = 1024 * 1024 * 10;  // 10MB
		
		// 첨부된 파일 목록
		let files = this.files;
		
		// 첨부된 파일 순회
		for(let i = 0; i < files.length; i++){
			
			// 크기 체크
			if(files[i].size > maxSize){
				alert('10MB 이하의 파일만 첨부할 수 있습니다.');
				$(this).val('');  // 첨부된 파일을 모두 없애줌
				return;
			}
			
		}
		
	});
	
	$(document).ready(function(){
		$('#btn_edit').click(function(){
			const form = $('#frm_edit')[0];
			console.log(form);
			const formData = new FormData(form);
			$.ajax({
				type : 'POST',
				url :'${contextPath}/upload/uModify',
				enctype :'multipart/form-data',
				data : formData,
				processData : false,
				contentType : false,
			    success : function(resData){
					console.log(resData);
					alert('수정이 성공했습니다.');
					location.href='${contextPath}/upload/detail?uploadBoardNo=' + ${edit.upload.uploadBoardNo};
				},
				error: function(jqXHR){
					alert('수정이 실패했습니다.');
					history.back();
				} 
			})
			
		});
		
	    $.ajax({
			type : 'POST',
			url : '${contextPath}/upload/uedit?uploadBoardNo=' + ${edit.upload.uploadBoardNo} ,
			dataType : 'json',
			success : function(resData){
				console.log(resData.upload.uploadBoardNo)
				
				$.each(resData.attachList, function(i, attach){
				     $('<ul>')
					 .append( $('<li>').append( $('<a>').text(attach.origin).attr('href', '${contextPath}/upload/attach/remove?uploadBoardNo='+ resData.upload.uploadBoardNo + '&attachNo=' + attach.attachNo).attr('class','attachRemove'  )   ) )
					 .appendTo('#attachList'); 
				 })
			}
			
		})  
		
		/* function fn_removeAttach(){
				// 첨부 삭제
				$('.btn_attach_remove').click(function(){
					if(confirm('해당 첨부파일을 삭제할까요?')){
						location.href = '${contextPath}/upload/attach/remove?uploadNo=' + $(this).data('upload_no') + '&attachNo=' + $(this).data('attach_no');
					}
				});
			} */
	
	})
	
	function fn_removeAttach(){
		$('.attachRemove').click(function(){
			if(confirm('해당 첨부파일을 삭제할까요?')){
				alert('삭제했습니다.');
			}
		})
	}
	
}

</script>
</head>
<body>
	<div>
		<h1>수정화면</h1>
		<form id ="frm_edit" >
			<input type="hidden" name="uploadBoardNo" value = "${edit.upload.uploadBoardNo}">
			<div>
				<label for="title">제목</label>
				<input type="text" id="title" name="title" value="${edit.upload.uploadTitle}" required="required">
			</div>
			<div>
				<label for="content">내용</label>
				<input type="text" id="content" name="content" value="${edit.upload.uploadContent}">
			</div>
			<div>
				<label for="files">첨부 추가 </label>
				<input type="file" id="files" name="files"   multiple="multiple">
			</div>
			<div>
				<input type="button" value="수정완료" id="btn_edit">
				<input type="button" value="목록" onclick="location.href='${contextPath}/upload/list'">
			</div>
		</form>
		
		<div>
			<h3>첨부삭제</h3>
			<div id ='attachList'></div>
			<%-- <c:forEach items="${attachList}" var="attach">
				<div>
					${attach.origin} <input type="button" value="삭제" class="btn_attach_remove" data-upload_no="${upload.uploadBoardNo}" data-attach_no="${attach.attachNo}">
				</div>
			</c:forEach> --%>
		</div>
	</div>

</body>
</html>