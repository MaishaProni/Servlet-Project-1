<%@ page import="com.example.cms.dao.CourseDAO,com.example.cms.dao.UserDAO,com.example.cms.model.Course,com.example.cms.model.User,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    CourseDAO dao = new CourseDAO();
    UserDAO userDAO = new UserDAO();
    List<Integer> teacherIds = userDAO.getAllIdsByRole("teacher");
    String message = (String) request.getAttribute("message");
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

        .table {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
        }

        .table thead {
            background: #eaf6fa;
        }

        .table th {
            color: #005b66;
            font-weight: 600;
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

    <!-- Add Course -->
    <div class="card mb-4">
        <div class="card-header">Add Course & Assign Teacher</div>
        <div class="card-body">
            <form method="post" action="admin/add-course" class="row g-3 align-items-end">
                <div class="col-md-6">
                    <label class="form-label">Course Name</label>
                    <input class="form-control" name="courseName" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Teacher</label>
                    <select class="form-control" name="teacherId" required>
                        <option value="">-- Select Teacher --</option>
                        <% for (Integer id : teacherIds) { 
                               String teacherName = userDAO.getNameById(id); %>
                            <option value="<%= id %>"><%= id %> - <%= teacherName %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-primary w-100">Add</button>
                </div>
            </form>
        </div>
    </div>

    <!-- All Courses -->
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

<!-- ===== POPUP MODAL ===== -->
<div class="modal fade" id="resultModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">

            <div class="modal-header text-white"
                 style="background: linear-gradient(135deg, #0097a7, #00bcd4);">
                <h5 class="modal-title">Course Status</h5>
            </div>

            <div class="modal-body text-center p-4">
                <i class="bi bi-info-circle-fill fs-1 text-info mb-3"></i>
                <p class="fs-5 mb-0"><%= message %></p>
            </div>

            <div class="modal-footer justify-content-center">
                <button class="btn btn-primary px-4" onclick="goBack()">OK</button>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function goBack() {
        window.location.href = "<%= request.getContextPath() %>/admin.jsp";
    }

    <% if (message != null) { %>
        // Explicitly create and show the modal
        var resultModal = new bootstrap.Modal(document.getElementById('resultModal'), {});
        resultModal.show();
    <% } %>
</script>

</body>
</html>
