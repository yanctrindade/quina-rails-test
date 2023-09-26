class HomeworkSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :assignment_name, :student_name, :submitted_at, :graded_at, :grade, :teacher_note
  has_one :student
  has_one :teacher
  attribute :attachment_url do
    if object.attachment.attached?
      rails_blob_url(object.attachment, only_path: false)
    end
  end
end