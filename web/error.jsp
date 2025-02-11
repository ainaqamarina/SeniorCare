<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h2>Error Occurred</h2>
    <p><%= request.getAttribute("errorMessage") %></p>
    <a href="RoomAdmin.jsp">Go Back</a>
</body>
</html>