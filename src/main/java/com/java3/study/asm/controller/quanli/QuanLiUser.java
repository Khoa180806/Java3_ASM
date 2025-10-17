package com.java3.study.asm.controller.quanli;

import com.java3.study.asm.dao.impl.UserDaoImpl;
import com.java3.study.asm.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet xử lý CRUD người dùng cho quản lý
 * 
 * URL Mapping theo RESTful pattern:
 * - GET  /quanli/user/          → Danh sách người dùng
 * - GET  /quanli/user/new       → Form tạo người dùng mới
 * - POST /quanli/user/          → Tạo người dùng mới
 * - GET  /quanli/user/{id}      → Xem chi tiết người dùng
 * - GET  /quanli/user/{id}/edit → Form chỉnh sửa người dùng
 * - POST /quanli/user/{id}      → Cập nhật người dùng
 * - GET  /quanli/user/delete?id=xxx → Xóa người dùng (legacy)
 * 
 * Backward compatibility:
 * - GET  /quanli/user/create    → Redirect to /new
 * - GET  /quanli/user/edit?id=xxx → Form chỉnh sửa (legacy)
 * - GET  /quanli/user/view?id=xxx → Xem chi tiết (legacy)
 */
@WebServlet("/quanli/user/*")
public class QuanLiUser extends HttpServlet {
    
    private UserDaoImpl userDao;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        // Xử lý các action theo RESTful pattern
        if (pathInfo == null || pathInfo.equals("/")) {
            // GET /quanli/user/ → Danh sách người dùng
            showUserList(request, response);
        } else if (pathInfo.equals("/new")) {
            // GET /quanli/user/new → Form tạo người dùng mới
            showCreateForm(request, response);
        } else if (pathInfo.equals("/create")) {
            // Backward compatibility - redirect to /new
            response.sendRedirect(request.getContextPath() + "/quanli/user/new");
        } else if (pathInfo.equals("/edit")) {
            // GET /quanli/user/edit?id=xxx → Form chỉnh sửa người dùng
            showEditForm(request, response);
        } else if (pathInfo.equals("/delete")) {
            // GET /quanli/user/delete?id=xxx → Xóa người dùng (không khuyến khích)
            deleteUser(request, response);
        } else if (pathInfo.equals("/view")) {
            // GET /quanli/user/view?id=xxx → Xem chi tiết người dùng
            viewUserDetail(request, response);
        } else if (pathInfo.matches("/\\w+")) {
            // GET /quanli/user/{id} → Xem chi tiết người dùng theo ID
            String userId = pathInfo.substring(1); // Bỏ dấu / đầu
            request.setAttribute("userId", userId);
            viewUserDetail(request, response);
        } else if (pathInfo.matches("/\\w+/edit")) {
            // GET /quanli/user/{id}/edit → Form chỉnh sửa người dùng theo ID
            String userId = pathInfo.substring(1, pathInfo.lastIndexOf("/edit"));
            request.setAttribute("userId", userId);
            showEditForm(request, response);
        } else {
            // Trang không tồn tại
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/") || pathInfo.equals("/new") || pathInfo.equals("/create")) {
            // POST /quanli/user/ hoặc /new hoặc /create → Tạo người dùng mới
            createUser(request, response);
        } else if (pathInfo.equals("/update")) {
            // POST /quanli/user/update → Cập nhật người dùng
            updateUser(request, response);
        } else if (pathInfo.matches("/\\w+")) {
            // POST /quanli/user/{id} → Cập nhật người dùng theo ID
            updateUser(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
    
    /**
     * Hiển thị danh sách người dùng
     */
    private void showUserList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<User> userList = userDao.getAll();
            request.setAttribute("userList", userList);
            request.setAttribute("action", "list");
            request.setAttribute("pageTitle", "Quản lý người dùng");
            request.setAttribute("contextPath", "quanli/user");
            
            // Xử lý thông báo success/error
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if ("create".equals(success)) {
                request.setAttribute("successMessage", "Tạo người dùng thành công!");
            } else if ("update".equals(success)) {
                request.setAttribute("successMessage", "Cập nhật người dùng thành công!");
            } else if ("delete".equals(success)) {
                request.setAttribute("successMessage", "Xóa người dùng thành công!");
            } else if ("delete".equals(error)) {
                request.setAttribute("errorMessage", "Lỗi khi xóa người dùng!");
            }
            
            request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách người dùng: " + e.getMessage());
            request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                   .forward(request, response);
        }
    }
    
    /**
     * Hiển thị form tạo người dùng mới
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("action", "create");
        request.setAttribute("pageTitle", "Tạo người dùng mới");
        request.setAttribute("contextPath", "quanli/user");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
               .forward(request, response);
    }
    
    /**
     * Hiển thị form chỉnh sửa người dùng
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy ID từ URL path hoặc parameter
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            userId = request.getParameter("id");
        }
        
        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/user");
            return;
        }
        
        try {
            User user = userDao.getById(userId);
            
            if (user == null) {
                request.setAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + userId);
                showUserList(request, response);
                return;
            }
            
            request.setAttribute("user", user);
            request.setAttribute("action", "edit");
            request.setAttribute("pageTitle", "Chỉnh sửa người dùng");
            request.setAttribute("contextPath", "quanli/user");
            
            request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải người dùng: " + e.getMessage());
            showUserList(request, response);
        }
    }
    
    /**
     * Xem chi tiết người dùng
     */
    private void viewUserDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy ID từ URL path hoặc parameter
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            userId = request.getParameter("id");
        }
        
        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/user");
            return;
        }
        
        try {
            User user = userDao.getById(userId);
            
            if (user == null) {
                request.setAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + userId);
                showUserList(request, response);
                return;
            }
            
            request.setAttribute("user", user);
            request.setAttribute("action", "view");
            request.setAttribute("pageTitle", "Chi tiết người dùng");
            request.setAttribute("contextPath", "quanli/user");
            
            request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải người dùng: " + e.getMessage());
            showUserList(request, response);
        }
    }
    
    /**
     * Tạo người dùng mới
     */
    private void createUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            String id = request.getParameter("id");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullname");
            String birthdayStr = request.getParameter("birthday");
            String genderStr = request.getParameter("gender");
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            String roleStr = request.getParameter("role");
            
            // Validate dữ liệu
            if (id == null || id.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                fullname == null || fullname.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                request.setAttribute("action", "create");
                request.setAttribute("pageTitle", "Tạo người dùng mới");
                request.setAttribute("contextPath", "quanli/user");
                request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                       .forward(request, response);
                return;
            }
            
            // Kiểm tra ID đã tồn tại
            User existingUser = userDao.getById(id.trim());
            if (existingUser != null) {
                request.setAttribute("errorMessage", "ID người dùng đã tồn tại!");
                request.setAttribute("action", "create");
                request.setAttribute("pageTitle", "Tạo người dùng mới");
                request.setAttribute("contextPath", "quanli/user");
                request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                       .forward(request, response);
                return;
            }
            
            // Tạo đối tượng User
            User user = new User();
            user.setId(id.trim());
            user.setPassword(password.trim());
            user.setFullname(fullname.trim());
            
            // Parse birthday
            if (birthdayStr != null && !birthdayStr.trim().isEmpty()) {
                user.setBirthday(Date.valueOf(birthdayStr));
            }
            
            // Parse gender (true = Nam, false = Nữ)
            user.setGender(genderStr != null && genderStr.equals("true"));
            
            user.setMobile(mobile != null ? mobile.trim() : "");
            user.setEmail(email.trim());
            
            // Parse role (true = Admin, false = Phóng viên)
            user.setRole(roleStr != null && roleStr.equals("true"));
            
            // Lưu vào database
            userDao.insert(user);
            
            // Redirect về danh sách với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/quanli/user?success=create");
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Định dạng ngày sinh không hợp lệ! (yyyy-MM-dd)");
            request.setAttribute("action", "create");
            request.setAttribute("pageTitle", "Tạo người dùng mới");
            request.setAttribute("contextPath", "quanli/user");
            request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tạo người dùng: " + e.getMessage());
            request.setAttribute("action", "create");
            request.setAttribute("pageTitle", "Tạo người dùng mới");
            request.setAttribute("contextPath", "quanli/user");
            request.getRequestDispatcher("/views/asm/common/quanly/layoutuser.jsp")
                   .forward(request, response);
        }
    }
    
    /**
     * Cập nhật người dùng
     */
    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            String id = request.getParameter("id");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullname");
            String birthdayStr = request.getParameter("birthday");
            String genderStr = request.getParameter("gender");
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            String roleStr = request.getParameter("role");
            
            // Validate dữ liệu
            if (id == null || id.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                fullname == null || fullname.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                showEditForm(request, response);
                return;
            }
            
            // Kiểm tra người dùng có tồn tại không
            User existingUser = userDao.getById(id.trim());
            if (existingUser == null) {
                request.setAttribute("errorMessage", "Không tìm thấy người dùng để cập nhật!");
                showUserList(request, response);
                return;
            }
            
            // Cập nhật thông tin
            User user = new User();
            user.setId(id.trim());
            user.setPassword(password.trim());
            user.setFullname(fullname.trim());
            
            // Parse birthday
            if (birthdayStr != null && !birthdayStr.trim().isEmpty()) {
                user.setBirthday(Date.valueOf(birthdayStr));
            }
            
            // Parse gender (true = Nam, false = Nữ)
            user.setGender(genderStr != null && genderStr.equals("true"));
            
            user.setMobile(mobile != null ? mobile.trim() : "");
            user.setEmail(email.trim());
            
            // Parse role (true = Admin, false = Phóng viên)
            user.setRole(roleStr != null && roleStr.equals("true"));
            
            // Cập nhật trong database
            userDao.update(user);
            
            // Redirect về danh sách với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/quanli/user?success=update");
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Định dạng ngày sinh không hợp lệ! (yyyy-MM-dd)");
            showEditForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật người dùng: " + e.getMessage());
            showEditForm(request, response);
        }
    }
    
    /**
     * Xóa người dùng
     */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("id");
        
        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/user");
            return;
        }
        
        try {
            userDao.delete(userId.trim());
            response.sendRedirect(request.getContextPath() + "/quanli/user?success=delete");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/quanli/user?error=delete");
        }
    }
}
