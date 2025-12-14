package com.example.cms.dao;

import com.example.cms.model.User;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;


public class UserDAO {
    public User authenticate(String username, String password) {
        System.out.println("UserDAO: Authenticating with username='" + username + "' and password='" + password + "'");

        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            System.out.println("About to run query on connection: " + con);

            

            try (ResultSet rs = ps.executeQuery()) {
            	System.out.println("habijabi");
            	System.out.println(rs);
                if (rs.next()) {
                    String dbUsername = rs.getString("username");
                    String dbPassword = rs.getString("password");
                    String role = rs.getString("role");

                    System.out.println("UserDAO: Found user - username: " + dbUsername + ", password: " + dbPassword + ", role: " + role);

                    return new User(
                        rs.getInt("id"),
                        dbUsername,
                        dbPassword,
                        role
                    );
                } else {
                    System.out.println("UserDAO: No matching user found for username='" + username + "'");
                }
            }

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }


        return null;
    }
    public List<Integer> getAllIdsByRole(String role) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT id FROM users WHERE role=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, role);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getInt("id"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }
    public String getNameById(int userId) {
        String sql = "SELECT username FROM users WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // null if user not found
    }

}
