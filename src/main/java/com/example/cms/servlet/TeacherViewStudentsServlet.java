package com.example.cms.servlet;

import com.example.cms.dao.RegistrationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="TeacherViewStudentsServlet", urlPatterns={"/teacher/course-students"})
public class TeacherViewStudentsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        RegistrationDAO dao = new RegistrationDAO();
        List<Integer> studentIds = dao.getStudentIdsByCourse(courseId);
        request.setAttribute("studentIds", studentIds);
        request.getRequestDispatcher("/teacher.jsp").forward(request, response);
    }
}
