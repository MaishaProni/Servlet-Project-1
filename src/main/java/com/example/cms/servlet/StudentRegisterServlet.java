package com.example.cms.servlet;

import com.example.cms.dao.RegistrationDAO;
import com.example.cms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name="StudentRegisterServlet", urlPatterns={"/student/register"})
public class StudentRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        User user = (User) request.getSession().getAttribute("user");

        RegistrationDAO dao = new RegistrationDAO();
        boolean ok = dao.register(user.getId(), courseId);
        request.setAttribute("message", ok ? "Registered!" : "Registration failed");
        request.getRequestDispatcher("/student.jsp").forward(request, response);
    }
}
