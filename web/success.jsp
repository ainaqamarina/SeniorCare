<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Operation Result</title>
</head>
<body>
    <h2>Result</h2>
    <p>
        <%= request.getAttribute("message") != null ? request.getAttribute("message") : "No message available." %>
    </p>
    <a href="addRoomPackage.jsp">Go back to add another room package</a>
</body>
</html>