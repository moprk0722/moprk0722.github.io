<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>    
<html>
<head>
<meta charset=UTF-8">
<title>회원 정보 출력창</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		var sType = document.getElementById('searchType').value;
		location.href="${contextPath}/test/testNotice.do?nowPage=1&cntPerPage="+sel+"&search=${keyword.search}&searchType="+sType;
	}
	function selChange2() {
		document.getElementById('search').value = null;
	}
	function buttonReset() {
		document.getElementById('search').value = null;
	}
	
</script>
<body>
<table border="1"  align="center"  width="80%">
    <tr align="center"   bgcolor="lightgreen">
      <td><b>번호</b></td>
      <td><b>작성자</b></td>
      <td style="width : 40%;"><b>제목</b></td>
      <td style="width : 200px;"><b>작성일자</b></td>
      <td style="width : 10%;"><b>수정</b></td>
      <td style="width : 10%;"><b>삭제</b></td>
   </tr>
 <c:forEach var="notice" items="${notice}" > 
   <tr align="center">
      <td>${notice.NUM}</td>
      <td>${notice.ID}</td>
      <td><a href="${contextPath }/test/selectNotice.do?num=${notice.NUM}">${notice.TITLE}</a></td>
      <td>${notice.WRITEDATE}</td>
      <td><a href="${contextPath}/test/updateNotice.do?num=${notice.NUM }">수정하기</a></td>
      <td><a href="${contextPath}/test/deleteNotice.do?num=${notice.NUM }">삭제하기</a></td>
    </tr> 
</c:forEach>
</table><br>

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
			<a id="lt" href="${contextPath}/test/testNotice.do?nowPage=${paging.startPage-1 }
			&cntPerPage=${paging.cntPerPage}&search=${keyword.search}&searchType=${keyword.searchType}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a id="p" href="${contextPath}/test/testNotice.do?nowPage=${p }
					&cntPerPage=${paging.cntPerPage}&search=${keyword.search}&searchType=${keyword.searchType}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a id="gt" href="${contextPath}/test/testNotice.do?nowPage=${paging.endPage+1 }
			&cntPerPage=${paging.cntPerPage}&search=${keyword.search}&searchType=${keyword.searchType}">&gt;</a>
		</c:if>
	</div>
</div><br>

<input type="hidden" name="keyword" value="${keyword.search }">

<!-- <div>
	<input type="text" name="search" id="search">
	<input type="button" name="btnSearch" id="btnSearch" value="검색" onClick="buttonSearch()">
</div> -->
<form method="get" action="${contextPath }/test/testNotice.do?search=${search}">
<div style="float: left; margin-left: 10%;">
	<select id="searchType" name="searchType" onChange="selChange2()">
		<option value="t"
			<c:if test="${keyword.searchType eq 't'}">selected</c:if>>제목 검색</option>
		<option value="c"
			<c:if test="${keyword.searchType eq 'c'}">selected</c:if>>내용 검색</option>
		<option value="w"
			<c:if test="${keyword.searchType eq 'w'}">selected</c:if>>작성자 검색</option>
	</select>
</div>
<div>
	<input type="text" name="search" id="search" value="${keyword.search }">
	<input type="submit" value="검색" onClick="buttonSearch()">
	<input type="button" value="취소" onClick="buttonReset()">
</div>
</form>
<a href="${contextPath}/test/insertNotice.do"><h1 style="text-align:center; margin-top : 30%;">글 쓰러가기</h1></a>
</body>
</html>