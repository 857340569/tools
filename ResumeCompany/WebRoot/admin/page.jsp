<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.bor001{
		border-top:2px solid #4680d1;
	}
	.pageInfo{
		color:#484848;
	}
	
</style>
<script>
$(function(){
	if("${pageSize >= divPage.totalCount}"=="true")
	{
		$(".changePage").each(function(){
			$(this).attr("href","javascript:void(0);");
		});
		$("#go").attr("onClick","return false;");
	}else{
		if("${divPage.currentPageNo}"==1)//首页
		{
			$("#indexPage").attr("href","javascript:void(0);");
			$("#prevPage").attr("href","javascript:void(0);");
		}else if("${divPage.currentPageNo}"=="${divPage.totalPageCount}")//尾页
		{
			$("#lastPage").attr("href","javascript:void(0);");
			$("#nextPage").attr("href","javascript:void(0);");
		}
	}
});

</script>
		<c:choose>
			<c:when test="${empty param.para}">
				<c:set var="paramurl" value="${param.url}?" />
			</c:when>
			<c:otherwise>
				<c:set var="paramurl" value="${param.url}?${param.para}&" />
			</c:otherwise>
		</c:choose>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bor001" >
			<tr class="divPage">
				<td align="right" style="height: 25px;padding-bottom:5px;"><span class="pageInfo">每页显示${pageSize}条&nbsp;&nbsp;<c:if test="${divPage.totalCount==0}">0</c:if><c:if test="${divPage.totalCount>0}">${divPage.currentPageNo}</c:if>/<span id="pageCount"><c:if test="${divPage.totalCount==0}">0</c:if><c:if test="${divPage.totalCount>0}">${divPage.totalPageCount}</c:if></span>页&nbsp;共<c:out value="${divPage.totalCount}" />条记录&nbsp;&nbsp;</span>
					<a href="${paramurl}currentPage=1" class="page_a changePage" id="indexPage" hideFocus="true">首页</a> | 
						<a href="${paramurl}currentPage=${divPage.previousPageNo}" class="page_a changePage" id="prevPage" hideFocus="true">上一页</a> | <a
					href="${paramurl}currentPage=${divPage.nextPageNo}" class="page_a changePage" id="nextPage" hideFocus="true">下一页</a> 
					| <a href="${paramurl}currentPage=${divPage.totalPageCount}" class="page_a changePage" id="lastPage" hideFocus="true">末页</a>
					<input  type="text" name="goPage" style="width: 25px; height:15px;" id="goPage" value="${divPage.currentPageNo}"/> 
					<input class="input_button" name="go" type="button" id="go" style="width: 30px; height:20px;cursor: hand;" onClick="gopage()" value="GO" />&nbsp;&nbsp;
				</td>
			</tr>
		</table>

	<script type="text/javascript" language="javascript">
		function gopage() {
			var pageSize = parseInt('${divPage.pageSize}');
			var endPage = parseInt('${divPage.totalPageCount}');
			var goPage = document.getElementById("goPage").value;
			if (!isNaN(parseInt(goPage))) {
				goPage = parseInt(goPage);
			}

			if (/^(?!0)\d*$/.test(goPage)) {
				if(goPage=="${divPage.currentPageNo}")
				{
					return;
				}
				if (goPage > 0) {
					if (goPage <= endPage) {
						window.location.href = '${paramurl}' + "currentPage="
								+ goPage;
					} else {
						alert("不能大于总页数！");
						document.getElementById('goPage').value = endPage;
						document.getElementById('goPage').focus();
					}
				} else {
					alert("请输入大于0的整数！");
					document.getElementById('goPage').value ="${divPage.currentPageNo}" ;
					document.getElementById('goPage').focus();
				}
			} else {
				alert("请输入大于0的整数！");
				document.getElementById('goPage').value = "${divPage.currentPageNo}";
				document.getElementById('goPage').focus();
			}
		}
	</script>
