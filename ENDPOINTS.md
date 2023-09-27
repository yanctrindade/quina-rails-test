# API Endpoints Documentation

## Students

### Create a Student
- **Endpoint:** `/api/v1/students`
- **Method:** `POST`
- **Parameters:**
  - `name`: String (required)

**Payload**:
```json
{
    "name": "John Doe"
}
```

```bash
curl -X POST -H "Content-Type: application/json" -d '{"name": "John Doe"}' http://your-server-url/api/v1/students
```
  
### List all Students
- **Endpoint:** `/api/v1/students`
- **Method:** `GET`

**Curl Command**:
```bash
curl -X GET http://your-server-url/api/v1/students
```

### Show a Specific Student
- **Endpoint:** `/api/v1/students/:id`
- **Method:** `GET`

**Curl Command**:
```bash
curl -X GET http://your-server-url/api/v1/students/:id
```

## Teachers

### Create a Teacher
- **Endpoint:** `/api/v1/teachers`
- **Method:** `POST`
- **Parameters:**
  - `name`: String (required)

**Payload**:
```json
{
    "name": "Mrs. Smith"
}
```

```bash
curl -X POST -H "Content-Type: application/json" -d '{"name": "Mrs. Smith"}' http://your-server-url/api/v1/teachers
```

### List all Teachers
- **Endpoint:** `/api/v1/teachers`
- **Method:** `GET`

**Curl Command**:
```bash
curl -X GET http://your-server-url/api/v1/teachers
```

## Homework Submissions (By Students)

### Submit a Homework
- **Endpoint:** `/api/v1/students/:student_id/homework_submissions`
- **Method:** `POST`
- **Parameters:**
  - `assignment_name`: String (required)
  - `attachment`: File (required)

**Curl Command**:
```bash
curl -X POST -F "assignment_name=Math Homework" -F "attachment=@path-to-your-file.jpg" http://your-server-url/api/v1/students/:student_id/homework_submissions
```

### List all Homeworks for a Student
- **Endpoint:** `/api/v1/students/:student_id/homework_submissions`
- **Method:** `GET`

**Curl Command**:
```bash
curl -X GET http://your-server-url/api/v1/students/:student_id/homework_submissions
```

### Search for Homeworks
- **Endpoint:** `/api/v1/students/:student_id/homework_submissions/search`
- **Method:** `GET`
- **Parameters:**
  - Various filtering parameters as defined in `Api::V1::HomeworkSearch`

**Curl Command**:
```bash
curl -X GET "http://your-server-url/api/v1/students/:student_id/homework_submissions/search?assignment_name=Math Homework"
```

## Homework Reviews (By Teachers)

### List all Ungraded Homeworks
- **Endpoint:** `/api/v1/teachers/:teacher_id/homework_reviews`
- **Method:** `GET`

**Curl Command**:
```bash
curl -X GET http://your-server-url/api/v1/teachers/:teacher_id/homework_reviews
```

### Grade/Review a Homework
- **Endpoint:** `/api/v1/teachers/:teacher_id/homework_reviews/:id`
- **Method:** `PUT/PATCH`
- **Parameters:**
  - `grade`: Enum (required)
  - `teacher_note`: Text

**Payload**:
```json
{
    "grade": "A",
    "teacher_note": "Well done!"
}
```

**Curl Command**:
```bash
curl -X PUT -H "Content-Type: application/json" -d '{"grade": "A", "teacher_note": "Well done!"}' http://your-server-url/api/v1/teachers/:teacher_id/homework_reviews/:id
```

### Search for Homeworks to Review
- **Endpoint:** `/api/v1/teachers/:teacher_id/homework_reviews/search`
- **Method:** `GET`
- **Parameters:**
  - Various filtering parameters as defined in `Api::V1::HomeworkSearch`

**Curl Command**:
```bash
curl -X GET "http://your-server-url/api/v1/teachers/:teacher_id/homework_reviews/search?assignment_name=Math Homework"
```