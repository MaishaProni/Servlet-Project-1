<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.model.Course,com.example.cms.model.User,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) session.getAttribute("user");
    CourseDAO dao = new CourseDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <span class="navbar-brand">Admin</span>
    <div class="d-flex">
      <a href="logout" class="btn btn-outline-secondary">Logout</a>
    </div>
  </div>
</nav>
<div class="container py-4">
  <h4 class="mb-3">Add Course and Assign Teacher</h4>
  <form method="post" action="admin/add-course" class="row g-3">
    <div class="col-md-6">
      <label class="form-label">Course Name</label>
      <input class="form-control" name="courseName" required>
    </div>
    <div class="col-md-4">
      <label class="form-label">Teacher ID</label>
      <input class="form-control" name="teacherId" type="number" required>
    </div>
    <div class="col-md-2 align-self-end">
      <button class="btn btn-primary w-100">Add</button>
    </div>
  </form>

  <% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-info mt-3"><%= request.getAttribute("message") %></div>
  <% } %>

  <hr/>
  <h5>All Courses</h5>
  <table class="table table-striped">
    <thead>
      <tr><th>ID</th><th>Name</th><th>Teacher ID</th></tr>
    </thead>
    <tbody>
    <%
      for (Course c : dao.getAll()) {
    %>
      <tr>
          <td><%= c.getId() %></td>
          <td><%= c.getCourseName() %></td>
          <td><%= c.getTeacherId() %></td>
      </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>
