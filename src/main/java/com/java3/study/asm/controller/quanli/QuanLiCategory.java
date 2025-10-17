package com.java3.study.asm.controller.quanli;

import com.java3.study.asm.dao.impl.CategoryDaoImpl;
import com.java3.study.asm.entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/quanli/category/*")
public class QuanLiCategory extends HttpServlet {
    
    private CategoryDaoImpl categoryDao;
    
    @Override
    public void init() throws ServletException {
        categoryDao = new CategoryDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = "list";
        String categoryId = null;
        
        // Parse URL path để xác định action
        if (pathInfo != null && !pathInfo.equals("/")) {
            String[] pathParts = pathInfo.split("/");
            if (pathParts.length > 1) {
                String firstPart = pathParts[1];
                
                // Kiểm tra nếu là action (new, edit) hay ID
                if ("new".equals(firstPart)) {
                    action = "new";
                } else if ("edit".equals(firstPart)) {
                    action = "edit";
                    categoryId = request.getParameter("id");
                } else if ("view".equals(firstPart)) {
                    action = "view";
                    categoryId = request.getParameter("id");
                } else if ("delete".equals(firstPart)) {
                    action = "delete";
                    categoryId = request.getParameter("id");
                } else if ("create".equals(firstPart)) {
                    // Redirect /create to /new for consistency
                    response.sendRedirect(request.getContextPath() + "/quanli/category/new");
                    return;
                } else if (firstPart.matches("\\w+")) {
                    // Nếu là ID (chỉ chứa chữ và số)
                    categoryId = firstPart;
                    if (pathParts.length > 2 && "edit".equals(pathParts[2])) {
                        action = "edit";
                    } else {
                        action = "view";
                    }
                }
            }
        }
        
        // Xử lý các action
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response, categoryId);
                    break;
                case "view":
                    showViewForm(request, response, categoryId);
                    break;
                case "delete":
                    deleteCategory(request, response, categoryId);
                    break;
                default:
                    listCategories(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            listCategories(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null) {
                if (pathInfo.equals("/new") || pathInfo.equals("/create")) {
                    createCategory(request, response);
                } else if (pathInfo.equals("/update")) {
                    updateCategory(request, response);
                } else if (pathInfo.matches("/\\w+")) {
                    // POST to /{id} means update
                    updateCategory(request, response);
                } else {
                    // Default POST action is create
                    createCategory(request, response);
                }
            } else {
                createCategory(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            listCategories(request, response);
        }
    }
    
    private void listCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Category> categories = categoryDao.selectAll();
        request.setAttribute("categories", categories);
        request.setAttribute("action", "list");
        request.setAttribute("pageTitle", "Quản lý Danh mục");
        request.setAttribute("contextPath", "quanli/category");
        request.setAttribute("active", "category");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutcategory.jsp")
                .forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("action", "new");
        request.setAttribute("pageTitle", "Thêm Danh mục mới");
        request.setAttribute("contextPath", "quanli/category");
        request.setAttribute("active", "category");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutcategory.jsp")
                .forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, String categoryId) 
            throws ServletException, IOException {
        
        if (categoryId == null || categoryId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/category?error=invalid_id");
            return;
        }
        
        Category category = categoryDao.selectById(categoryId);
        if (category == null) {
            response.sendRedirect(request.getContextPath() + "/quanli/category?error=not_found");
            return;
        }
        
        request.setAttribute("category", category);
        request.setAttribute("action", "edit");
        request.setAttribute("pageTitle", "Chỉnh sửa Danh mục");
        request.setAttribute("contextPath", "quanli/category");
        request.setAttribute("active", "category");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutcategory.jsp")
                .forward(request, response);
    }
    
    private void showViewForm(HttpServletRequest request, HttpServletResponse response, String categoryId) 
            throws ServletException, IOException {
        
        if (categoryId == null || categoryId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/category?error=invalid_id");
            return;
        }
        
        Category category = categoryDao.selectById(categoryId);
        if (category == null) {
            response.sendRedirect(request.getContextPath() + "/quanli/category?error=not_found");
            return;
        }
        
        request.setAttribute("category", category);
        request.setAttribute("action", "view");
        request.setAttribute("pageTitle", "Chi tiết Danh mục");
        request.setAttribute("contextPath", "quanli/category");
        request.setAttribute("active", "category");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutcategory.jsp")
                .forward(request, response);
    }
    
    private void createCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("categoryId");
        String name = request.getParameter("categoryName");
        
        // Validation
        if (id == null || id.trim().isEmpty() || name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            request.setAttribute("action", "new");
            request.setAttribute("pageTitle", "Thêm Danh mục mới");
            request.setAttribute("contextPath", "quanli/category");
            request.setAttribute("active", "category");
            request.getRequestDispatcher("/views/asm/common/quanly/layoutcategory.jsp")
                    .forward(request, response);
            return;
        }
        
        // Kiểm tra ID đã tồn tại
        Category existingCategory = categoryDao.selectById(id.trim());
        if (existingCategory != null) {
            request.setAttribute("errorMessage", "ID danh mục đã tồn tại!");
            request.setAttribute("action", "new");
            request.setAttribute("pageTitle", "Thêm Danh mục mới");
            request.setAttribute("contextPath", "quanli/category");
            request.setAttribute("active", "category");
            request.getRequestDispatcher("/views/asm/common/quanly/layoutcategory.jsp")
                    .forward(request, response);
            return;
        }
        
        Category category = new Category();
        category.setId(id.trim());
        category.setName(name.trim());
        
        categoryDao.insert(category);
        
        response.sendRedirect(request.getContextPath() + "/quanli/category?success=create");
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("categoryId");
        String name = request.getParameter("categoryName");
        
        // Validation
        if (id == null || id.trim().isEmpty() || name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            showEditForm(request, response, id);
            return;
        }
        
        Category category = new Category();
        category.setId(id.trim());
        category.setName(name.trim());
        
        categoryDao.update(category);
        
        response.sendRedirect(request.getContextPath() + "/quanli/category?success=update");
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response, String categoryId) 
            throws ServletException, IOException {
        
        if (categoryId == null || categoryId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/category?error=invalid_id");
            return;
        }
        
        try {
            categoryDao.delete(categoryId);
            response.sendRedirect(request.getContextPath() + "/quanli/category?success=delete");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/quanli/category?error=delete");
        }
    }
}
