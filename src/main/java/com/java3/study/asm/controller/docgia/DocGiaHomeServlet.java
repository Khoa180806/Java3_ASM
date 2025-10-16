package com.java3.study.asm.controller.docgia;

import com.java3.study.asm.dao.CategoryDao;
import com.java3.study.asm.dao.impl.CategoryDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/docgia"})
public class DocGiaHomeServlet extends HttpServlet {
    
    private final CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách danh mục
        var categories = categoryDao.selectAll();
        
        // Đặt danh sách vào request attribute
        request.setAttribute("categories", categories);
        
        // Forward tới trang JSP
        request.getRequestDispatcher("/views/asm/docgiahome.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}