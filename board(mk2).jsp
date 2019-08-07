<%@page import="com.alpaca.board.boardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alpaca.board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet"> 
    <style type="text/css">
    body{
    font-family: 'Nanum Gothic', sans-serif;
    font-size: 20px;
    }
    </style>
    <title>알파카</title>
</head>

<body class="bg-dark text-success text-center">
    <%
		if (session.getAttribute("id") == null) {
	%>
    <div class="container mt-3">
    <div class="row">
        <a href="index.jsp" class="btn btn-outline-secondary btn-lg border-0" role="button">HOME</a>
        <a href="about.jsp" class="btn btn-outline-secondary btn-lg border-0" role="button">ABOUT</a>
        <a href="board.jsp" class="btn btn-outline-secondary btn-lg border-0 active" role="button">BOARD</a>
        <a href="work.jsp" class="btn btn-outline-secondary btn-lg border-0" role="button">WORK</a>
        <div class="dropdown ml-auto">
  		<button type="button" class="btn btn-outline-secondary btn-lg border-0 dropdown-toggle" data-toggle="dropdown">
    	MENU
  		</button>
  		<div class="dropdown-menu">
    	<a class="dropdown-item btn btn-outline-secondary btn-lg boarder-0" href="login.jsp">LOGIN</a>
    	<a class="dropdown-item btn btn-outline-secondary btn-lg boarder-0" href="join.jsp">JOIN</a>
    	<a class="dropdown-item btn btn-outline-secondary btn-lg boarder-0" href="idFind.jsp">ID찾기</a>
    	<a class="dropdown-item btn btn-outline-secondary btn-lg boarder-0" href="pwFind.jsp">PW찾기</a>
  		</div>
		</div>
        </div>
        </div>
    <div class="container mt-5">
        로그인을 하셔야 둘러보실수 있어요^^.<br>
        <a href="join.jsp" class="btn btn-outline-secondary btn-lg" role="button">JOIN</a>
        <br>
        이미 가입 하셨나요?<br>
        <a href="login.jsp" class="btn btn-outline-secondary btn-lg" role="button">LOGIN</a><br>
    </div>
    <%
		} else {
	%>
    <div class="container mt-3">
    <div class="row">
        <a href="index.jsp" class="btn btn-outline-secondary btn-lg border-0" role="button">HOME</a>
        <a href="about.jsp" class="btn btn-outline-secondary btn-lg border-0" role="button">ABOUT</a>
        <a href="board.jsp" class="btn btn-outline-secondary btn-lg border-0 active" role="button">BOARD</a>
        <a href="work.jsp" class="btn btn-outline-secondary btn-lg border-0" role="button">WORK</a>       
  		<div class="dropdown ml-auto">
  		<button type="button" class="btn btn-outline-secondary btn-lg border-0 dropdown-toggle" data-toggle="dropdown">
    	MENU
  		</button>
  		<div class="dropdown-menu">
    	<a class="dropdown-item btn btn-outline-secondary btn-lg boarder-0" href="logout.jsp">LOGOUT</a>
  		</div>
		</div>
		</div>
    </div>
    <div class="container mt-5">
        <table class="table table-dark table-hover text-success">
            <tr>
                <th>글번호</th>
                <th>글제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>날짜</th>
            </tr>
            <%
            boardDAO dao = new boardDAO();
            int pagenum = 0;
            if(request.getParameter("pagen") != null){
            	pagenum = Integer.parseInt(request.getParameter("pagen"));
            }
            	int num = (pagenum+1)*5+1;
            	out.print(num);
                ArrayList<boardVO> list = dao.boardList(num);
                for(int i=0; i<list.size(); i++){
                	%>
                	<tr>
                <th><%=list.get(i).getBnum() %></th>
                <th><%=list.get(i).getTitle() %></th>
                <th><%=list.get(i).getWriter() %></th>
                <th><%=list.get(i).getCount() %></th>
                <th><%=list.get(i).getDate() %></th>
            </tr>
            	<%
            }
            %>
        </table>
    </div>
    <div class="container mt-5">
    <%
    int pageindex = dao.getPage();
    if(pageindex%5==0){
    	pageindex = dao.getPage()/5;
    }else{
    	pageindex = dao.getPage()/5+1;
    }
    for(int i=0; i<pageindex; i++){
    	%>
    	<a href="board.jsp?pagen=<%=i%>" class="btn btn-success btn-lg" role="button"><%=i+1 %></a>
    	<%
    }
    %>
	</div>
	<div class="container mt-5">
	<a href="write.jsp" class="btn btn-outline-secondary btn-lg" role="button">글쓰기</a>
	</div>
	<%
		}
	%>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

</html>