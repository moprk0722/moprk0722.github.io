<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원의 상세 정보</title>
<style>
	h2 {
		text-align: center;
	}
	table {
		width: 100%;
	}
	#outter {
		display: block;
		width: 60%;
		margin: auto;
	}
	a {
		text-decoration: none;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="${contextPath}/member/selectMembers.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}

	$(document).ready(function (){
		boardList();
	});
	
	function addHtml(){
		$("#article").html('안녕하세요');
	}
	
	function fn_process() {
		var value = $("#t_input").val();
		$("#t_output").val(value);
	}
	function boardList() {
		var htmls = "";
		$.ajax({
			type:'POST',
			url:"${contextPath}/member/selectMembers.do",
			success:function(data){
				
				//console.log(data);
				
				for(var i=0 ; i<data.length ; i++){
					
					console.log(data[i].NUM);
					
				}
				
				console.log(data[0]);
				
				
				/* for(var i=0; i<data.length; i++){
					htmls += '<tr>';
					htmls += '<td>'+data.ID+'</td>';
					htmls += '<td>'+data[i].TITLE+'</td>';
					htmls += '<td>'+data[i].NUM+'</td>';
					htmls += '<td>';
					htmls += '<input type="button" value="삭제" onClick="boardDelete()">'
					htmls += '</td>';
					htmls += '</tr>';
				} */

				$(data).each(function(){		
					htmls += '<tr>';
					htmls += '<td>'+this.ID+'</td>';
					htmls += '<td>'+this.title+'</td>';
					htmls += '<td>'+this.num+'</td>';
					htmls += '<td>';
					htmls += '<input type="button" value="삭제" onClick="boardDelete()">'
					htmls += '</td>';
					htmls += '</tr>';

				});
				
				
				$("#boardList").html(htmls);
			},
			error:function(data){
				alert("에러 발생");
			}
		})
	}

	
	function boardInsert() {
		var id = $('#id').val();
		var title = $('#title').val();
		var paramData = {
				"id" : id,
				"title" : title
		}
		$.ajax({
			type : 'GET',
			url : "${contextPath}/member/boardInsert.do",
			data : paramData,
			dataType : "json",
			success : function(){
				boardList();
			},
			error : function(){
				alert("에러");
			}
			
		})
	}
</script>
</head>
<body>
	<table align="center">
		<tr align="center"   bgcolor="lightgreen">
      		<td ><b>아이디</b></td>
      		<td><b>비밀번호</b></td>
      		<td><b>이름</b></td>
      		<td><b>이메일</b></td>
      		<td><b>가입일</b></td>
      	</tr>
   		<tr align="center">
      		<td>${member.id}</a></td>
      		<td>${member.pwd}</td>
      		<td>${member.name}</td>
      		<td>${member.email}</td>
     		<td>${member.joinDate}</td>
    </tr>
    
    	<tr bgcolor="lightgreen">
    		<td></td><td></td><td></td><td></td><td></td>
    	</tr>
  
	</table><hr>
	
	<table>
		<tr id="boardList">
	</table>
	
	 <div id="outter">
		<div style="float: right;">
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
	 <table>
	 <c:forEach var="boardList" items="${boardList }">
	 	<tr>
	 		<td>${boardList.num }</td>
	 		<td>${boardList.title }</td>
	 	</tr>
	 </c:forEach>
	 </table>
	 
	<div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="${contextPath}/member/selectMembers.do?id=${sessionId }&
			nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="${contextPath}/member/selectMembers.do?id=${sessionId }&nowPage=${p }
					&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="${contextPath}/member/selectMembers.do?id=${sessionId }&nowPage=${paging.endPage+1 }
			&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
	</div>
	</div>
	
	<form method="get" action="${contextPath }/member/BoardInsert.do">
	<div style="text-align : center; margin : 25px;">
		<input type="text" name="id" id="id">
		<input type="text" name="title" id="title">
		<input type="button" value="추가" onClick="boardInsert()">
	</div>
	</form>
	 
	<div style="text-align : center; border : 1px solid;"> .html() 예제
		<p id="article">123</p>
		<input type="button" value="제이쿼리  온클릭" onClick="addHtml()">
	</div><br>
	
	<div style="text-align : center; border : 1px solid;"> .val() 예제
	<p></p>
		<input type="text" id="t_input">
		<input type="button" value="출력" onClick="fn_process()">
		<input type="text" id="t_output" disabled />
	</div>
</body>
</html>