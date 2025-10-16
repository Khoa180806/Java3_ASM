package com.java3.study.Lab8;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet({"/home/index","/home/about","/home/contact"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("index")){
            request.setAttribute("view","/views/Lab8/home/index.jsp");
        } else if (uri.contains("about")){
            request.setAttribute("view","/views/Lab8/home/about.jsp");
        } else if (uri.contains("contact")){
            request.setAttribute("view","/views/Lab8/home/contact.jsp");
        }
        request.getRequestDispatcher("/views/Lab8/layout.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}