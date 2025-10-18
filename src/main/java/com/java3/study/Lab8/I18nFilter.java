package com.java3.study.Lab8;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// @WebFilter("/*") // Disabled - using new LanguageFilter in ASM package
public class I18nFilter extends HttpFilter {
    @Override
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        String lang = request.getParameter("lang");
        if (lang != null){
            request.getSession().setAttribute("lang",lang);
        }
        chain.doFilter(request,response);
    }
}
