package com.example.cms.model;

public class Course {
    private int id;
    private String courseName;
    private int teacherId;

    public Course(){}

    public Course(int id, String courseName, int teacherId) {
        this.id = id;
        this.courseName = courseName;
        this.teacherId = teacherId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
}
