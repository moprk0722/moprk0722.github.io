<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
	.a{
		margin-bottom: 15px;
		width:80%;
		border : 1px solid;
	}
	.a td{
		padding : 5px;
		border : 1px solid;
	}
	.b{
		margin-right: 10%;
		margin-bottom: 15px;
		width:30%;
		border : 1px solid;
	}
	.b td{
		padding : 5px;
		border : 1px solid;
	}
	.c{
		margin-left: 10%;
		margin-bottom: 15px;
		border : 1px solid;
		width: 49%;
	}
	.c td{
		padding : 5px;
		border : 1px solid;
	}
</style>

<script>

 	$(document).ready(function(){
 		console.log("11111");
	});
	

	
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="${contextPath}/test/selectNotice.do?num=${notice.NUM}&nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
	
	function listReply() {
		var htmls = "";
		var paramData = {
				"num" : "${notice.NUM}"
		}
		$.ajax({
			type:'POST',
			url:"${contextPath}/test/listReply.do",
			data : paramData,
			dataType : 'json',
			success:function(data){
				
					htmls += '<tr>';
					htmls += '<td colspan="4"><h3>덧글 게시판</h3></td>';
					htmls += '</tr>';
				
				if(data.length ==0){
					htmls += '<tr>';
					htmls += '<td>등록된 덧글이 없습니다.</td>';
					htmls += '</tr>';
				}

				$(data).each(function(){
					htmls += '<tr style="width : 90%;">';
					htmls += '<td>작성자 : </td>';
					htmls += '<td>'+this.RE_ID+'</td>';
					htmls += '<td>날짜 : </td>';
					htmls += '<td>'+this.RE_WRITEDATE+'</td>';
					htmls += '</tr>';
					
					htmls += '<tr>';
					htmls += '<td>내용</td>';
					htmls += '<td colspan="3" id="RE_NUM'+this.RE_NUM+'">'+this.RE_CONTENT+'</td>';
					htmls += '</tr>';
					
					htmls += '<tr>';
					htmls += '<td colspan="4" style="text-align : right;">';
					htmls += '<input type="button" value="수정" style="margin-right : 10px;" onClick="editReply('+this.RE_NUM+','+this.RE_CONTENT+')">';
					htmls += '<input type="button" value="삭제" onClick="deleteReply('+this.RE_NUM+')">';
					htmls += '</td>';
					htmls += '</tr>';
				});
				
				
				$("#listReply").html(htmls);
			},
			error:function(data){
				alert("에러 발생 리스트");
			}
		})
		}
	
	function editReply(RE_NUM, RE_CONTENT) {
		var htmls = "";
		htmls += '<td colspan="3">';
		htmls += '<textarea style="width : 98%;" id="editContent">'+RE_CONTENT+'</textarea>';
		htmls += '<input type="button" value="저장" style="margin-right : 10px;"';
		htmls += 'onClick="updateReply('+RE_NUM+')">';
		htmls += '<input type="button" value="취소" onClick="listReply()">';
		htmls += '</td>';
		
		$("#RE_NUM" + RE_NUM).replaceWith(htmls);
		
	}
	
	function updateReply(RE_NUM){
		var editContent = $("#editContent").val();
		var paramData = {
				"num" : RE_NUM,
				"content" : editContent
		}
		$.ajax({
			type : 'POST',
			url : "${contextPath}/test/updateReply.do",
			data : paramData,
			dataType : "json",
			success : function(){
				listReply();
			},
			error : function(){
				alert("에러 발생 업데이트");
			}
			
		})
		
	}
	
	function insertReply() {
		var id2 = $('#id2').val();
		var content2 = $('#content2').val();
		var num2 = $('#num2').val();
		var paramData = {
				"id" : id2,
				"content" : content2,
				"num" : num2
		}
		$.ajax({
			type : 'POST',
			url : "${contextPath}/test/insertReply.do",
			data : paramData,
			dataType : "json",
			success : function(){
				listReply();
				resetText();
			},
			error : function(){
				alert("에러 발생 인서트");
			}
			
		})
	}
	
	function deleteReply(RE_NUM) {
		
		var paramData = {
				"num" : RE_NUM
		}
		$.ajax({
			type : 'POST',
			url : "${contextPath}/test/deleteReply.do",
			data : paramData,
			dataType : "json",
			success : function(){
				listReply();
			},
			error : function(){
				alert("에러 발생 델리트");
			}
			
		})
	}
	
/* 	function selectNotice() {
		type : 'POST',
		url : "${contextPath}/test/selectNotice.do",
		data : paramData,
		dataType : "json",
		success : function() {
			htmls += "";
		},
		error : function() {
			alret("에러");
		}
	} */
	
	function resetText(){
		document.getElementById("content2").value="";		
	}

</script>

</head>
<body>
<h1>게시글</h1>
<table class="a" align=center>
	<tr>
		<td>제목 : </td>
		<td><input type="text" name="title" value="${notice.TITLE }" readonly></td>
		<td>작성자 : </td>
		<td><input type="text" name="id" value="${notice.ID }" readonly></td>
	</tr>
	<tr>
		<td>첨부파일 : </td>
		<td><input type="button" value="파일 추가" onClick="fn_addFile()" readonly/></td>
		<td colspan="2"><div id="d_file"></div></td>
	</tr>
	<tr>
		<td colspan="4">
			<textarea style="width : 90%; height : 100px;" name="content" readonly>
			${notice.FILEBLOB }
			${notice.CONTENT }
			</textarea>
			<c:forEach var="file" items="${file }">
				<div>
					<input type="button" value="파일 다운로드" 
					onClick="location.href='${contextPath }/test/download.do?fileNum=${file.NUM }&fileName=${file.FILENAME}'"> 
					${file.FILENAME }
					${file.FILEBLOB }
				</div>
			</c:forEach>
<%-- 			<img alt="미리보기" style="width : 50%;" src="${contextPath }/test/preview.do?fileName=${notice.NUM}" /><br> --%>
			<%-- <input type="button" value="파일 다운로드" onClick="location.href='${contextPath }/test/download.do?fileName=${notice.NUM}'"> --%>
			<%-- <img src="${contextPath }/resources/upload/${notice.FILENAME}" /> --%>
			<!-- <div class="fileImg fileEmpty" id="preView">
                    <span>파일 미리보기</span>
            </div> -->
		</td>
	</tr>
</table>
<input type="hidden" id="num2" value="${notice.NUM }">
<input type="hidden" id="num" value="${notice.NUM }">

<hr>
<div style="display : flow-root;">
<!-- <table class="c" align="left" id="listReply">
</table> -->
<table class="c" align="left" id="listReply">
	<tr>
		<td colspan="4"><h3>덧글 게시판</h3></td>
	</tr>
<c:forEach var="reply" items="${reply }">
	<tr style="width : 90%;">
		<td>작성자 : </td>
		<td>${reply.RE_NUM }</td>
		<td>날짜 : </td>
		<td>${reply.RE_WRITEDATE }</td>
		</tr>
				
		<tr>
		<td>내용</td>
		<td colspan="3" id="RE_NUM${reply.RE_NUM}">${reply.RE_CONTENT }</td>
		</tr>
				
		<tr>
		<td colspan="4" style="text-align : right;">
		<input type="button" value="수정" style="margin-right : 10px;" 
		onClick="editReply(${reply.RE_NUM},${reply.RE_CONTENT })">
		<input type="button" value="삭제" onClick="deleteReply(${reply.RE_NUM})">
		</td>
		</tr>
</c:forEach>
</table>
<table class="b" align=right>
	<tr>
		<td colspan="2"><h3>덧글 작성란</h3></td>
	</tr>
	<tr>
		<td>작성자 : </td>
		<td><input type="text" id="id2" value="${member.name }" readonly></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea style="width : 90%;" id="content2"></textarea></td>
	</tr>
	<tr>
		<td></td>
		<td style="text-align : right;">
			<input type="button" style="margin-right : 10px;"
			value="작성" onClick="insertReply()">
			<input type="button" value="초기화" onClick="resetText()">
		</td>
	</tr>
</table><br>
</div>
<div style="display: block; text-align: center;">
	<div style="float: left; margin-left: 10%;">
		<select id="cntPerPage" name="sel" onchange="selChange()">
			<option value="5"
				<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
			<option value="10"
				<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
			<option value="15"
				<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
			<option value="20"
				<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
		</select>
	</div>
	<div style="text-align: initial; margin-left: 50%;">
		<c:if test="${paging.startPage != 1 }">
			<a href="${contextPath}/test/selectNotice.do?num=${notice.NUM}&nowPage=${paging.startPage-1 }
			&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="${contextPath}/test/selectNotice.do?num=${notice.NUM }&nowPage=${p }
					&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="${contextPath}/test/selectNotice.do?num=${notice.NUM }&nowPage=${paging.endPage+1 }
			&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
	</div>
	</div>
	<br>
</body>
</html>