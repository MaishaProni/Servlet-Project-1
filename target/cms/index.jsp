<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>CMS Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="mb-3 text-center">Sign in</h3>
                    <form method="post" action="login">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form>
                    <%
                        String err = (String) request.getAttribute("error");
                        if (err != null) {
                    %>
                    <div class="alert alert-danger mt-3"><%= err %></div>
                    <% } %>
                    <div class="mt-3 small text-muted">Try sample users from schema.sql</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
