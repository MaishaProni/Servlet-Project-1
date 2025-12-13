<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.dao.RegistrationDAO,com.example.cms.model.User,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) session.getAttribute("user");
    CourseDAO cdao = new CourseDAO();
    RegistrationDAO rdao = new RegistrationDAO();
    java.util.List<Integer> myCourses = rdao.getCourseIdsByStudent(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <span class="navbar-brand">Student</span>
    <div class="d-flex">
      <a href="logout" class="btn btn-outline-secondary">Logout</a>
    </div>
  </div>
</nav>
<div class="container py-4">
  <h4 class="mb-3">Register for a Course</h4>
  <form method="post" action="student/register" class="row g-3">
    <div class="col-md-6">
      <label class="form-label">Select Course</label>
      <select class="form-select" name="courseId">
        <% for (var c: cdao.getAll()) { %>
          <option value="<%= c.getId() %>"><%= c.getCourseName() %> (TID <%= c.getTeacherId() %>)</option>
        <% } %>
      </select>
    </div>
    <div class="col-md-2 align-self-end">
      <button class="btn btn-primary w-100">Register</button>
    </div>
  </form>
  <% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-info mt-3"><%= request.getAttribute("message") %></div>
  <% } %>
  <hr/>
  <h5>My Registered Courses</h5>
  <ul class="list-group">
  <% for (Integer id: myCourses) { %>
    <li class="list-group-item">Course ID: <%= id %></li>
  <% } %>
  </ul>
</div>
</body>
</html>
