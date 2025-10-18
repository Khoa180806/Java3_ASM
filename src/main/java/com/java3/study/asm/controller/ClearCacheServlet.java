package com.java3.study.asm.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java3.study.asm.utils.I18nUtils;

import java.io.IOException;

/**
 * Servlet to clear i18n cache for testing UTF-8 encoding fix
 */
@WebServlet("/clear-cache")
public class ClearCacheServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Clear i18n cache
        I18nUtils.clearCache();
        
        // Set response
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html>");
        response.getWriter().println("<head><meta charset='UTF-8'><title>Cache Cleared</title></head>");
        response.getWriter().println("<body>");
        response.getWriter().println("<h2>✅ I18n Cache Cleared Successfully!</h2>");
        response.getWriter().println("<p>Properties files will be reloaded with UTF-8 encoding.</p>");
        response.getWriter().println("<a href='" + request.getContextPath() + "/i18n-demo'>Test I18n Demo</a>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}
