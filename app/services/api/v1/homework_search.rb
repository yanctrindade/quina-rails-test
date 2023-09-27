module Api
    module V1
      class HomeworkSearch
        def self.filter(params)
            homeworks = Homework.all

            # For students
            if params[:grade].present?
            homeworks = homeworks.where(grade: params[:grade])
            end

            if params[:assignment_name].present?
            homeworks = homeworks.where('assignment_name LIKE ?', "%#{params[:assignment_name]}%")
            end

            # For teachers
            if params[:from_date].present? && params[:to_date].present?
            from_date = Date.parse(params[:from_date])
            to_date = Date.parse(params[:to_date])
            homeworks = homeworks.where(submitted_at: from_date..to_date)
            end

            if params[:student_name].present?
            homeworks = homeworks.joins(:student).where('students.name LIKE ?', "%#{params[:student_name]}%")
            end

            homeworks
        end
      end
    end
  end
  