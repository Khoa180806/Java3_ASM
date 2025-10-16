package com.java3.study.Lab3;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet("/Format")
public class Format extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Object> map = new HashMap<>();
        map.put("name", "iPhone 2024");
        map.put("price", 12345.678);
        map.put("date", new Date());
        request.setAttribute("item", map);
        request.getRequestDispatcher("/views/Lab3/Format.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}