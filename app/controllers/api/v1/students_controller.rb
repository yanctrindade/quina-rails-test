module Api
    module V1
      class StudentsController < ApplicationController
        def create
          puts "params: #{params}"
          params[:homework][:student_id] = params[:student_id].to_i
          homework = Homework.new(homework_params)
          if homework.save
            render json: homework, status: :created # Rails will use the serializer here
          else
            render json: { status: 'error', message: homework.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        def index
          student = Student.find(params[:student_id])
          homeworks = student.homeworks
          render json: { data: homeworks }, status: :ok
        end
  
        def search
          homeworks = Homework.where(grade: Homework.grades[params[:grade]])
          render json: { data: homeworks }, status: :ok
        end
  
        private
  
        def homework_params
          params.require(:homework).permit(:assignment_name, :student_id, :attachment)
        end
      end
    end
  end