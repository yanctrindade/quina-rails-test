require 'rails_helper'

RSpec.describe Api::V1::HomeworkReviewsController, type: :controller do

  let(:homework) { Homework.create!(assignment_name: "Math Assignment", grade: "ungraded") } 
  let(:teacher) { Teacher.create!(name: "Mr. Smith") }
  
  describe "GET #index" do
    it "returns all homeworks" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(Homework.count)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the homework" do
        valid_params = { grade: "A", teacher_note: "Well done", teacher_id: teacher.id }
        put :update, params: { id: homework.id, homework: valid_params, teacher_id: teacher.id }
        homework.reload
        expect(homework.grade).to eq("A")
        expect(homework.teacher_note).to eq("Well done")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "does not update the homework and returns errors" do
        invalid_params = { grade: "", teacher_note: "", teacher_id: "" }
        put :update, params: { id: homework.id, homework: invalid_params, teacher_id: teacher.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["message"]).not_to be_empty
      end
    end

    context "when homework is not found" do
      it "returns not found response" do
        put :update, params: { id: -1, homework: { grade: "A", teacher_note: "Well done", teacher_id: teacher.id } }
        expect(response).to have_http_status(:not_found)
      end
    end
  
    context "when teacher_id is missing" do
      it "does not update the homework and returns errors" do
        invalid_params = { grade: "A", teacher_note: "Well done", teacher_id: nil }
        put :update, params: { id: homework.id, homework: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end
  
  describe "POST #search" do
    before do
        Homework.create!(assignment_name: "Math A", grade: "A")
        Homework.create!(assignment_name: "Math B", grade: "B")
        student = Student.create!(name: "John Doe")
        Homework.create!(assignment_name: "History A", grade: "A", student: student)
    end

    it "returns homeworks filtered by grade" do
      post :search, params: { grade: "A" }
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)["homeworks"]
      expect(result.size).to eq(2)
      expect(result.map { |h| h["grade"] }.uniq).to eq(["A"])
    end

    it "returns homeworks within a date range" do
      old_homework = create(:homework, submitted_at: 2.days.ago)
      recent_homework = create(:homework, submitted_at: 1.hour.ago)
      post :search, params: { from_date: 1.day.ago.to_s, to_date: Time.current.to_s }
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)["homeworks"]
      expect(result.size).to eq(1)
      expect(result.first["id"]).to eq(recent_homework.id)
    end

    it "returns homeworks based on student name" do
      post :search, params: { student_name: "John" }
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)["homeworks"]
      expect(result.size).to eq(1)
      expect(result.first["student_name"]).to eq("John Doe")
    end

    it "returns empty result when no matches found" do
      post :search, params: { student_name: "Nonexistent" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["homeworks"]).to be_empty
    end
  end

end
