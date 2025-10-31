package com.example.cms.servlet;

import com.example.cms.dao.CourseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name="AdminAddCourseServlet", urlPatterns={"/admin/add-course"})
public class AdminAddCourseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("courseName");
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));

        CourseDAO dao = new CourseDAO();
        boolean ok = dao.addCourse(name, teacherId);
        request.setAttribute("message", ok ? "Course added" : "Failed to add course");
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}
