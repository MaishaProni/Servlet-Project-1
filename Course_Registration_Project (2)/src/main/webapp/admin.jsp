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

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* ===== Background (same as index & student) ===== */
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #212529;
            position: relative;
            overflow-x: hidden;
        }

        /* abstract shapes */
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

        /* ===== Tables ===== */
        .table {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
        }

        .table thead {
            background: #eaf6fa;
        }

        .table th {
            font-weight: 600;
            color: #005b66;
            border-bottom: none;
        }

        .table td {
            vertical-align: middle;
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
            <i class="bi bi-shield-lock-fill me-2"></i>
            Admin Dashboard
        </span>
        <a href="logout" class="btn btn-logout">Logout</a>
    </div>
</nav>

<div class="container dashboard-container">

    <!-- Add Course Card -->
    <div class="card mb-4">
        <div class="card-header">Add Course & Assign Teacher</div>
        <div class="card-body">
            <form method="post" action="admin/add-course" class="row g-3 align-items-end">
                <div class="col-md-6">
                    <label class="form-label">Course Name</label>
                    <input class="form-control" name="courseName" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Teacher ID</label>
                    <input class="form-control" name="teacherId" type="number" required>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-primary w-100">Add</button>
                </div>
            </form>

            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-info mt-3 text-center">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Course Table -->
    <div class="card">
        <div class="card-header">All Courses</div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Course Name</th>
                        <th>Teacher ID</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Course c : dao.getAll()) { %>
                    <tr>
                        <td><%= c.getId() %></td>
                        <td><%= c.getCourseName() %></td>
                        <td><%= c.getTeacherId() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
