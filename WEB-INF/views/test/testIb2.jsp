<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />	
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="../resources/Sheet/ibsheetinfo.js"></script>
<script type="text/javascript" src="../resources/Sheet/ibsheet.js"></script>
<script type="text/javascript" src="../resources/Sheet/ibleaders.js"></script>

<script type="text/javascript" src="../resources/ibchart/highcharts/highcharts.js"></script>
<script type="text/javascript" src="../resources/ibchart/ibleaders.js"></script>
<script type="text/javascript" src="../resources/ibchart/ibchartinfo.js"></script>
<script type="text/javascript" src="../resources/ibchart/ibchart.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	LoadPage();
	doSearch();
	//LoadPage2();
});



function LoadPage() {

	var cfg = {FrozenCol:1,MergeSheet:msHeaderOnly };
	mySheet.SetConfig(cfg);
	var header = [{Text:"num|id|title|status|check|Del",Align:"Center"}];
	var info = {Sort:0,ColMove:1,ColResize:1};
	mySheet.InitHeaders(header,info);
	var cols = [
		{Type:"Text",Width:100,SaveName:"NUM",Align:"Center"},
		{Type:"Text",Width:100,SaveName:"ID",Align:"Center"},
		{Type:"Text",Width:100,SaveName:"TITLE",Align:"Center"},
		{Type:"Status",Width:60,SaveName:"Status",Align:"Center"},
	 	{Type:"CheckBox",Width:80,SaveName:"CheckBox",Align:"Center"}, 
	 	{Type:"DelCheck",Width:80,SaveName:"DelCheck",Align:"Center"}, 
	];
	mySheet.InitColumns(cols);
}

function LoadPage2() {
	createIBChart("chart-div", "myChart",{
		width: "500px",
		height: "300px"
	});
	
	myChart.setOptions({
		xAxis:{
			categories:true //X??? ??????
		},
		plotOptions:{
			series:{
				dataLabels:{
					enabled:true //???????????? ??????
				}
			}
		}
	});
	// IBSheet ??????
	sheet2chart(mySheet, myChart, {
		datadirection: "vertical",
		datarowcol: "0",
		legendseriesname: "num"+mySheet.GetRowData(1),
		legendtitle: "??????",
		startdatarowcol: 1,
		enddatarowcol: 5,
		labelrowcol: 0,
		startlabelrowcol: 1,
		endlabelrowcol: 5,
		labeldirection: "vertical",
		seriestype: ["spline"]
	});
	
}

function doAction(sAction) {
	switch(sAction) {
	 case "Insert": //??????
	 	mySheet.DataInsert();
	 break;
	 
	 case "Save": //??????
		var param = FormQueryStringEnc(document.frm);
		console.log("param : "+param);
		var result = mySheet.DoSave("${contextPath}/board/boardSaveIb.do",param);
		
		if(result = 1){
			alert("?????? ??????");			
			doSearch();
		} else{
			alert("??????");
		}
	 break;
	 
	 case "AllSave":
		 $("#s_SAVENAME").val(IBS_ConcatSaveName(mySheet));
		 var param = FormQueryStringEnc(document.frm);
		 //IBS_SaveName();
		 console.log("param : "+param);
		 var result = mySheet.DoSave("${contextPath}/board/boardAllSaveIb.do",param);
		 
		 if(result = 1){
			 alert("??????");
			 doSearch();			 
		 } else{
			 alert("??????");
		 }
		 
	 break;
	 
	 case "AllSave2":
		 $("#s_SAVENAME").val(IBS_ConcatSaveName(mySheet));
		 var param = FormQueryStringEnc(document.frm);
		 //IBS_SaveName();
		 console.log("param : "+param);
		 var result = mySheet.DoSave("${contextPath}/board/boardAllSaveIb2.do",param);
		 
		 if(result = 1){
			 alert("??????");
			 doSearch();			 
		 } else{
			 alert("??????");
		 }
	 break;
	 
	 case "AllSave3":
		 $("#s_SAVENAME").val(IBS_ConcatSaveName(mySheet));
		 var param = FormQueryStringEnc(document.frm);
		 //IBS_SaveName();
		 console.log("param : "+param);
		 var result = mySheet.DoSave("${contextPath}/board/boardAllSaveIb3.do",param);
		 
		 if(result = 1){
			 alert("??????");
			 doSearch();			 
		 } else{
			 alert("??????");
		 }
	 break;
	 
	 case "Copy": //?????????
	 	mySheet.DataCopy();
	 break;
	 
	 case "Chart": //?????????
	 	LoadPage2();
	 break;
	}
}

function doSearch() { //????????????
	 //var param = frm.num.value;
	 //console.log(param);
	//???????????? (????????????, ????????????);
	mySheet.DoSearch("${contextPath}/board/boardIb.do");
}

/* function mySheet_OnSearchEnd(code, msg){
	
	alert(code);
	
} */
 </script>
 <style type="text/css">
 	#DIV_mySheet{
 		margin : auto;
 	}
 
 </style>
</head>

<body>
<div style="text-align : center;">
<h1>???????????????2</h1>

<!--?????? ?????? -->
<form method="POST" name="frm">
<script type="text/javascript">
	createIBSheet("mySheet", "540px", "400px");
</script><br>
<input type="hidden" name="s_SAVENAME" id="s_SAVENAME"/>
	<table cellpadding="0" cellspacing="1" border="0" width="100%">
		<tr>
			<!-- <td bgcolor="#FFFFFF">
				Num : 
				<input type="text" name="num" id="num">
				id : 
				<input type="text" name="id" id="id">
				title : 
				<input type="text" name="title" id="title">
				<input type="button" value="??????" onClick="doSearch()"> 
			</td> -->
		</tr>
	</table>
	<!--?????? ??????-->
<input type="button" value="??????" onClick="doAction('Insert')">
<!-- ????????? ?????? -->
<input type="button" value="??????" onClick="doAction('Save')">
<!-- ????????? ?????? ?????? -->
<input type="button" value="?????? ??????" onClick="doAction('AllSave')">
<!-- ????????? ?????? ??????2 -->
<input type="button" value="?????? ??????2" onClick="doAction('AllSave2')">
<!-- ????????? ?????? ??????3 -->
<input type="button" value="?????? ??????3" onClick="doAction('AllSave3')">
<!--????????? ??????-->
<input type="button" value="?????????" onClick="doAction('Copy')">
<!--????????? ??????-->
<input type="button" value="?????? ??????" onClick="doAction('Chart')">
</form>
</div><br>

<div id="chart-div" style="margin : auto;"></div>

</body>
</html>