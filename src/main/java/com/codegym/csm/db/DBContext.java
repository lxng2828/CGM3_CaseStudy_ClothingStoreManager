package com.codegym.csm.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cgm3_casestudy_clothingstoremanager";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "haha123";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static Connection connection = null;

    private DBContext() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName(DB_DRIVER);
                connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
        return connection;
    }

    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("Kết nối đến cơ sở dữ liệu thành công!");
                System.out.println("Đối tượng Connection: " + conn);
                conn.close();
                System.out.println("Đã đóng kết nối.");
            } else {
                System.out.println("Kết nối đến cơ sở dữ liệu thất bại!");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối CSDL: " + e.getMessage());
            e.printStackTrace();
        }
    }
}