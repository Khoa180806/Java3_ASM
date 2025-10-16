package com.java3.study.Lab1;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {
        "/crud/create",
        "/crud/update",
        "/crud/delete",
        "/crud/edit/*"
})
public class CrudServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/crud/create") || path.equals("/crud/update") || path.equals("/crud/delete") || path.equals("/crud/edit/*")) {
            System.out.println(request.getServletPath());
            System.out.println(request.getPathInfo());
        } else {
            System.out.println("Error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
