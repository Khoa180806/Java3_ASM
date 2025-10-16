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
@WebServlet("/Dangky")
public class Dangky extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/Lab4/dangky.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String married = request.getParameter("married");
        String country = request.getParameter("country");
        String note = request.getParameter("note");
        String[] hobbies = request.getParameterValues("hobby");

        System.out.println("==== FORM DANG KY ====");
        System.out.println("username: " + username);
        System.out.println("password: " + password);
        System.out.println("gender: " + gender);
        System.out.println("married: " + (married != null));
        System.out.println("country: " + country);
        if (hobbies != null) {
            System.out.println("hobbies: ");
            for (String h : hobbies) {
                System.out.println(" - " + h);
            }
        } else {
            System.out.println("hobbies: none");
        }
        System.out.println("note: " + note);

        request.setAttribute("message", "Gửi thành công! Kiểm tra console để xem dữ liệu.");
        request.getRequestDispatcher("/views/Lab4/dangky.jsp").forward(request, response);
    }
}