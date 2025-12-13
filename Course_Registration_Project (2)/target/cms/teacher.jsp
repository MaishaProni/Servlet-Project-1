<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.model.User,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) session.getAttribute("user");
    CourseDAO dao = new CourseDAO();
    List<com.example.cms.model.Course> my = dao.getByTeacher(user.getId());
    java.util.List<Integer> studentIds = (java.util.List<Integer>) request.getAttribute("studentIds");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <span class="navbar-brand">Teacher</span>
    <div class="d-flex">
      <a href="logout" class="btn btn-outline-secondary">Logout</a>
    </div>
  </div>
</nav>
<div class="container py-4">
  <h4>Your Courses</h4>
  <ul class="list-group mb-4">
  <% for (var c : my) { %>
    <li class="list-group-item d-flex justify-content-between align-items-center">
      <span><strong><%= c.getCourseName() %></strong> (ID <%= c.getId() %>)</span>
      <a class="btn btn-sm btn-outline-primary" href="teacher/course-students?courseId=<%= c.getId() %>">View Students</a>
    </li>
  <% } %>
  </ul>

  <% if (studentIds != null) { %>
    <h5>Registered Student IDs</h5>
    <ul class="list-group">
      <% for (Integer sid: studentIds) { %>
        <li class="list-group-item">Student ID: <%= sid %></li>
      <% } %>
    </ul>
  <% } %>
</div>
</body>
</html>
