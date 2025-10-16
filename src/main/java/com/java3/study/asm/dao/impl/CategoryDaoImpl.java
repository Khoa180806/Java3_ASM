package com.java3.study.asm.dao.impl;

import com.java3.study.asm.dao.CategoryDao;
import com.java3.study.asm.entity.Category;
import com.java3.study.asm.utils.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {
    
    @Override
    public void insert(Category category) {
        String sql = "INSERT INTO Category(id, name) VALUES (?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getId());
            stmt.setString(2, category.getName());
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Category category) {
        String sql = "UPDATE Category SET name = ? WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getId());
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM Category WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Category selectById(String id) {
        String sql = "SELECT * FROM Category WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Category category = new Category();
                category.setId(rs.getString("id"));
                category.setName(rs.getString("name"));
                return category;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category> selectAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getString("id"));
                category.setName(rs.getString("name"));
                list.add(category);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}