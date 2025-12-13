<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.dao.RegistrationDAO,com.example.cms.model.User,com.example.cms.model.Course,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) session.getAttribute("user");
    CourseDAO cdao = new CourseDAO();
    RegistrationDAO rdao = new RegistrationDAO();
    List<Integer> myCourses = rdao.getCourseIdsByStudent(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* ===== Background (same family as index) ===== */
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #212529;
            position: relative;
            overflow-x: hidden;
        }

        /* soft abstract shapes like index */
        body::before,
        body::after {
            content: "";
            position: absolute;
            border-radius: 50%;
            opacity: 0.15;
        }

        body::before {
            width: 420px;
            height: 420px;
            background: #00bcd4;
            top: -120px;
            left: -120px;
        }

        body::after {
            width: 600px;
            height: 600px;
            background: #ffffff;
            bottom: -200px;
            right: -200px;
        }

        /* ===== Navbar ===== */
        .navbar {
            background: linear-gradient(135deg, #0097a7, #00bcd4);
        }

        .navbar-brand {
            font-weight: 600;
            color: #fff !important;
        }

        .btn-logout {
            border: 1px solid rgba(255,255,255,0.6);
            color: #fff;
        }

        .btn-logout:hover {
            background: rgba(255,255,255,0.15);
        }

        /* ===== Layout ===== */
        .dashboard-container {
            padding-top: 40px;
            padding-bottom: 60px;
            position: relative;
            z-index: 1;
        }

        /* ===== Cards ===== */
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
            font-size: 1.25rem;
            text-align: center;
            border-top-left-radius: 16px;
            border-top-right-radius: 16px;
        }

        /* ===== Buttons ===== */
        .btn-primary {
            background: #0097a7;
            border: none;
            font-weight: 500;
        }

        .btn-primary:hover {
            background: #00bcd4;
        }

        /* ===== List ===== */
        .list-group-item {
            border-radius: 10px;
            margin-bottom: 8px;
            background: #f8fbfd;
            border: 1px solid #e1ecf2;
        }

        .badge {
            background: #bfeaf0;
            color: #005b66;
            font-weight: 500;
        }

        /* ===== Alerts ===== */
        .alert-info {
            background: #eaf6fa;
            color: #005b66;
            border: none;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <span class="navbar-brand">
            <i class="bi bi-mortarboard-fill me-2"></i>
            Welcome, <%= user.getUsername() %>
        </span>
        <a href="logout" class="btn btn-logout">Logout</a>
    </div>
</nav>

<!-- Dashboard -->
<div class="container dashboard-container">

    <!-- Register Card -->
    <div class="card mb-4">
        <div class="card-header">Register for a Course</div>
        <div class="card-body">
            <form method="post" action="student/register" class="row g-3 align-items-end">
                <div class="col-md-8">
                    <label class="form-label">Select Course</label>
                    <select class="form-select" name="courseId" required>
                        <% for (Course c : cdao.getAll()) { %>
                            <option value="<%= c.getId() %>">
                                <%= c.getCourseName() %> (Teacher ID: <%= c.getTeacherId() %>)
                            </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-primary w-100">Register</button>
                </div>
            </form>

            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-info mt-3 text-center">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
        </div>
    </div>

    <!-- My Courses -->
    <div class="card">
        <div class="card-header">My Registered Courses</div>
        <div class="card-body">
            <ul class="list-group">
                <% for (Integer id : myCourses) {
                       Course c = cdao.getById(id);
                       if (c != null) { %>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>
                            <strong><%= c.getCourseName() %></strong><br>
                            <small class="text-muted">Course ID: <%= id %></small>
                        </span>
                        <span class="badge">TID: <%= c.getTeacherId() %></span>
                    </li>
                <% }} %>
            </ul>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
