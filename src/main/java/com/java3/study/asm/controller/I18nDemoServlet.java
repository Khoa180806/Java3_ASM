package com.java3.study.asm.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java3.study.asm.utils.I18nUtils;

import java.io.IOException;

/**
 * I18nDemoServlet - Demo servlet để test hệ thống i18n
 * Hiển thị cách sử dụng I18nUtils trong servlet
 * 
 * URL: /i18n-demo
 */
@WebServlet("/i18n-demo")
public class I18nDemoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set character encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get current language
        String currentLanguage = LanguageServlet.getCurrentLanguage(request);
        
        // Example: Get messages using I18nUtils
        String welcomeMessage = I18nUtils.getMessage(request, "header.welcome");
        String appName = I18nUtils.getMessage(request, "app.name");
        String appSlogan = I18nUtils.getMessage(request, "app.slogan");
        
        // Example: Get messages with parameters (if you have parameterized messages)
        // String userMessage = I18nUtils.getMessage(request, "user.welcome.message", "John Doe");
        
        // Set attributes for JSP
        request.setAttribute("demoWelcomeMessage", welcomeMessage);
        request.setAttribute("demoAppName", appName);
        request.setAttribute("demoAppSlogan", appSlogan);
        request.setAttribute("demoCurrentLanguage", currentLanguage);
        
        // Example: Conditional logic based on language
        if (LanguageServlet.isVietnamese(request)) {
            request.setAttribute("demoSpecialMessage", "Chào mừng bạn đến với demo i18n!");
        } else {
            request.setAttribute("demoSpecialMessage", "Welcome to the i18n demo!");
        }
        
        // Set original servlet URL for language switcher
        request.setAttribute("originalUrl", request.getContextPath() + "/i18n-demo");
        
        // Forward to JSP
        request.getRequestDispatcher("/views/asm/i18n-demo.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
