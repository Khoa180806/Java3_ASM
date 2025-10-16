package com.java3.study.Lab5;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64;
import java.io.IOException;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet(name = "Login", value = "/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        if(cookies != null) {
            for(Cookie cookie: cookies) {
                if(cookie.getName().equals("user")) {
                    String encoded = cookie.getValue();
                    byte[] bytes = Base64.decodeBase64(encoded);
                    String[] userInfo = new String(bytes).split(",");
                    request.setAttribute("username", userInfo[0]);
                    request.setAttribute("password", userInfo[1]);
                }
            }
        }
        request.getRequestDispatcher("/views/Lab5/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember-me");
        if(username.equalsIgnoreCase("FPT") && password.equals("poly")) {
            request.setAttribute("message", "Login successfully!");
            request.getSession().setAttribute("username", username); // session

            if(remember != null) {
                byte[] bytes = (username+","+password).getBytes();
                String userInfo =Base64.encodeBase64String(bytes);
                Cookie cookie = new Cookie("user", userInfo);
                cookie.setMaxAge(30*24*60*60); // hiệu lực 30 ngày
                cookie.setPath("/"); // hiệu lực toàn ứng dụng
                // Gửi về trình duyệt
                response.addCookie(cookie); // cookie
            }
        } else {
            request.setAttribute("message", "Invalid login info!");
        }
    }
}