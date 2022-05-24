<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var cnt =1;
	function fn_addFile(){
		$("#d_file").append("<input type='file' style='margin-bottom : 5px;' name='fileName"+cnt+"' />"+"<br>");
		cnt++;
	}
</script>
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

<form action="${contextPath }/test/insertNotice.do" method="post" enctype="multipart/form-data">
<h1>게시글 작성</h1>
<table class="a" align=center>
	<tr>
		<td>제목 : </td>
		<td><input type="text" name="title"></td>
		<td>작성자 : </td>
		<td><input type="text" name="id" value="${member.name }" readonly></td>
	</tr>
	<tr>
		<td>첨부파일 : </td>
		<td><input type="button" value="파일 추가" onClick="fn_addFile()" /></td>
		<td colspan="2";><div id="d_file"></div></td>
	</tr>
	<tr>
		<td colspan="4";><textarea style="width : 90%; height : 400px;" name="content"></textarea></td>
	</tr>
</table>
<input type="submit" value="작성하기">
<input type="reset" value="다시쓰기">
</form>

</body>
</html>