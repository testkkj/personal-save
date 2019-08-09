<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String result = "----------------------------------------<br>";
	String realFolder = "";
	String saveFolder = "/image";
	String encType = "UTF-8";
	int maxSize = 5 * 1024 * 1024;

	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	MultipartRequest upload = null;
	upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String title = upload.getParameter("title");
	String content = upload.getParameter("content");
	
	out.print(title);
	out.print(content);

	try {
		
		Enumeration<?> params = upload.getParameterNames();

		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = upload.getParameter(name);

			out.print(result += name + " : " + value + "<br>");
		}

		Enumeration<?> files = upload.getFileNames();

		while (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String filename = upload.getFilesystemName(name);
			String original = upload.getOriginalFileName(name);
			String type = upload.getContentType(name);

			out.print(result += "파라미터 이름 : " + name + "<br>");
			out.print(result += "실제 파일 이름 : " + original + "<br>");
			out.print(result += "저장된 파일 이름 : " + filename + "<br>");
			out.print(result += "파일 타입 : " + type + "<br>");
		}
		result += "----------------------------------------<br>";
	} catch (Exception e) {
		e.printStackTrace();
	}
%>