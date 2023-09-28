require 'rails_helper'

RSpec.describe 'HomeworkSubmissions API', type: :request do
  describe 'POST /api/v1/students/:student_id/homework_submissions' do
    it 'creates a new homework submission for a student' do
      # Create a student manually
      student = Student.create(name: 'John Doe')

      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 1',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['assignment_name']).to eq('Assignment 1')
    end
  end

  describe 'GET /api/v1/students/:student_id/homework_submissions' do
    it 'returns a list of homework submissions for a student' do
      # Create a student manually
      student = Student.create(name: 'John Doe')

      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 1',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }

      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 2',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }

      get "/api/v1/students/#{student.id}/homework_submissions"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)['data']
      expect(data.size).to eq(2)
      expect(data.map { |s| s['assignment_name'] }).to match_array(['Assignment 1', 'Assignment 2'])
    end
  end

  describe 'GET /api/v1/students/:student_id/homework_submissions/search' do
    it 'returns a list of filtered homework submissions for a student' do
      student = Student.create(name: 'John Doe')
      
      # Create homework submissions for the student manually
      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 1',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }
      
      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 2',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }

      # Perform a search with valid search parameters
      get search_api_v1_student_homework_submissions_path(student), params: { grade: 'ungraded' }
      data = JSON.parse(response.body)['homeworks']

      expect(response).to have_http_status(:ok)
      expect(data.size).to eq(2) # Expecting two homework submissions after filtering
      # Add more expectations for other attributes of the filtered homework submissions
    end

    it 'returns an empty list if no homework submissions match the filter' do
      student = Student.create(name: 'John Doe')
      
      # Create homework submissions for the student manually
      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 1',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }
      
      post "/api/v1/students/#{student.id}/homework_submissions", params: {
        homework: {
          assignment_name: 'Assignment 2',
          attachment: fixture_file_upload('yan.jpg', 'image/jpeg')
        }
      }

      # Perform a search with invalid search parameters that don't match any homework submissions
      get search_api_v1_student_homework_submissions_path(student), params: { grade: 'A' }
      data = JSON.parse(response.body)['homeworks']

      expect(response).to have_http_status(:ok)
      expect(data.size).to eq(0) # Expecting an empty list
    end
  end
end
