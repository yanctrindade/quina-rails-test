### Objective

Your objective is to implement a simple API for a school's homework submission platform that enables students to submit their homework and teachers to grade students' submissions.

### Brief

Using **Ruby** and **Rails**, your challenge is to build a simple API for a school's homework submission platform. You are expected to design any required models and routes for your API and document your endpoints in a separate markdown file, "ENDPOINTS.md".

### Tasks

-   Implement the assignment using:
    -   Language: **Ruby**
    -   Framework: **Rails**
-   There should be API routes that allow students to:
-   Submit their homework
-   View their homework submissions
    -   Filter by grade (A - F, incomplete, ungraded)
    -   Filter by assignment name
-   There should be API routes that allow teachers to:
    -   See an overview of all homework submissions
        -   Filter by assignment name, date range (to - from), and individual student name
    -   Grade individual homework submissions (A-F, comments)
-   Add unit tests for your business logic

Each homework object should minimally include the following fields:

-   Assignment name
-   Student name
-   Submission datetime
-   Grading datetime
-   File attachment (pdf/jpeg)
-   Final grade
-   Teachers Notes

### Evaluation Criteria

-   Ruby best practices
-   Completeness: Did you include all features?
-   Correctness: Does the solution perform in a logical way?
-   Maintainability: Is the solution written in a clean, maintainable way?
-   Testing: Has the solution been adequately tested?
-   Documentation: Is the API well-documented?

### CodeSubmit

Please organize, design, test, and document your code as if it were going into production - then push your changes to the master branch. After you have pushed your code, you must submit the assignment via the assignment page.

All the best and happy coding,

The Quina Team

## How to Run the project

Project was implemented using rails 7.0.2 and ruby 3.2.2 with Docker Image.   

```
docker-compose build
docker-compose run web rake db:create
docker-compose run web rake db:migrate
docker-compose up
```