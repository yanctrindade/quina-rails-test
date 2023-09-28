require 'rails_helper'

RSpec.describe 'HomeworkReviews API', type: :request do
  describe 'GET /api/v1/teachers/:teacher_id/homework_reviews' do
    it 'returns a list of homework reviews for a specific teacher' do
      # Create a teacher record for testing
      teacher = Teacher.create(name: 'Teacher 1')
      student = Student.create(name: 'Student 1')
      # Create some homework records for the teacher by student
      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 1',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }

      # Make a GET request to the index action for homework_reviews within the teacher's context
      get "/api/v1/teachers/#{teacher.id}/homework_reviews"

      # Expect a successful response with a status code of 200
      expect(response).to have_http_status(:ok)

      # Parse the JSON response
      json_response = JSON.parse(response.body)

      # Expect the response to include the data of the homework reviews for the teacher
      expect(json_response['data']).to be_an(Array)
      expect(json_response['data'].size).to eq(1)
    end
  end
end
