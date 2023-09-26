class CreateHomeworks < ActiveRecord::Migration[7.0]
  def change
    create_table :homeworks do |t|
      t.string :assignment_name
      t.string :student_name
      t.datetime :submitted_at
      t.datetime :graded_at
      t.integer :grade, default: 0 # default set to "ungraded"
      t.text :teacher_note

      t.timestamps
    end
  end
end
