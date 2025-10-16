package com.java3.study.Lab6;

import java.sql.ResultSet;

public class Test {
    public static void main(String[] args) {
        try {
            // 1. Hiển thị tất cả phòng ban
            System.out.println("=== DANH SÁCH TẤT CẢ PHÒNG BAN ===");
            selectAllDepartments(null, null, null);

            // 2. Tìm kiếm phòng ban
            System.out.println("\n=== TÌM KIẾM PHÒNG BAN ===");
            System.out.println("Tìm phòng Kinh doanh:");
            selectAllDepartments(null, "Kinh doanh", null);

            // 3. Thêm mới và xem kết quả
            System.out.println("\n=== THÊM MỚI VÀ KIỂM TRA ===");
            String insertSQL = "{CALL spInsert(?, ?, ?)}";
            Object[] insertParams = {"13", "Phòng Kinh doanh", "Phụ trách kinh doanh"};
            Jdbc.executeUpdate(insertSQL, insertParams);
            
            System.out.println("Đã thêm mới, kiểm tra kết quả:");
            selectAllDepartments("13", null, null);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Phương thức hiển thị tất cả phòng ban
    public static void selectAllDepartments(String id, String name, String description) {
        try {
            String sql = "{CALL spSelectAll(?, ?, ?)}";
            Object[] params = {id, name, description};
            ResultSet resultSet = Jdbc.executeQuery(sql, params);
            boolean hasData = false;
            
            System.out.println("\nKết quả tìm kiếm:");
            System.out.println("ID     | Tên                           | Mô tả");
            System.out.println("-------+-------------------------------+----------------------------------");
            
            while (resultSet.next()) {
                hasData = true;
                String deptId = resultSet.getString("Id");
                String deptName = resultSet.getString("Name");
                String deptDesc = resultSet.getString("Description");
                System.out.println(String.format("%-6s | %-30s | %s", 
                    deptId, deptName, deptDesc));
            }
            
            if (!hasData) {
                System.out.println("Không tìm thấy dữ liệu phù hợp!");
            }
            
            resultSet.close();
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm kiếm phòng ban: " + e.getMessage());
        }
    }

    // Phương thức xem chi tiết phòng ban theo ID
    public static void selectDepartmentById(String id) {
        try {
            String sql = "{CALL spSelectById(?)}";
            ResultSet resultSet = Jdbc.executeQuery(sql, new Object[]{id});
            
            if (resultSet.next()) {
                String name = resultSet.getString("Name");
                String description = resultSet.getString("Description");
                System.out.println("Thông tin chi tiết:");
                System.out.println("- ID: " + id);
                System.out.println("- Tên: " + name);
                System.out.println("- Mô tả: " + description);
            } else {
                System.out.println("Không tìm thấy phòng ban có ID: " + id);
            }
            
            resultSet.close();
        } catch (Exception e) {
            System.err.println("Lỗi khi đọc chi tiết phòng ban: " + e.getMessage());
        }
    }
}