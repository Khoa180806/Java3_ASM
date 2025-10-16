package com.java3.study.Lab2;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet("/user")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message","Welcome");
        Map<String,Object> map=new HashMap<>();
        map.put("fullname","Khoa");
        map.put("gender","female");
        map.put("country","Vietnam");
        request.setAttribute("user",map);
        request.getRequestDispatcher("/views/Lab2/page.jsp").forward(request,response);
    }
}