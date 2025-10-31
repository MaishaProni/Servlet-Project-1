package com.example.cms.dao;

import com.example.cms.model.User;
import java.sql.*;

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
}
