<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.cms.dao.CourseDAO,
                 com.example.cms.dao.RegistrationDAO,
                 com.example.cms.model.Course,
                 com.example.cms.model.User,
                 java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    CourseDAO cdao = new CourseDAO();
    RegistrationDAO rdao = new RegistrationDAO();

    List<Course> courses = cdao.getByTeacher(user.getId());
    request.setAttribute("courses", courses);

    String selectedCourseId = request.getParameter("courseId");
    List<Integer> studentIds = null;

    if (selectedCourseId != null) {
        studentIds = rdao.getStudentIdsByCourse(Integer.parseInt(selectedCourseId));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        .navbar {
            background: linear-gradient(135deg, #0097a7, #00bcd4);
        }

        .navbar-brand {
            color: #fff !important;
            font-weight: 600;
        }

        .btn-logout {
            border: 1px solid rgba(255,255,255,0.6);
            color: #fff;
        }

        .dashboard-container {
            padding-top: 40px;
            padding-bottom: 60px;
        }

        .card {
            border-radius: 16px;
            background: #ffffffdd;
            border: none;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .card-header {
            background: linear-gradient(135deg, #0097a7, #00bcd4);
            color: #fff;
            font-weight: 600;
            text-align: center;
            font-size: 1.2rem;
        }

        .list-group-item {
            border-radius: 10px;
            margin-bottom: 12px;
            border: 1px solid #cfeef4;
        }

        .student-item {
            background: #f8fbfd;
            border: 1px solid #e1ecf2;
            margin-top: 6px;
            border-radius: 8px;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <span class="navbar-brand">
            <i class="bi bi-person-workspace me-2"></i>
            Teacher Dashboard
        </span>
        <a href="logout" class="btn btn-logout">Logout</a>
    </div>
</nav>

<!-- CONTENT -->
<div class="container dashboard-container">

    <div class="card">
        <div class="card-header">Your Courses</div>
        <div class="card-body">

            <ul class="list-group">

                <% for (Course c : courses) { %>
                <li class="list-group-item">

                    <!-- COURSE HEADER -->
                    <div class="d-flex justify-content-between align-items-center">
                        <span>
                            <strong><%= c.getCourseName() %></strong>
                            <small class="text-muted">(ID <%= c.getId() %>)</small>
                        </span>

                        <a class="btn btn-sm btn-outline-primary"
                           href="teacher.jsp?courseId=<%= c.getId() %>">
                            View Students
                        </a>
                    </div>

                    <!-- STUDENTS SECTION -->
                    <%
                        if (selectedCourseId != null &&
                            selectedCourseId.equals(String.valueOf(c.getId()))) {
                    %>

                        <div class="mt-3">
                            <strong>Registered Students</strong>

                            <% if (studentIds != null && !studentIds.isEmpty()) { %>
                                <ul class="list-group mt-2">
                                    <% for (Integer sid : studentIds) { %>
                                        <li class="list-group-item student-item">
                                            <i class="bi bi-person-circle me-2"></i>
                                            Student ID: <strong><%= sid %></strong>
                                        </li>
                                    <% } %>
                                </ul>
                            <% } else { %>
                                <div class="text-muted mt-2">No students registered.</div>
                            <% } %>
                        </div>

                    <% } %>

                </li>
                <% } %>

            </ul>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
