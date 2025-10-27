package com.java3.study.bv.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.java3.study.bv.dao.KhachhangDAO;
import com.java3.study.bv.entity.Khachhang;
import com.java3.study.bv.utils.DBConnect;

public class KhachhangDAOImpl implements KhachhangDAO {

    private static final String INSERT_SQL = "INSERT INTO Khachhang (Username, Pass, Hoten, Gioitinh, Email) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_SQL = "UPDATE Khachhang SET Pass = ?, Hoten = ?, Gioitinh = ?, Email = ? WHERE Username = ?";
    private static final String DELETE_SQL = "DELETE FROM Khachhang WHERE Username = ?";
    private static final String SELECT_ALL_SQL = "SELECT Username, Pass, Hoten, Gioitinh, Email FROM Khachhang";
    private static final String SELECT_BY_USERNAME_SQL = SELECT_ALL_SQL + " WHERE Username = ?";

    @Override
    public void insert(Khachhang kh) {
        try (Connection connection = DBConnect.getConnection();
                PreparedStatement statement = connection.prepareStatement(INSERT_SQL)) {
            // Bind entity data to SQL parameters for insertion
            statement.setString(1, kh.getUsername());
            statement.setString(2, kh.getPass());
            statement.setString(3, kh.getHoten());
            statement.setBoolean(4, kh.isGioitinh());
            statement.setString(5, kh.getEmail());
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to insert customer with username: " + kh.getUsername(), ex);
        }
    }

    @Override
    public void update(Khachhang kh) {
        try (Connection connection = DBConnect.getConnection();
                PreparedStatement statement = connection.prepareStatement(UPDATE_SQL)) {
            // Update mutable fields while keeping username as immutable key
            statement.setString(1, kh.getPass());
            statement.setString(2, kh.getHoten());
            statement.setBoolean(3, kh.isGioitinh());
            statement.setString(4, kh.getEmail());
            statement.setString(5, kh.getUsername());
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to update customer with username: " + kh.getUsername(), ex);
        }
    }

    @Override
    public void delete(String username) {
        try (Connection connection = DBConnect.getConnection();
                PreparedStatement statement = connection.prepareStatement(DELETE_SQL)) {
            // Delete customer by unique username
            statement.setString(1, username);
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to delete customer with username: " + username, ex);
        }
    }

    @Override
    public Khachhang findByUsername(String username) {
        try (Connection connection = DBConnect.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_BY_USERNAME_SQL)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapRow(resultSet);
                }
            }
            return null;
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to find customer with username: " + username, ex);
        }
    }

    @Override
    public List<Khachhang> findAll() {
        List<Khachhang> customers = new ArrayList<>();
        try (Connection connection = DBConnect.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_ALL_SQL);
                ResultSet resultSet = statement.executeQuery()) {
            // Collect every row into Khachhang entities
            while (resultSet.next()) {
                customers.add(mapRow(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to retrieve customers", ex);
        }
        return customers;
    }

    private Khachhang mapRow(ResultSet resultSet) throws SQLException {
        // Centralized mapping ensures consistent column-to-field conversion
        Khachhang kh = new Khachhang();
        kh.setUsername(resultSet.getString("Username"));
        kh.setPass(resultSet.getString("Pass"));
        kh.setHoten(resultSet.getString("Hoten"));
        kh.setGioitinh(resultSet.getBoolean("Gioitinh"));
        kh.setEmail(resultSet.getString("Email"));
        return kh;
    }
}
