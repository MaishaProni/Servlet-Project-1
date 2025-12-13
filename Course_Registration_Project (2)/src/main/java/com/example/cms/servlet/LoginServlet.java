package com.example.cms.servlet;

import com.example.cms.dao.UserDAO;
import com.example.cms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/admin.jsp");
                    break;
                case "teacher":
                    response.sendRedirect(request.getContextPath() + "/teacher.jsp");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/student.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
