package com.java3.study.Lab4;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.File;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet("/Upload")
@MultipartConfig
public class Upload extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/Lab4/upload.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Part photo = request.getPart("photo");
        String fileName = photo != null ? photo.getSubmittedFileName() : null;

        if (photo == null || fileName == null || fileName.isEmpty()) {
            request.setAttribute("message", "Vui lòng chọn tệp cần upload.");
            request.getRequestDispatcher("/views/Lab4/upload.jsp").forward(request, response);
            return;
        }

        String uploadDirPath = request.getServletContext().getRealPath("/static/file");
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File dest = new File(uploadDir, fileName);
        photo.write(dest.getAbsolutePath());

        String fileUrl = request.getContextPath() + "/static/file/" + fileName;
        request.setAttribute("message", "Upload thành công: " + fileUrl);
        request.setAttribute("fileUrl", fileUrl);
        request.getRequestDispatcher("/views/Lab4/upload.jsp").forward(request, response);
    }
}