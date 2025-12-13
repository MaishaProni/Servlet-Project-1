<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* Professional Gradient Background */
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #f8f9fa;
            overflow-x: hidden;
            position: relative;
        }

        /* Abstract Shapes */
        body::before, body::after {
            content: "";
            position: absolute;
            border-radius: 50%;
            opacity: 0.2;
        }
        body::before {
            width: 400px; height: 400px;
            background: #00bcd4;
            top: -100px; left: -100px;
        }
        body::after {
            width: 600px; height: 600px;
            background: #ff9800;
            bottom: -150px; right: -150px;
        }

        .welcome-container {
            text-align: center;
            z-index: 1;
        }

        .btn-get-started {
            background: #00bcd4;
            border: none;
            padding: 12px 30px;
            font-size: 1.2rem;
            border-radius: 50px;
            transition: all 0.3s ease;
            color: #fff;
            font-weight: 500;
        }
        .btn-get-started:hover {
            background: #0097a7;
        }

        .login-card {
            display: none; /* hidden initially */
            margin-top: 30px;
        }

        .card {
            border-radius: 15px;
            background: #ffffffdd; /* slightly transparent white */
            color: #212529;
        }

        .card-header {
            background: linear-gradient(135deg, #0097a7, #00bcd4);
            color: white;
            font-weight: bold;
            text-align: center;
            font-size: 1.4rem;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(0, 188, 212, 0.25);
            border-color: #00bcd4;
        }

        .btn-primary {
            background: #0097a7;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: #00bcd4;
        }

        .input-group-text {
            background: #f1f1f1;
        }
    </style>
</head>
<body>
<div class="container welcome-container">
    <h1 class="mb-4">Welcome to Course Registration Portal</h1>
    <p class="lead mb-4">Your journey to learning starts here!</p>
    <button class="btn btn-get-started" id="getStartedBtn">Get Started</button>

    <!-- Login card -->
    <div class="login-card col-md-5 col-lg-4 mx-auto">
        <div class="card shadow-lg">
            <div class="card-header">Sign In</div>
            <div class="card-body">
                <form method="post" action="login">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                            <input type="text" name="username" class="form-control" placeholder="Enter username" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3">Login</button>
                </form>
                <%
                    String err = (String) request.getAttribute("error");
                    if (err != null) {
                %>
                <div class="alert alert-danger text-center"><%= err %></div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("getStartedBtn").addEventListener("click", function() {
        this.style.display = "none"; // hide button
        document.querySelector(".login-card").style.display = "block"; // show login card
        window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' }); // scroll to login card
    });
</script>
</body>
</html>
