module Api
    module V1
      class TeachersController < ApplicationController
        def index
          homeworks = Homework.all
          render json: { data: homeworks }, status: :ok
        end
  
        def update
          homework = Homework.find(params[:id])
          if homework.update(teacher_params)
            render json: { status: 'success', data: homework }, status: :ok
          else
            render json: { status: 'error', message: homework.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        def search
          homeworks = Api::V1::HomeworkSearch.filter(params)
          render json: { homeworks: homeworks }
        end
  
        private
  
        def teacher_params
          params.require(:homework).permit(:grade, :teacher_note, :graded_at)
        end
      end
    end
  end
  