require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  # This will help to prefix all requests with '/api/v1'
  let(:base_endpoint) { '/api/v1/students' }

  describe 'POST /create' do
    context 'with valid attributes' do
      let(:valid_attributes) { { student: { name: 'John Doe' } } }

      it 'creates a new student' do
        expect {
          post "#{base_endpoint}", params: valid_attributes
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['student']['name']).to eq('John Doe')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { student: { name: '' } } }

      it 'does not create a student' do
        expect {
          post "#{base_endpoint}", params: invalid_attributes
        }.not_to change(Student, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to include("Name can't be blank")
      end
    end
  end

  describe 'GET /index' do
    before do
      # Create some test data
      Student.create!(name: 'John Doe')
      Student.create!(name: 'Jane Doe')
    end

    it 'retrieves all students' do
      get "#{base_endpoint}"

      expect(response).to have_http_status(:ok)
      students = JSON.parse(response.body)['data']
      expect(students.count).to eq(2)
    end
  end

  describe 'GET /show' do
    let!(:student) { Student.create!(name: 'John Doe') }

    it 'retrieves a specific student' do
      get "#{base_endpoint}/#{student.id}"

      expect(response).to have_http_status(:ok)
      retrieved_student = JSON.parse(response.body)['student']
      expect(retrieved_student['name']).to eq('John Doe')
    end
  end
end
