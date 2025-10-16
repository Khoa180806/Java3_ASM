package com.java3.study.Lab7.dao;

import com.java3.study.Lab7.entity.Employee;
import com.java3.study.Lab7.utils.Jdbc;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAOImpl implements EmployeeDAO {
    @Override
    public List<Employee> findAll() {
        String sql = "SELECT * FROM Employees";
        try {
            List<Employee> entities = new ArrayList<>();
            Object[] values = {};
            ResultSet resultSet = Jdbc.executeQuery(sql, values);
            while (resultSet.next()) {
                Employee entity = mapResultSetToEmployee(resultSet);
                entities.add(entity);
            }
            return entities;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Employee findById(String id) {
        String sql = "SELECT * FROM Employees WHERE Id=?";
        try {
            Object[] values = { id };
            ResultSet resultSet = Jdbc.executeQuery(sql, values);
            if (resultSet.next()) {
                return mapResultSetToEmployee(resultSet);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        throw new RuntimeException("Employee not found with id: " + id);
    }

    @Override
    public void create(Employee entity) {
        String sql = "INSERT INTO Employees(Id, Password, Fullname, Photo, Gender, Birthday, Salary, DepartmentId) " +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Object[] values = {
                entity.getId(),
                entity.getPassword(),
                entity.getFullname(),
                entity.getPhoto(),
                entity.getGender(),
                entity.getBirthday(),
                entity.getSalary(),
                entity.getDepartmentId()
            };
            Jdbc.executeUpdate(sql, values);
        } catch (Exception e) {
            throw new RuntimeException("Error creating employee: " + e.getMessage(), e);
        }
    }

    @Override
    public void update(Employee entity) {
        String sql = "UPDATE Employees SET Password=?, Fullname=?, Photo=?, " +
                    "Gender=?, Birthday=?, Salary=?, DepartmentId=? WHERE Id=?";
        try {
            Object[] values = {
                entity.getPassword(),
                entity.getFullname(),
                entity.getPhoto(),
                entity.getGender(),
                entity.getBirthday(),
                entity.getSalary(),
                entity.getDepartmentId(),
                entity.getId()
            };
            Jdbc.executeUpdate(sql, values);
        } catch (Exception e) {
            throw new RuntimeException("Error updating employee: " + e.getMessage(), e);
        }
    }

    @Override
    public void deleteById(String id) {
        String sql = "DELETE FROM Employees WHERE Id=?";
        try {
            Object[] values = { id };
            Jdbc.executeUpdate(sql, values);
        } catch (Exception e) {
            throw new RuntimeException("Error deleting employee: " + e.getMessage(), e);
        }
    }

    private Employee mapResultSetToEmployee(ResultSet resultSet) throws Exception {
        Employee entity = new Employee();
        entity.setId(resultSet.getString("Id"));
        entity.setPassword(resultSet.getString("Password"));
        entity.setFullname(resultSet.getString("Fullname"));
        entity.setPhoto(resultSet.getString("Photo"));
        entity.setGender(resultSet.getBoolean("Gender"));
        entity.setBirthday(resultSet.getString("Birthday"));
        entity.setSalary(resultSet.getFloat("Salary"));
        entity.setDepartmentId(resultSet.getString("DepartmentId"));
        return entity;
    }
}
