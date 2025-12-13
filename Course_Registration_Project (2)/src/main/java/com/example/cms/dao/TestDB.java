package com.example.cms.dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null) {
                System.out.println("Connection successful!");
                DatabaseMetaData meta = conn.getMetaData();
                System.out.println("Connected to database: " + meta.getDatabaseProductName() +
                                   " version: " + meta.getDatabaseProductVersion());
                System.out.println("URL: " + meta.getURL());
                System.out.println("User: " + meta.getUserName());
            } else {
                System.out.println("Failed to connect.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
