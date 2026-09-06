# Bug Tracking System

A scalable issue tracking web application built for software engineering teams to manage, assign, and resolve project bugs efficiently.

---

### Key Features

- **Role-Based Access Control (RBAC)**: Fine-grained permissions for Admin, Manager, Developer, and QA/Tester roles.
- **Application Security**: Built on Spring Security with BCrypt password hashing, credential protection, and custom request sanitization filters.
- **Cloud Media Storage**: Integrated Cloudinary for uploading and delivering bug screenshots, attachments, and logs.
- **Optimized Relational Schema**: Normalized MySQL schema with Hibernate (JPA) object-relational mapping.

---

### Tech Stack

- **Backend**: Java, Spring Boot, Spring MVC, Hibernate (JPA)
- **Security**: Spring Security, BCrypt
- **Database**: MySQL
- **Media Delivery**: Cloudinary
- **Frontend**: JSP, Bootstrap

---

### Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ysp199/BugTracking.git
   cd BugTracking
   ```

2. **Configure database & credentials**:
   Update `src/main/resources/application.properties` with your MySQL database details and Cloudinary credentials:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/bug_tracking_db
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

3. **Run the application**:
   ```bash
   ./mvnw spring-boot:run
   ```
   The application will start at `http://localhost:8080`.
