module Api
  module V1
    class HomeworkSubmissionsController < ApplicationController
      before_action :find_student

      def create
        homework = @student.homeworks.build(homework_submission_params)
        if homework.save
          render json: homework, status: :created # Rails will use the serializer here
        else
          render json: { status: 'error', message: homework.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        homeworks = @student.homeworks
        render json: { data: homeworks }, status: :ok
      end

      def search
        homeworks = Api::V1::HomeworkSearch.filter(params).where(student: @student)
        render json: { homeworks: homeworks }
      end

      private

      def find_student
        @student = Student.find(params[:student_id])
      end

      def homework_submission_params
        params.require(:homework).permit(:assignment_name, :attachment)
      end
    end
  end
end
