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
</head>
<body>

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
</style>

<form action="${contextPath }/test/updateNotice.do?num=${Notice.NUM}" method="post">
<h1>게시글 수정</h1>
<table class="a" align=center>
	<tr>
		<td>제목 : </td>
		<td><input type="text" name="title" value="${Notice.TITLE }"></td>
		<td>작성자 : </td>
		<td><input type="text" name="id" value="${Notice.ID }" readonly></td>
	</tr>
	<tr>
		<td>첨부파일 : </td>
		<td><input type="button" value="파일 추가" onClick="fn_addFile()" /></td>
		<td colspan="2"><div id="d_file"></div></td>
	</tr>
	<tr>
		<td colspan="4"><textarea style="width : 90%; height : 400px;" name="content">${Notice.CONTENT }</textarea>
		</td>
	</tr>
</table>
<input type="submit" value="수정하기">
<input type="reset" value="다시쓰기">
</form>
</body>
</html>