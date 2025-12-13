<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.model.Course,com.example.cms.model.User,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) session.getAttribute("user");
    CourseDAO dao = new CourseDAO();
    List<Course> courses = dao.getByTeacher(user.getId());
    request.setAttribute("courses", courses);
    List<Integer> studentIds = (List<Integer>) request.getAttribute("studentIds");
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
        /* ===== Background ===== */
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
        }

        body::before, body::after {
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

        /* ===== Course List ===== */
        .list-group-item {
            border-radius: 10px;
            margin-bottom: 10px;
            border: 1px solid #cfeef4;
            transition: transform 0.2s, background 0.2s;
        }

        .list-group-item:hover {
            transform: translateY(-2px);
            background: #eaf6fa;
        }

        /* ===== Buttons ===== */
        .btn-outline-primary {
            border-color: #00bcd4;
            color: #0097a7;
        }

        .btn-outline-primary:hover {
            background: #00bcd4;
            color: #fff;
        }

        /* ===== Student List ===== */
        .student-card {
            margin-top: 30px;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <span class="navbar-brand">
            <i class="bi bi-mortarboard-fill me-2"></i>
            Teacher Dashboard
        </span>
        <a href="logout" class="btn btn-logout">Logout</a>
    </div>
</nav>

<div class="container dashboard-container">

    <!-- Courses -->
    <div class="card mb-4">
        <div class="card-header">Your Courses</div>
        <div class="card-body">
            <ul class="list-group">
                <c:forEach var="c" items="${courses}">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>
                            <strong>${c.courseName}</strong>
                            <small class="text-muted">(ID ${c.id})</small>
                        </span>
                        <a class="btn btn-sm btn-outline-primary"
                           href="teacher/course-students?courseId=${c.id}">
                            View Students
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- Students -->
    <c:if test="${not empty studentIds}">
        <div class="card student-card">
            <div class="card-header">Registered Students</div>
            <div class="card-body">
                <ul class="list-group">
                    <c:forEach var="sid" items="${studentIds}">
                        <li class="list-group-item">
                            <i class="bi bi-person-circle me-2"></i>
                            Student ID: <strong>${sid}</strong>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
