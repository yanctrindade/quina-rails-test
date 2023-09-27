module Api
    module V1
      class StudentsController < ApplicationController
        def create
          student = Student.new(student_params)
          if student.save
            render json: { student: student }, status: :created
          else
            render json: { status: 'error', message: student.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        def index
          students = Student.all
          render json: { data: students }, status: :ok
        end
  
        def show
          student = Student.find(params[:id])
          render json: { student: student }
        end
  
        private
  
        def student_params
          params.require(:student).permit(:name)
        end
      end
    end
  end