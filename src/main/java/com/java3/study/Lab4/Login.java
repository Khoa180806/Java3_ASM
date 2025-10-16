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
@WebServlet("/account/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message", "Enter username and password");
        request.getRequestDispatcher("/views/Lab4/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username.equals("FPT") &&  password.equals("poly")){
            request.setAttribute("message", "Login successful");
        } else {
            request.setAttribute("message", "Invalid username or password");
        }
        request.getRequestDispatcher("/views/Lab4/login.jsp").forward(request,response);
    }
}