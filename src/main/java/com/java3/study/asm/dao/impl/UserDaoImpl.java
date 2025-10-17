package com.java3.study.asm.dao.impl;

import com.java3.study.asm.dao.UserDao;
import com.java3.study.asm.entity.User;
import com.java3.study.asm.utils.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    
    @Override
    public List<User> getAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, password, fullname, birthday, gender, mobile, email, role FROM Users";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                mapResultSetToUser(rs, user);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public User getById(String id) {
        String sql = "SELECT id, password, fullname, birthday, gender, mobile, email, role FROM Users WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    mapResultSetToUser(rs, user);
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(User user) {
        String sql = """
            INSERT INTO Users (id, password, fullname, birthday, gender, mobile, email, role)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)""";
            
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            setUserParameters(stmt, user);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(User user) {
        String sql = """
            UPDATE Users 
            SET password = ?, fullname = ?, birthday = ?, gender = ?, 
                mobile = ?, email = ?, role = ?
            WHERE id = ?""";
            
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Set parameters in the order of the SQL query
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getFullname());
            stmt.setDate(3, user.getBirthday());
            stmt.setBoolean(4, user.getGender());
            stmt.setString(5, user.getMobile());
            stmt.setString(6, user.getEmail());
            stmt.setBoolean(7, user.getRole());
            stmt.setString(8, user.getId());
            
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM Users WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Helper method to map ResultSet to User object
    private void mapResultSetToUser(ResultSet rs, User user) throws SQLException {
        user.setId(rs.getString("id"));
        user.setPassword(rs.getString("password"));
        user.setFullname(rs.getString("fullname"));
        user.setBirthday(rs.getDate("birthday"));
        user.setGender(rs.getBoolean("gender"));
        user.setMobile(rs.getString("mobile"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getBoolean("role"));
    }
    
    // Helper method to set parameters for insert/update
    private void setUserParameters(PreparedStatement stmt, User user) throws SQLException {
        stmt.setString(1, user.getId());
        stmt.setString(2, user.getPassword());
        stmt.setString(3, user.getFullname());
        stmt.setDate(4, user.getBirthday());
        stmt.setBoolean(5, user.getGender());
        stmt.setString(6, user.getMobile());
        stmt.setString(7, user.getEmail());
        stmt.setBoolean(8, user.getRole());
    }
}