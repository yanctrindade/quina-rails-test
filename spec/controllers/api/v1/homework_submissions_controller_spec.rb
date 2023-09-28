require 'rails_helper'

RSpec.describe Api::V1::HomeworkSubmissionsController, type: :controller do
  let!(:student) { Student.create(name: "John") } # This will create a student for each test

  describe "POST #create" do
    context "with valid parameters" do
        let(:valid_homework) { 
            { 
              assignment_name: "Math Assignment", 
              attachment: fixture_file_upload('spec/fixtures/yan.JPG', 'image/jpeg') 
            } 
          }  

      it "creates a new homework for the student" do
        expect {
          post :create, params: { student_id: student.id, homework: valid_homework }
        }.to change(student.homeworks, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { student_id: student.id, homework: valid_homework }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_homework) { { assignment_name: "", attachment: "" } }

      it "does not create a homework" do
        expect {
          post :create, params: { student_id: student.id, homework: invalid_homework }
        }.to change(student.homeworks, :count).by(0)
      end

      it "returns an error status" do
        post :create, params: { student_id: student.id, homework: invalid_homework }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #index" do
    before do
      Homework.create(assignment_name: "Math", student: student) 
      Homework.create(assignment_name: "History", student: student) 
    end

    it "returns all homeworks for the student" do
      get :index, params: { student_id: student.id }
      expect(response).to have_http_status(:ok)
      homeworks = JSON.parse(response.body)["data"]
      expect(homeworks.size).to eq(2)
    end
  end

  describe "GET #search" do
    let!(:math_homework) { Homework.create(assignment_name: "Math Assignment", student: student) }
    let!(:history_homework) { Homework.create(assignment_name: "History Assignment", student: student) }

    context "with matching query" do
      it "returns matched homeworks for the student" do
        get :search, params: { student_id: student.id, query: "Math" } # assuming the query parameter is called "query"
        expect(response).to have_http_status(:ok)
        homeworks = JSON.parse(response.body)["homeworks"]
        expect(homeworks.size).to eq(1)
        expect(homeworks.first["assignment_name"]).to eq(math_homework.assignment_name)
      end
    end

    context "with no matching query" do
      it "returns no homeworks" do
        get :search, params: { student_id: student.id, query: "Biology" }
        expect(response).to have_http_status(:ok)
        homeworks = JSON.parse(response.body)["homeworks"]
        expect(homeworks).to be_empty
      end
    end
  end

end
