# Servlet + JSP Online Course Management (Skeleton)

This is a minimal Maven project to satisfy your lab's R-1 ... R-5 requirements.

## Quick Start
1. Install JDK 11+, Maven, and Tomcat 9+.
2. Create the database:
   - Start MySQL and run `schema.sql` to create sample data.
   - Update DB credentials in `src/main/java/com/example/cms/dao/DBUtil.java` (URL/USER/PASS).
3. Build the WAR:
   ```bash
   mvn clean package
   ```
4. Deploy:
   - Copy `target/cms.war` to your Tomcat `webapps/` folder.
   - Access at: `http://localhost:8080/cms/`

## Roles / Sample Login
- admin / admin  → admin dashboard
- teach1 / pass  → teacher dashboard
- stu1 / pass     → student dashboard

## Notes
- Passwords are plain-text for demo. Replace with BCrypt in a real app.
- `AuthFilter` guards routes and enforces simple role checks.
- Uses Bootstrap 5 via CDN for styling.

## Where to add features
- Add new servlets under `com.example.cms.servlet`
- Add DAO methods in `com.example.cms.dao`
- Add JSP pages under `src/main/webapp`
