package com.java3.study.asm.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

/**
 * LanguageServlet - Xử lý chuyển đổi ngôn ngữ cho toàn bộ ứng dụng
 * Hỗ trợ Jakarta EE và UTF-8 encoding
 * 
 * URL Pattern: /language
 * Parameters:
 * - lang: vi (Tiếng Việt) hoặc en (English)
 * - redirect: URL để redirect sau khi chuyển ngôn ngữ
 */
@WebServlet("/language")
public class LanguageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Supported languages
    private static final String VIETNAMESE = "vi";
    private static final String ENGLISH = "en";
    private static final String DEFAULT_LANGUAGE = VIETNAMESE;
    
    // Session attribute key
    private static final String LANGUAGE_SESSION_KEY = "currentLanguage";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response encoding
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Get language parameter
        String language = request.getParameter("lang");
        
        // Validate language parameter
        if (language == null || language.trim().isEmpty()) {
            language = DEFAULT_LANGUAGE;
        } else {
            language = language.trim().toLowerCase();
            // Only allow supported languages
            if (!VIETNAMESE.equals(language) && !ENGLISH.equals(language)) {
                language = DEFAULT_LANGUAGE;
            }
        }
        
        // Store language in session
        HttpSession session = request.getSession();
        session.setAttribute(LANGUAGE_SESSION_KEY, language);
        
        // Get redirect URL
        String redirectUrl = request.getParameter("redirect");
        
        // Validate and process redirect URL
        if (redirectUrl == null || redirectUrl.trim().isEmpty()) {
            // Default redirect to home page
            redirectUrl = request.getContextPath() + "/";
        } else {
            try {
                // Decode URL if it's encoded
                redirectUrl = URLDecoder.decode(redirectUrl, StandardCharsets.UTF_8);
                
                // Ensure redirect URL starts with context path for security
                if (!redirectUrl.startsWith(request.getContextPath())) {
                    redirectUrl = request.getContextPath() + redirectUrl;
                }
            } catch (Exception e) {
                // If redirect URL is invalid, redirect to home
                redirectUrl = request.getContextPath() + "/";
            }
        }
        
        // Add success message to session (optional)
        String successMessage = VIETNAMESE.equals(language) 
            ? "Chuyển đổi ngôn ngữ thành công" 
            : "Language switched successfully";
        session.setAttribute("languageMessage", successMessage);
        
        // Redirect to the specified URL
        response.sendRedirect(redirectUrl);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Support POST method as well
        doGet(request, response);
    }
    
    /**
     * Utility method to get current language from session
     * @param request HttpServletRequest
     * @return current language code (vi or en)
     */
    public static String getCurrentLanguage(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String language = (String) session.getAttribute(LANGUAGE_SESSION_KEY);
            if (language != null && (VIETNAMESE.equals(language) || ENGLISH.equals(language))) {
                return language;
            }
        }
        return DEFAULT_LANGUAGE;
    }
    
    /**
     * Utility method to check if current language is Vietnamese
     * @param request HttpServletRequest
     * @return true if Vietnamese, false otherwise
     */
    public static boolean isVietnamese(HttpServletRequest request) {
        return VIETNAMESE.equals(getCurrentLanguage(request));
    }
    
    /**
     * Utility method to check if current language is English
     * @param request HttpServletRequest
     * @return true if English, false otherwise
     */
    public static boolean isEnglish(HttpServletRequest request) {
        return ENGLISH.equals(getCurrentLanguage(request));
    }
}
