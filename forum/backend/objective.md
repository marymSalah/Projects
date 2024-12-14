# Web Forum Project Objectives and Requirements

## Project Overview
This project aims to create a web forum application using Go, SQLite, and Docker. The forum will facilitate communication between users through posts and comments, allow association of categories with posts, enable liking and disliking of posts and comments, and provide filtering mechanisms. The application will utilize Docker for containerization and SQLite for database management.

## Objectives
1. **Communication Between Users:**
   - Enable users to create posts and comments to communicate with each other.
   - Posts and comments should be visible to all users, with registered users having additional privileges.

2. **Associating Categories to Posts:**
   - Allow registered users to associate one or more categories with their posts.
   - Categories will help in organizing and filtering posts effectively.

3. **Likes and Dislikes:**
   - Registered users can like or dislike posts and comments.
   - Display the number of likes and dislikes for each post and comment to all users.

4. **Filtering Posts:**
   - Implement filtering mechanisms to allow users to filter posts by:
     - Categories
     - Created posts
     - Liked posts (available only to registered users)

5. **SQLite Database Usage:**
   - Utilize SQLite to store and manage data including users, posts, comments, categories, likes, and dislikes.
   - Implement database operations using SQL queries for CRUD operations.

6. **Authentication and Sessions:**
   - Enable user registration with email, username, and password.
   - Implement secure password storage (bonus task: encryption using bcrypt).
   - Use cookies for session management with an expiration date.

7. **Bonus Task - UUID Usage:**
   - Implement the use of UUID for unique identifiers in the application.

8. **Error Handling and HTTP Status:**
   - Implement proper error handling for website errors and HTTP status codes.
   - Handle all technical errors gracefully to ensure smooth operation of the application.

9. **Docker Containerization:**
   - Dockerize the application for easy deployment and management.
   - Create Docker images and use Docker Compose for orchestration.

10. **Testing and Good Practices:**
    - Write unit tests to ensure code reliability and functionality.
    - Adhere to good practices in software development including code documentation and version control.

## Learning Goals
This project will provide hands-on learning experience in:
- Web fundamentals: HTML, HTTP, sessions, and cookies.
- Docker basics: Containerizing applications, compatibility, and dependency management.
- SQL language: Database schema design and manipulation.
- Encryption basics: Implementing secure password storage.

## Requirements
- Use standard Go packages including `sqlite3`, `bcrypt`, and `UUID`.
- Avoid frontend libraries or frameworks like React, Angular, or Vue.

---

By focusing on these objectives and requirements, this project aims to deliver a robust and scalable web forum application while enhancing your skills in web development, Docker, database management, and encryption.
