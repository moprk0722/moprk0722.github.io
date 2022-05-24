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
<script type="text/javascript" src="../resources/common/js/common.js"></script>
<script type="text/javascript" src="../resources/Sheet/ibsheetinfo.js"></script>
<script type="text/javascript" src="../resources/Sheet/ibsheet.js"></script>

<style>
		html,body{Width:100%;height:100%;padding:0px;margin:0px}
	</style>
	<script>
		function init(){
			//sheet 초기화
			var initData = {};
			initData.Cfg = {SearchMode:smLazyLoad, Page:30,MouseHoverMode:2};
			initData.Cols = [
				{Header:"No",Type:"Seq", SaveName:"dSeq", Width:40, Align:"Center",Edit:0},
				{Header:"통화",Type:"Text", SaveName:"CURRENCY", Width:120, Align:"Center",Edit:0},
				{Header:"ISO",Type:"Text", SaveName:"ISO", Width:60, Align:"Center",Edit:0},
				{Header:"기호",Type:"Text", SaveName:"SYMBOL", Width:80, Align:"Center",Edit:0},
				{Header:"10진수",Type:"Int", SaveName:"DEC", Width:80, Align:"Center",Edit:0}
			];
			initData.HeaderMode  = {ColMove:1};
			IBS_InitSheet(popupSheet,initData);
			
			//데이터 조회
			popupSheet.DoSearch("../resources/json/popup_data.json");
		}
		
		//조회 완료 이벤트
		function popupSheet_OnSearchEnd(code,msg){
			var cur = "<%=request.getParameter("searchCondition")%>";
			//어미 창에서 선택한 ISO와 동일한 값을 찾아 행을 이동 시킨다.
			var row = popupSheet.FindText("ISO",cur);
			//행 이동(SelectCell 함수도 있음)
			popupSheet.SetSelectRow(row);
		}
		
		//더블 클릭 이벤트 (주의:모바일에서는 동작하지 않음)
		function popupSheet_OnDblClick(Row, Col, Value, CellX, CellY, CellW, CellH) { 
			//더블클릭한 행의 데이터를 json 형식으로 추출
			var rowData = popupSheet.GetRowData(Row);			
			//어미 창의 시트에 세팅
			parent.setData(rowData);
			//현재 창을 감춘다.
			parent.showAndHide(0);
		}
	</script>
</head>
	<body onload="init()" style="overflow:hidden">
		<script>createIBSheet("popupSheet","100%","100%");</script>
	</body>
</html>