class AddStudentAndTeacherToHomeworks < ActiveRecord::Migration[7.0]
  def change
    add_reference :homeworks, :student, null: true, foreign_key: true
    add_reference :homeworks, :teacher, null: true, foreign_key: true
  end
end
