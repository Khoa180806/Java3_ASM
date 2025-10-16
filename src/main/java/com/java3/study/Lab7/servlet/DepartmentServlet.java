package com.java3.study.Lab7.servlet;

import com.java3.study.Lab7.dao.DepartmentDAO;
import com.java3.study.Lab7.dao.DepartmentDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet({
        "/department/index",
        "/department/edit/*",
        "/department/create",
        "/department/update",
        "/department/delete",
        "/department/reset"
        })
public class DepartmentServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws
            ServletException, IOException {
        com.java3.study.Lab7.entity.Department form = new com.java3.study.Lab7.entity.Department();
        try {
            BeanUtils.populate(form, req.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
        DepartmentDAO dao = new DepartmentDAOImpl();
        String path = req.getServletPath();
        if (path.contains("edit")) {
            String id = req.getPathInfo().substring(1);
            form = dao.findById(id);
        } else if (path.contains("create")) {
            dao.create(form);
            form = new com.java3.study.Lab7.entity.Department();
        } else if (path.contains("update")) {
            dao.update(form);
        } else if (path.contains("delete")) {
            dao.deleteById(form.getId());
            form = new com.java3.study.Lab7.entity.Department();
        } else {
            form = new com.java3.study.Lab7.entity.Department();
        }
        req.setAttribute("item", form);
        List<com.java3.study.Lab7.entity.Department> list = dao.findAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/views/Lab7/department.jsp").forward(req, resp);
    }
}