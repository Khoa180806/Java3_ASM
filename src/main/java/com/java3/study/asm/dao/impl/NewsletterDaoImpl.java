package com.java3.study.asm.dao.impl;

import com.java3.study.asm.dao.NewsletterDao;
import com.java3.study.asm.entity.Newsletter;
import com.java3.study.asm.utils.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsletterDaoImpl implements NewsletterDao {
    
    @Override
    public List<Newsletter> getAll() {
        List<Newsletter> newsletters = new ArrayList<>();
        String sql = "SELECT email, enabled FROM Newsletters";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Newsletter newsletter = new Newsletter();
                mapResultSetToNewsletter(rs, newsletter);
                newsletters.add(newsletter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsletters;
    }

    @Override
    public Newsletter getByEmail(String email) {
        String sql = "SELECT email, enabled FROM Newsletters WHERE email = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Newsletter newsletter = new Newsletter();
                    mapResultSetToNewsletter(rs, newsletter);
                    return newsletter;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(Newsletter newsletter) {
        String sql = "INSERT INTO Newsletters (email, enabled) VALUES (?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newsletter.getEmail());
            stmt.setBoolean(2, newsletter.getEnabled());
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(String email) {
        String sql = "UPDATE Newsletters SET enabled = false WHERE email = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Newsletter newsletter) {
        String sql = "DELETE FROM Newsletters WHERE email = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newsletter.getEmail());
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Helper method to map ResultSet to Newsletter object
    private void mapResultSetToNewsletter(ResultSet rs, Newsletter newsletter) throws SQLException {
        newsletter.setEmail(rs.getString("email"));
        newsletter.setEnabled(rs.getBoolean("enabled"));
    }
}