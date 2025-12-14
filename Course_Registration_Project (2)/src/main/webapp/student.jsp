<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.dao.RegistrationDAO,com.example.cms.model.User,com.example.cms.model.Course,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    CourseDAO cdao = new CourseDAO();
    RegistrationDAO rdao = new RegistrationDAO();
    List<Integer> myCourses = rdao.getCourseIdsByStudent(user.getId());
    String message = (String) request.getAttribute("message");
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
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
        }

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

        .btn-logout:hover {
            background: rgba(255,255,255,0.15);
        }

        .dashboard-container {
            padding-top: 40px;
            padding-bottom: 60px;
            position: relative;
            z-index: 1;
        }

        .card {
            border-radius: 16px;
            background: #ffffffdd;
            border: none;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .card-header {
            background: linear-gradient(135deg, #0097a7, #00bcd4);
            color: white;
            font-weight: 600;
            font-size: 1.25rem;
            text-align: center;
        }

        .btn-primary {
            background: #0097a7;
            border: none;
        }

        .btn-primary:hover {
            background: #00bcd4;
        }

        .list-group-item {
            border-radius: 10px;
            margin-bottom: 8px;
            background: #f8fbfd;
            border: 1px solid #e1ecf2;
        }

        .badge {
            background: #bfeaf0;
            color: #005b66;
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

<!-- Main Dashboard -->
<div class="container dashboard-container">

    <!-- Register Course -->
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

<!-- ===== POPUP MODAL ===== -->
<% if (message != null) { %>
<div class="modal fade" id="resultModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">

            <div class="modal-header text-white"
                 style="background: linear-gradient(135deg, #0097a7, #00bcd4);">
                <h5 class="modal-title">Registration Status</h5>
            </div>

            <div class="modal-body text-center p-4">
                <i class="bi bi-info-circle-fill fs-1 text-info mb-3"></i>
                <p class="fs-5 mb-0"><%= message %></p>
            </div>

            <div class="modal-footer justify-content-center">
                <button class="btn btn-primary px-4" onclick="goBack()">
                    OK
                </button>
            </div>

        </div>
    </div>
</div>
<% } %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function goBack() {
    	window.location.href = "<%= request.getContextPath() %>/student.jsp";

    }

    <% if (message != null) { %>
        const modal = new bootstrap.Modal(document.getElementById("resultModal"));
        modal.show();
    <% } %>
</script>

</body>
</html>
