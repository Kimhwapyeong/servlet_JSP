<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function deleteMember(pageNo) {
		var res = confirm("정말 회원을 삭세하시겠습니까?");
		if(res){
			
			delIdList = document.querySelectorAll("[name=delId]:checked");
			
			let delId = "";
			
			delIdList.forEach((e)=>{
				delId += "'" + e.value + "',";
			})
			
			delId = delId.substr(0, delId.length-1);
			
			searchForm.action='../member/delete.member';
			searchForm.delId.value=delId;
			searchForm.pageNo.value=pageNo;
			searchForm.submit();
		}
		
	}

</script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<c:set value="${map.list }" var="list"/>
<form name='searchForm' action="../member/list.member">
<input type='hidden' name='pageNo' value='1'>
<!-- <input type='hidden' name='pageNo' value='${ empty pageNo && "" eq pageNo ? 1 : pageNo}'> -->
<input type='hidden' name='delId'>
<table border='1' width='100%'>
	<tr>
		<td align="center">
			<select name='searchField'>
				<option value='id' ${param.searchField eq 'id' ? "selected" : "" }>아이디</option>
				<option value='name' ${param.searchField eq 'name' ? "selected" : "" }>이름</option>
			</select>
			<input type="text" name="searchWord" value="${param.searchWord }">
			<input type="submit" value="검색하기">
		</td>
	</tr>
</table>
</form>
총 건수 : ${map.totalCnt }
<table border='1' width="100%">
	<tr>
		<td colspan="5" class='right'>
		<button onclick="deleteMember(${map.criteria.pageNo})">회원삭제</button>
		</td>
	</tr>
	<tr>
		<th width='10%'></th>
		<th width='30%'>아이디</th>
		<th width='25%'>이름</th>
		<th width='15%'>관리자여부</th>
		<th width='10%'></th>
	</tr>
	
	<c:if test="${empty list}" var="res">
		<tr style="text-align:center">
			<td colspan='6'>조회된 회원이 없습니다.</td>
		</tr>
	</c:if>

	<c:if test="${ not res }">
		<c:forEach items="${list }" var="member">
			<tr class='center'>
				<td><input type="checkbox" name='delId' value='${member.id }'></td>
				<td>${member.id }</td>
				<td>${member.name }</td>
				<td>${member.adminyn }</td>
				<td>
					<c:if test="${member.adminyn eq 'N' }">
						<button onclick="updateMember(${member.id})" style="font-size:12px">관리자권한</button>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		
		<tr>
			<td colspan='5' class='center'>
				<jsp:include page="../common/PageNavi.jsp"></jsp:include>
			</td>
		</tr>
	</c:if>
</table>

</body>
</html>