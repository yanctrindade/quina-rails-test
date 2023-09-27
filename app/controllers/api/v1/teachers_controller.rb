module Api
    module V1
      class TeachersController < ApplicationController

        def create
          teacher = Teacher.new(teacher_params)
          if teacher.save
            render json: { teacher: teacher }, status: :created
          else
            render json: { status: 'error', message: teacher.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def index
          teachers = Teacher.all
          render json: { teachers: teachers }, status: :ok
        end
  
        private
  
        def teacher_params
          params.require(:teacher).permit(:name)
        end
      end
    end
  end
  