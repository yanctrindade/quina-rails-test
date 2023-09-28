require 'rails_helper'

RSpec.describe "Api::V1::Teachers", type: :request do
  let(:base_endpoint) { '/api/v1/teachers' }
  
  describe "POST /create" do
    context "with valid attributes" do
      let(:valid_attributes) { { teacher: { name: "John Doe" } } }

      it "creates a new teacher" do
        expect {
          post "#{base_endpoint}", params: valid_attributes
        }.to change(Teacher, :count).by(1)
      end

      it "returns a created status" do
        post "#{base_endpoint}", params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { { teacher: { name: "" } } }

      it "does not create a teacher" do
        expect {
          post "#{base_endpoint}", params: invalid_attributes
        }.not_to change(Teacher, :count)
      end

      it "returns an unprocessable entity status" do
        post "#{base_endpoint}", params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /index" do
    before do
      # Create 3 teachers manually
      3.times { Teacher.create!(name: "John Doe") }
    end
  
    it "returns a list of teachers" do
      get "#{base_endpoint}"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['teachers'].size).to eq(3)
    end
  
    it "returns a success status" do
      get "#{base_endpoint}"
      expect(response).to have_http_status(:ok)
    end
  end
end
