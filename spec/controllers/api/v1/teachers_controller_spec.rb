require 'rails_helper'

RSpec.describe Api::V1::TeachersController, type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_teacher) { { name: "Mr. Smith" } }

      it "creates a new teacher" do
        expect {
          post :create, params: { teacher: valid_teacher }
        }.to change(Teacher, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { teacher: valid_teacher }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_teacher) { { name: "" } }

      it "does not create a teacher" do
        expect {
          post :create, params: { teacher: invalid_teacher }
        }.to change(Teacher, :count).by(0)
      end

      it "returns an error status" do
        post :create, params: { teacher: invalid_teacher }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #index" do
    before do
      Teacher.create(name: "Mr. Smith")
      Teacher.create(name: "Ms. Brown")
    end

    it "returns all teachers" do
      get :index
      expect(response).to have_http_status(:ok)
      teachers = JSON.parse(response.body)["teachers"]
      expect(teachers.size).to eq(2)
    end
  end

end
