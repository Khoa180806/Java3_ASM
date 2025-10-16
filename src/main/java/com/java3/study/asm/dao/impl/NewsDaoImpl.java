package com.java3.study.asm.dao.impl;

import com.java3.study.asm.dao.NewsDao;
import com.java3.study.asm.entity.News;
import com.java3.study.asm.utils.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsDaoImpl implements NewsDao {
    
    @Override
    public List<News> selectAll() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT id, title, content, image, postedDate, author, viewCount, categoryId, home FROM News";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                News news = new News();
                mapResultSetToNews(rs, news);
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }

    @Override
    public News selectById(String id) {
        String sql = "SELECT id, title, content, image, postedDate, author, viewCount, categoryId, home FROM News WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    News news = new News();
                    mapResultSetToNews(rs, news);
                    return news;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(News news) {
        String sql = """
            INSERT INTO News (id, title, content, image, postedDate, author, viewCount, categoryId, home)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)""";
            
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            setNewsParameters(stmt, news);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(News news) {
        String sql = """
            UPDATE News 
            SET title = ?, content = ?, image = ?, postedDate = ?, 
                author = ?, viewCount = ?, categoryId = ?, home = ?
            WHERE id = ?""";
            
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, news.getTitle());
            stmt.setString(2, news.getContent());
            stmt.setString(3, news.getImage());
            stmt.setDate(4, news.getPostedDate());
            stmt.setString(5, news.getAuthor());
            stmt.setInt(6, news.getViewCount());
            stmt.setString(7, news.getCategoryId());
            stmt.setBoolean(8, news.getHome());
            stmt.setString(9, news.getId());
            
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM News WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Helper method to map ResultSet to News object
    private void mapResultSetToNews(ResultSet rs, News news) throws SQLException {
        news.setId(rs.getString("id"));
        news.setTitle(rs.getString("title"));
        news.setContent(rs.getString("content"));
        news.setImage(rs.getString("image"));
        news.setPostedDate(rs.getDate("postedDate"));
        news.setAuthor(rs.getString("author"));
        news.setViewCount(rs.getInt("viewCount"));
        news.setCategoryId(rs.getString("categoryId"));
        news.setHome(rs.getBoolean("home"));
    }
    
    // Helper method to set parameters for insert/update
    private void setNewsParameters(PreparedStatement stmt, News news) throws SQLException {
        stmt.setString(1, news.getId());
        stmt.setString(2, news.getTitle());
        stmt.setString(3, news.getContent());
        stmt.setString(4, news.getImage());
        stmt.setDate(5, news.getPostedDate());
        stmt.setString(6, news.getAuthor());
        stmt.setInt(7, news.getViewCount());
        stmt.setString(8, news.getCategoryId());
        stmt.setBoolean(9, news.getHome());
    }

    @Override
    public List<News> selectByCategory(String categoryId) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT id, title, content, image, postedDate, author, viewCount, categoryId, home " +
                    "FROM News WHERE categoryId = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    News news = new News();
                    mapResultSetToNews(rs, news);
                    newsList.add(news);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }

    @Override
    public List<News> selectFeaturedNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) id, title, content, image, postedDate, author, viewCount, categoryId, home " +
                    "FROM News ORDER BY viewCount DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    News news = new News();
                    mapResultSetToNews(rs, news);
                    newsList.add(news);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }

    @Override
    public List<News> selectLatestNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) id, title, content, image, postedDate, author, viewCount, categoryId, home " +
                    "FROM News ORDER BY postedDate DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    News news = new News();
                    mapResultSetToNews(rs, news);
                    newsList.add(news);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }
}