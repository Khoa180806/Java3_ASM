package com.java3.study.Lab2;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet("/form/update")
public class FormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setFullname("Phan Khoa");
        user.setGender(true);
        user.setCountry("VN");
        request.setAttribute("user",user);
        request.setAttribute("editable",true);
        request.getRequestDispatcher("/views/Lab2/form.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname=request.getParameter("fullname");
        System.out.println("fullname: " + fullname);
        request.getRequestDispatcher("/views/Lab2/form.jsp").forward(request,response);
    }
}