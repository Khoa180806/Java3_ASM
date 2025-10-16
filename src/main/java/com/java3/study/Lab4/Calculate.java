package com.java3.study.Lab4;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet({"/Calculate/add","/Calculate","/Calculate/sub"})
public class Calculate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message", "Nhập số và chọn phép tính");
        request.getRequestDispatcher("/views/Lab4/calculate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String a = request.getParameter("a");
        String b = request.getParameter("b");
        String pathInfo = request.getServletPath();

        if (pathInfo == null) {
            request.setAttribute("message", "Nhập số và chọn phép tính");
            request.getRequestDispatcher("/views/Lab4/calculate.jsp").forward(request, response);
            return;
        }
        if(pathInfo.equals("/Calculate/add")) {
            double c = Double.valueOf(a) + Double.valueOf(b);
            request.setAttribute("message", a + " + " + b + " = " + c);
        } else if (pathInfo.endsWith("/Calculate/sub")) {
            double c = Double.valueOf(a) - Double.valueOf(b);
            request.setAttribute("message", a + " - " + b + " = " + c);
        } else {
            request.setAttribute("message", "Đường dẫn không hợp lệ");
        }

        request.getRequestDispatcher("/views/Lab4/calculate.jsp").forward(request, response);
    }
}