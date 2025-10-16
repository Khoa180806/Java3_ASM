package com.java3.study.Lab7.servlet;

import com.java3.study.Lab7.dao.DepartmentDAO;
import com.java3.study.Lab7.dao.DepartmentDAOImpl;
import com.java3.study.Lab7.dao.EmployeeDAO;
import com.java3.study.Lab7.dao.EmployeeDAOImpl;
import com.java3.study.Lab7.entity.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

@WebServlet({
    "/employee/index",
    "/employee/edit/*",
    "/employee/create",
    "/employee/update",
    "/employee/delete/*",
    "/employee/reset"
})
public class EmployeeServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Employee form = new Employee();
        try {
            BeanUtils.populate(form, req.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
        
        EmployeeDAO empDao = new EmployeeDAOImpl();
        DepartmentDAO deptDao = new DepartmentDAOImpl();
        
        String path = req.getServletPath();
        if (path.contains("edit")) {
            String id = req.getPathInfo().substring(1);
            form = empDao.findById(id);
        } else if (path.contains("create")) {
            empDao.create(form);
            form = new Employee();
        } else if (path.contains("update")) {
            empDao.update(form);
        } else if (path.contains("delete")) {
            try {
                String id = req.getPathInfo().substring(1);
                empDao.deleteById(id);
                form = new Employee();
                req.setAttribute("message", "Xóa nhân viên thành công!");
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi khi xóa nhân viên: " + e.getMessage());
            }
        }
        
        req.setAttribute("form", form);
        req.setAttribute("items", empDao.findAll());
        req.setAttribute("departments", deptDao.findAll());
        req.getRequestDispatcher("/views/Lab7/employee.jsp").forward(req, resp);
    }
}
