<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="uploadAction.jsp" id="upload" method="post" enctype="multipart/form-data">
<input type="text" id="text1" name="title">
<input type="text" id="text2" name="content">
<input type="file" id="file" name="file">
<input type="submit">
</form>
</body>
</html>