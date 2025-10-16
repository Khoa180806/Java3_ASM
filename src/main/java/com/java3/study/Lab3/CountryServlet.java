package com.java3.study.Lab3;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet("/CountryServlet")
public class CountryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Country> listCountry = new ArrayList<>();
        listCountry.add(new Country("VN","VietNam"));
        listCountry.add(new Country("US","United States"));
        listCountry.add(new Country("CN","China"));
        request.setAttribute("countries",listCountry);
        request.getRequestDispatcher("/views/Lab3/Country.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}