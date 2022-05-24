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
<c:choose>
	<c:when test="${result=='loginFailed' }">
	  <script>
	    window.onload=function(){
	      alert("아이디나 비밀번호가 틀립니다.다시 로그인 하세요!");
	    }
	 	
	  </script>
	</c:when>
</c:choose> 
</head>
<body>
<style>
	.a td{
		padding : 10px;
	}
</style>

<h2>로그인</h2>
<form method="post" action="${contextPath}/member/login.do">
<table class="a" style="margin:auto; border : 1px solid;">
	<tr>
		<td>ID : </td>
		<td><input type="text" name="id"></td>
	</tr>
	<tr>
		<td>PW : </td>
		<td><input tyep="text" name="pwd"></td>
	</tr>
	<tr>
		<td></td>
		<td  style="text-align : right;">
			<input type="button" value="회원가입" onClick="location.href='${contextPath}/member/memberForm.do'">
			<input type="submit" value="제출">
			<input type="reset" value="취소"></td>
	</tr>
</table>
</form>
</body>
</html>