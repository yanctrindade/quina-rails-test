require 'rails_helper'

RSpec.describe Api::V1::StudentsController, type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_student) { { name: "John Doe" } }

      it "creates a new student" do
        expect {
          post :create, params: { student: valid_student }
        }.to change(Student, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { student: valid_student }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_student) { { name: "" } }

      it "does not create a student" do
        expect {
          post :create, params: { student: invalid_student }
        }.to change(Student, :count).by(0)
      end

      it "returns an error status" do
        post :create, params: { student: invalid_student }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #index" do
    before do
      Student.create(name: "John Doe")
      Student.create(name: "Jane Smith")
    end

    it "returns all students" do
      get :index
      expect(response).to have_http_status(:ok)
      students = JSON.parse(response.body)["data"]
      expect(students.size).to eq(2)
    end
  end

  describe "GET #show" do
    let(:student) { Student.create(name: "John Doe") }

    it "returns a specific student" do
      get :show, params: { id: student.id }
      expect(response).to have_http_status(:ok)
      returned_student = JSON.parse(response.body)["student"]
      expect(returned_student["name"]).to eq(student.name)
    end

    it "returns not found for an invalid student id" do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
    end
  end

end
