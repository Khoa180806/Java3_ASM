package com.java3.study.asm.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    // Use SQL Server URL to match the SQLServer driver (mssql-jdbc dependency in pom.xml)
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=PS45143_ASM;encrypt=false;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "123";

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // Load driver
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}