module Api
    module V1
      class HomeworkReviewsController < ApplicationController
        before_action :find_homework, only: [:update]
  
        def index
          homeworks = Homework.all
          render json: { data: homeworks }, status: :ok
        end
  
        def update
          @homework.teacher_id = params[:teacher_id]
          if @homework.update(review_params)
            render json: { status: 'success', data: @homework }, status: :ok
          else
            render json: { status: 'error', message: @homework.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        def search
          homeworks = Api::V1::HomeworkSearch.filter(params)
          render json: { homeworks: homeworks }
        end
  
        private
  
        def find_homework
          @homework = Homework.find(params[:id])
        end
  
        def review_params
          params.require(:homework).permit(:grade, :teacher_note, :teacher_id).merge(graded_at: Time.current)
        end
      end
    end
  end
  