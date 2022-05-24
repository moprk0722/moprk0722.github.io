<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		var members=["john", "steve", "ben"]
		$('p').html(members.join("<br>"));
		
		var memlist=$("#list");
		$.each(members.function(index,value){
			memlist.append($("<li>"+value+"</li>"))
		})
	})
</script>
</head>
<body>

<h3>members of my group are</h3>
<p></p>
<ul>
	<li>John</li>
	<li>Steve</li>
	<li>Ben</li>		
</ul>

</body>
</html>