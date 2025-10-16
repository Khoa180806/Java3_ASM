package com.java3.study.Lab1;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import static java.lang.System.out;

@WebServlet("/url-info")
public class UrlInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        out.println("UriInfoServlet: " + request.getRequestURI());
        out.println("QueryStringServlet: " + request.getQueryString());
        out.println("ServletInfoServlet: " + request.getServletPath());
        out.println("ContextPathServlet: " + request.getContextPath());
        out.println("PathInfoServlet: " + request.getPathInfo());
        out.println("MethodInfoServlet: " + request.getMethod());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
